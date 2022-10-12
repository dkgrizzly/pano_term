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

`include "i2c_defs.v"

module i2c_master_axil
//-----------------------------------------------------------------
// Params
//-----------------------------------------------------------------
#(
    parameter DEFAULT_DIVIDER = 16'd99
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

    ,inout            i2c0_scl
    ,inout            i2c0_sda

    ,inout            i2c1_scl
    ,inout            i2c1_sda

    ,inout            i2c2_scl
    ,inout            i2c2_sda

    ,inout            i2c3_scl
    ,inout            i2c3_sda
);


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
reg [15:0] wr_data_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    wr_data_q <= 16'b0;
else if (cfg_wvalid_i && cfg_wready_o)
    wr_data_q <= cfg_wdata_i[15:0];

wire [15:0] wr_data_w = wvalid_q ? wr_data_q : cfg_wdata_i[15:0];


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
// Register I2C_CMD_STATUS
//-----------------------------------------------------------------
wire i2c_busy;
wire i2c_nack;
reg i2c_enable = 1'b0;
reg i2c_rw = 1'b0;
reg [1:0] i2c_bus_addr = 2'h0;
reg [6:0] i2c_device_addr = 7'h0;
reg [7:0] i2c_reg_addr = 8'h0;
reg [7:0] i2c_mosi_data = 8'h0;
reg [15:0] i2c_divider = DEFAULT_DIVIDER;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    begin
        i2c_enable      <= 1'b0;
        i2c_rw          <= 1'b0;
        i2c_bus_addr    <= 8'h0;
        i2c_device_addr <= 8'h0;
        i2c_reg_addr    <= 8'h0;
        i2c_mosi_data   <= 8'h0;
        i2c_divider     <= DEFAULT_DIVIDER;
    end
else if(write_en_w)
    begin
        case (wr_addr_w[7:0])
        `I2C_CMD_STATUS:
        begin
            i2c_enable <= wr_data_w[`I2C_CMD_ENABLE];
            i2c_rw     <= wr_data_w[`I2C_CMD_RW];
        end

        `I2C_BUS:
            i2c_bus_addr <= wr_data_w[`I2C_BUS_R];

        `I2C_DEVICE:
            i2c_device_addr <= wr_data_w[`I2C_DEVICE_R];

        `I2C_ADDRESS:
            i2c_reg_addr <= wr_data_w[`I2C_ADDRESS_R];

        `I2C_DATA:
            i2c_mosi_data <= wr_data_w[`I2C_DATA_R];

        `I2C_DIVIDER:
            i2c_divider <= wr_data_w[`I2C_DIVIDER_R];

        endcase
    end



//-----------------------------------------------------------------
// Read mux
//-----------------------------------------------------------------
reg [31:0] data_r;
wire [7:0] i2c_miso_data;

always @ *
begin
    data_r = 32'b0;

    case (cfg_araddr_i[7:0])

    `I2C_CMD_STATUS:
        begin
            data_r[`I2C_CMD_ENABLE] = i2c_enable;
            data_r[`I2C_CMD_RW] = i2c_rw;
            data_r[`I2C_STATUS_BUSY] = i2c_busy;
            data_r[`I2C_STATUS_NACK] = i2c_nack;
        end
    `I2C_BUS:
        data_r[`I2C_BUS_R] = i2c_bus_addr;
    `I2C_DEVICE:
        data_r[`I2C_DEVICE_R] = i2c_device_addr;
    `I2C_ADDRESS:
        data_r[`I2C_ADDRESS_R] = i2c_reg_addr;
    `I2C_DATA:
        data_r[`I2C_DATA_R] = i2c_miso_data;
    `I2C_DIVIDER:
        data_r[`I2C_DIVIDER_R] = i2c_divider;
    default :
        data_r = 32'b0;
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



i2c_master i2c_controller(
     .i_clk(clk_i)
    ,.i_rst(rst_i)
    ,.i_enable(i2c_enable)
    ,.i_rw(i2c_rw)
    ,.i_bus(i2c_bus_addr)
    ,.i_divider(i2c_divider)
    ,.i_device_addr(i2c_device_addr)
    ,.i_reg_addr(i2c_reg_addr)
    ,.i_mosi_data(i2c_mosi_data)
    ,.o_miso_data(i2c_miso_data)
    ,.o_busy(i2c_busy)
    ,.o_nack(i2c_nack)

    ,.io_scl0(i2c0_scl)
    ,.io_sda0(i2c0_sda)

    ,.io_scl1(i2c1_scl)
    ,.io_sda1(i2c1_sda)

    ,.io_scl2(i2c2_scl)
    ,.io_sda2(i2c2_sda)

    ,.io_scl3(i2c3_scl)
    ,.io_sda3(i2c3_sda)
);

endmodule

