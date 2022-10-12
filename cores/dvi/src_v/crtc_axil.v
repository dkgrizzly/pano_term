//---------------------------------------------------------------------
// This file is open source HDL; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this file.  If not, see <https://www.gnu.org/licenses/>.
//---------------------------------------------------------------------

`include "crtc_defs.v"

module crtc_axil
//-----------------------------------------------------------------
// Params
//-----------------------------------------------------------------
#(
// 1920x1080 - 148.5 MHz
     parameter DEFAULT_H_ACTIVE = 1920
    ,parameter DEFAULT_H_FRONT_W = 88
    ,parameter DEFAULT_H_SYNC_W = 44
    ,parameter DEFAULT_H_BACK_W = 148
    ,parameter DEFAULT_H_SYNC_PN = 0
    ,parameter DEFAULT_V_ACTIVE = 1080
    ,parameter DEFAULT_V_FRONT_W = 4
    ,parameter DEFAULT_V_SYNC_W = 5
    ,parameter DEFAULT_V_BACK_W = 36
    ,parameter DEFAULT_V_SYNC_PN = 0
//
// 1680x1050 - 146.25 MHz
//     parameter DEFAULT_H_ACTIVE = 1680
//    ,parameter DEFAULT_H_FRONT_W = 104
//    ,parameter DEFAULT_H_SYNC_W = 176
//    ,parameter DEFAULT_H_BACK_W = 280
//    ,parameter DEFAULT_H_SYNC_PN = 1
//    ,parameter DEFAULT_V_ACTIVE = 1050
//    ,parameter DEFAULT_V_FRONT_W = 3
//    ,parameter DEFAULT_V_SYNC_W = 6
//    ,parameter DEFAULT_V_BACK_W = 30
//    ,parameter DEFAULT_V_SYNC_PN = 0
)
//-----------------------------------------------------------------
// Ports
//-----------------------------------------------------------------
(
     input          clk_i
    ,input          rst_i

    ,input          cfg_awvalid_i
    ,input  [31:0]  cfg_awaddr_i
    ,input          cfg_wvalid_i
    ,input  [31:0]  cfg_wdata_i
    ,input   [3:0]  cfg_wstrb_i
    ,input          cfg_bready_i
    ,input          cfg_arvalid_i
    ,input  [31:0]  cfg_araddr_i
    ,input          cfg_rready_i

    ,output         cfg_awready_o
    ,output         cfg_wready_o
    ,output         cfg_bvalid_o
    ,output  [1:0]  cfg_bresp_o
    ,output         cfg_arready_o
    ,output         cfg_rvalid_o
    ,output [31:0]  cfg_rdata_o
    ,output  [1:0]  cfg_rresp_o

    // Video Clock Domain
    ,input          pclk_i
    ,input          prst_i
    ,output         vsync_o
    ,output         hsync_o
    ,output         valid_o
    ,output  [11:0] x_o
    ,output  [11:0] y_o

    ,output         vinvert_o
    ,output         hinvert_o
);

wire [11:0] raw_x_o;
wire [11:0] raw_y_o;

reg crtc_enable = 1'b1;
reg [11:0] ha_r = DEFAULT_H_ACTIVE;
reg [11:0] hfw_r = DEFAULT_H_FRONT_W;
reg [11:0] hsw_r = DEFAULT_H_SYNC_W;
reg [11:0] hbw_r = DEFAULT_H_BACK_W;
reg        hspn_r = DEFAULT_H_SYNC_PN;
assign     hinvert_o = hspn_r;

reg [11:0] va_r = DEFAULT_V_ACTIVE;
reg [11:0] vfw_r = DEFAULT_V_FRONT_W;
reg [11:0] vsw_r = DEFAULT_V_SYNC_W;
reg [11:0] vbw_r = DEFAULT_V_BACK_W;
reg        vspn_r = DEFAULT_V_SYNC_PN;
assign     vinvert_o = vspn_r;


//-----------------------------------------------------------------
// Write address / data split
//-----------------------------------------------------------------

// Address but no data ready
reg awvalid_q;

// Data but no data ready
reg wvalid_q;

wire wr_cmd_accepted_w  = (cfg_awvalid_i && cfg_awready_o) || awvalid_q;
wire wr_data_accepted_w = (cfg_wvalid_i  && cfg_wready_o)  || wvalid_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    awvalid_q <= 1'b0;
else if (cfg_awvalid_i && cfg_awready_o && !wr_data_accepted_w)
    awvalid_q <= 1'b1;
else if (wr_data_accepted_w)
    awvalid_q <= 1'b0;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    wvalid_q <= 1'b0;
else if (cfg_wvalid_i && cfg_wready_o && !wr_cmd_accepted_w)
    wvalid_q <= 1'b1;
else if (wr_cmd_accepted_w)
    wvalid_q <= 1'b0;


//-----------------------------------------------------------------
// Capture address (for delayed data)
//-----------------------------------------------------------------
reg [7:0] wr_addr_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    wr_addr_q <= 8'b0;
else if (cfg_awvalid_i && cfg_awready_o)
    wr_addr_q <= cfg_awaddr_i[7:0];

wire [7:0] wr_addr_w = awvalid_q ? wr_addr_q : cfg_awaddr_i[7:0];


//-----------------------------------------------------------------
// Retime write data
//-----------------------------------------------------------------
reg [31:0] wr_data_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    wr_data_q <= 32'b0;
else if (cfg_wvalid_i && cfg_wready_o)
    wr_data_q <= cfg_wdata_i[31:0];

wire [31:0] wr_data_w = wvalid_q ? wr_data_q : cfg_wdata_i[31:0];


//-----------------------------------------------------------------
// Request Logic
//-----------------------------------------------------------------
wire read_en_w  = cfg_arvalid_i & cfg_arready_o;
wire write_en_w = wr_cmd_accepted_w && wr_data_accepted_w;


//-----------------------------------------------------------------
// Accept Logic
//-----------------------------------------------------------------
assign cfg_arready_o = ~cfg_rvalid_o;
assign cfg_awready_o = ~cfg_bvalid_o && ~cfg_arvalid_i && ~awvalid_q;
assign cfg_wready_o  = ~cfg_bvalid_o && ~cfg_arvalid_i && ~wvalid_q;


//-----------------------------------------------------------------
// Register CRTC_CONTROL
//-----------------------------------------------------------------

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    begin
        crtc_enable <= 1'b1;
        ha_r <= DEFAULT_H_ACTIVE;
        hfw_r <= DEFAULT_H_FRONT_W;
        hsw_r <= DEFAULT_H_SYNC_W;
        hbw_r <= DEFAULT_H_BACK_W;
        hspn_r <= DEFAULT_H_SYNC_PN;
        va_r <= DEFAULT_V_ACTIVE;
        vfw_r <= DEFAULT_V_FRONT_W;
        vsw_r <= DEFAULT_V_SYNC_W;
        vbw_r <= DEFAULT_V_BACK_W;
        vspn_r <= DEFAULT_V_SYNC_PN;
    end
else if(write_en_w)
    begin
        case (wr_addr_w[7:0])
        `CRTC_CONTROL:
            begin
                crtc_enable <= wr_data_w[`CRTC_ENABLE];
                hspn_r <= wr_data_w[`CRTC_HSPN_R];
                vspn_r <= wr_data_w[`CRTC_VSPN_R];
            end

        `CRTC_VACTIVE:
            va_r <= wr_data_w[`CRTC_VACTIVE_R];

        `CRTC_VFW:
            vfw_r <= wr_data_w[`CRTC_VFW_R];

        `CRTC_VSW:
            vsw_r <= wr_data_w[`CRTC_VSW_R];

        `CRTC_VBW:
            vbw_r <= wr_data_w[`CRTC_VBW_R];

        `CRTC_HACTIVE:
            ha_r <= wr_data_w[`CRTC_HACTIVE_R];

        `CRTC_HFW:
            hfw_r <= wr_data_w[`CRTC_HFW_R];

        `CRTC_HSW:
            hsw_r <= wr_data_w[`CRTC_HSW_R];

        `CRTC_HBW:
            hbw_r <= wr_data_w[`CRTC_HBW_R];

        endcase
    end



//-----------------------------------------------------------------
// Read mux
//-----------------------------------------------------------------
reg [31:0] data_r;
wire [7:0] i2c_miso_data;

always @ *
begin
    data_r <= 32'b0;

    case (cfg_araddr_i[7:0])

    `CRTC_CONTROL:
        begin
            data_r[`CRTC_ENABLE] <= crtc_enable;
            data_r[`CRTC_HSPN_R] <= hspn_r;
            data_r[`CRTC_VSPN_R] <= vspn_r;
        end

    `CRTC_YSCAN:
        begin
            data_r[`CRTC_YSCAN_R] <= raw_y_o;
            data_r[`CRTC_YPIXEL_R] <= y_o;
        end

    `CRTC_XSCAN:
        begin
            data_r[`CRTC_XSCAN_R] <= raw_x_o;
            data_r[`CRTC_XPIXEL_R] <= x_o;
        end

    `CRTC_VACTIVE:
        data_r[`CRTC_VACTIVE_R] <= va_r;

    `CRTC_VFW:
        data_r[`CRTC_VFW_R] <= vfw_r;

    `CRTC_VSW:
        data_r[`CRTC_VSW_R] <= vsw_r;

    `CRTC_VBW:
        data_r[`CRTC_VBW_R] <= vbw_r;

    `CRTC_HACTIVE:
        data_r[`CRTC_HACTIVE_R] <= ha_r;

    `CRTC_HFW:
        data_r[`CRTC_HFW_R] <= hfw_r;

    `CRTC_HSW:
        data_r[`CRTC_HSW_R] <= hsw_r;

    `CRTC_HBW:
        data_r[`CRTC_HBW_R] <= hbw_r;

    default :
        data_r <= 32'b0;
    endcase
end


//-----------------------------------------------------------------
// RVALID
//-----------------------------------------------------------------
reg rvalid_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rvalid_q <= 1'b0;
else if (read_en_w)
    rvalid_q <= 1'b1;
else if (cfg_rready_i)
    rvalid_q <= 1'b0;

assign cfg_rvalid_o = rvalid_q;


//-----------------------------------------------------------------
// Retime read response
//-----------------------------------------------------------------
reg [31:0] rd_data_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rd_data_q <= 32'b0;
else if (!cfg_rvalid_o || cfg_rready_i)
    rd_data_q <= data_r;

assign cfg_rdata_o = rd_data_q;
assign cfg_rresp_o = 2'b0;


//-----------------------------------------------------------------
// BVALID
//-----------------------------------------------------------------
reg bvalid_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    bvalid_q <= 1'b0;
else if (write_en_w)
    bvalid_q <= 1'b1;
else if (cfg_bready_i)
    bvalid_q <= 1'b0;

assign cfg_bvalid_o = bvalid_q;
assign cfg_bresp_o  = 2'b0;

crtc crtc(
     .clk_i
    ,.rst_i

    ,.enable_i(crtc_enable)

    ,.va_i(va_r)
    ,.vfw_i(vfw_r)
    ,.vsw_i(vsw_r)
    ,.vbw_i(vbw_r)

    ,.ha_i(ha_r)
    ,.hfw_i(hfw_r)
    ,.hsw_i(hsw_r)
    ,.hbw_i(hbw_r)

    ,.pclk_i(pclk_i)
    ,.prst_i(prst_i)
    ,.vsync_o(vsync_o)
    ,.hsync_o(hsync_o)
    ,.valid_o(valid_o)
    ,.x_o(x_o)
    ,.y_o(y_o)
    ,.raw_x_o(raw_x_o)
    ,.raw_y_o(raw_y_o)
);

endmodule

