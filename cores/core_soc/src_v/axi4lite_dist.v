//-----------------------------------------------------------------
//                     Basic Peripheral SoC
//                           V1.1
//                     Ultra-Embedded.com
//                     Copyright 2014-2020
//
//                 Email: admin@ultra-embedded.com
//
//                         License: GPL
// If you would like a version with a more permissive license for
// use in closed source commercial applications please contact me
// for details.
//-----------------------------------------------------------------
//
// This file is open source HDL; you can redistribute it and/or 
// modify it under the terms of the GNU General Public License as 
// published by the Free Software Foundation; either version 2 of 
// the License, or (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public 
// License along with this file; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
// USA
//-----------------------------------------------------------------

//-----------------------------------------------------------------
//                          Generated File
//-----------------------------------------------------------------

module axi4lite_dist
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           inport_awvalid_i
    ,input  [ 31:0]  inport_awaddr_i
    ,input           inport_wvalid_i
    ,input  [ 31:0]  inport_wdata_i
    ,input  [  3:0]  inport_wstrb_i
    ,input           inport_bready_i
    ,input           inport_arvalid_i
    ,input  [ 31:0]  inport_araddr_i
    ,input           inport_rready_i
    ,input           outport0_awready_i
    ,input           outport0_wready_i
    ,input           outport0_bvalid_i
    ,input  [  1:0]  outport0_bresp_i
    ,input           outport0_arready_i
    ,input           outport0_rvalid_i
    ,input  [ 31:0]  outport0_rdata_i
    ,input  [  1:0]  outport0_rresp_i
    ,input           outport1_awready_i
    ,input           outport1_wready_i
    ,input           outport1_bvalid_i
    ,input  [  1:0]  outport1_bresp_i
    ,input           outport1_arready_i
    ,input           outport1_rvalid_i
    ,input  [ 31:0]  outport1_rdata_i
    ,input  [  1:0]  outport1_rresp_i
    ,input           outport2_awready_i
    ,input           outport2_wready_i
    ,input           outport2_bvalid_i
    ,input  [  1:0]  outport2_bresp_i
    ,input           outport2_arready_i
    ,input           outport2_rvalid_i
    ,input  [ 31:0]  outport2_rdata_i
    ,input  [  1:0]  outport2_rresp_i
    ,input           outport3_awready_i
    ,input           outport3_wready_i
    ,input           outport3_bvalid_i
    ,input  [  1:0]  outport3_bresp_i
    ,input           outport3_arready_i
    ,input           outport3_rvalid_i
    ,input  [ 31:0]  outport3_rdata_i
    ,input  [  1:0]  outport3_rresp_i
    ,input           outport4_awready_i
    ,input           outport4_wready_i
    ,input           outport4_bvalid_i
    ,input  [  1:0]  outport4_bresp_i
    ,input           outport4_arready_i
    ,input           outport4_rvalid_i
    ,input  [ 31:0]  outport4_rdata_i
    ,input  [  1:0]  outport4_rresp_i
    ,input           outport5_awready_i
    ,input           outport5_wready_i
    ,input           outport5_bvalid_i
    ,input  [  1:0]  outport5_bresp_i
    ,input           outport5_arready_i
    ,input           outport5_rvalid_i
    ,input  [ 31:0]  outport5_rdata_i
    ,input  [  1:0]  outport5_rresp_i
    ,input           outport6_awready_i
    ,input           outport6_wready_i
    ,input           outport6_bvalid_i
    ,input  [  1:0]  outport6_bresp_i
    ,input           outport6_arready_i
    ,input           outport6_rvalid_i
    ,input  [ 31:0]  outport6_rdata_i
    ,input  [  1:0]  outport6_rresp_i
    ,input           outport7_awready_i
    ,input           outport7_wready_i
    ,input           outport7_bvalid_i
    ,input  [  1:0]  outport7_bresp_i
    ,input           outport7_arready_i
    ,input           outport7_rvalid_i
    ,input  [ 31:0]  outport7_rdata_i
    ,input  [  1:0]  outport7_rresp_i
    ,input           outport8_awready_i
    ,input           outport8_wready_i
    ,input           outport8_bvalid_i
    ,input  [  1:0]  outport8_bresp_i
    ,input           outport8_arready_i
    ,input           outport8_rvalid_i
    ,input  [ 31:0]  outport8_rdata_i
    ,input  [  1:0]  outport8_rresp_i
    ,input           outport9_awready_i
    ,input           outport9_wready_i
    ,input           outport9_bvalid_i
    ,input  [  1:0]  outport9_bresp_i
    ,input           outport9_arready_i
    ,input           outport9_rvalid_i
    ,input  [ 31:0]  outport9_rdata_i
    ,input  [  1:0]  outport9_rresp_i
    ,input           outportA_awready_i
    ,input           outportA_wready_i
    ,input           outportA_bvalid_i
    ,input  [  1:0]  outportA_bresp_i
    ,input           outportA_arready_i
    ,input           outportA_rvalid_i
    ,input  [ 31:0]  outportA_rdata_i
    ,input  [  1:0]  outportA_rresp_i
    ,input           outportB_awready_i
    ,input           outportB_wready_i
    ,input           outportB_bvalid_i
    ,input  [  1:0]  outportB_bresp_i
    ,input           outportB_arready_i
    ,input           outportB_rvalid_i
    ,input  [ 31:0]  outportB_rdata_i
    ,input  [  1:0]  outportB_rresp_i
    ,input           outportC_awready_i
    ,input           outportC_wready_i
    ,input           outportC_bvalid_i
    ,input  [  1:0]  outportC_bresp_i
    ,input           outportC_arready_i
    ,input           outportC_rvalid_i
    ,input  [ 31:0]  outportC_rdata_i
    ,input  [  1:0]  outportC_rresp_i
    ,input           outportD_awready_i
    ,input           outportD_wready_i
    ,input           outportD_bvalid_i
    ,input  [  1:0]  outportD_bresp_i
    ,input           outportD_arready_i
    ,input           outportD_rvalid_i
    ,input  [ 31:0]  outportD_rdata_i
    ,input  [  1:0]  outportD_rresp_i
    ,input           outportE_awready_i
    ,input           outportE_wready_i
    ,input           outportE_bvalid_i
    ,input  [  1:0]  outportE_bresp_i
    ,input           outportE_arready_i
    ,input           outportE_rvalid_i
    ,input  [ 31:0]  outportE_rdata_i
    ,input  [  1:0]  outportE_rresp_i
    ,input           outportF_awready_i
    ,input           outportF_wready_i
    ,input           outportF_bvalid_i
    ,input  [  1:0]  outportF_bresp_i
    ,input           outportF_arready_i
    ,input           outportF_rvalid_i
    ,input  [ 31:0]  outportF_rdata_i
    ,input  [  1:0]  outportF_rresp_i

    // Outputs
    ,output          inport_awready_o
    ,output          inport_wready_o
    ,output          inport_bvalid_o
    ,output [  1:0]  inport_bresp_o
    ,output          inport_arready_o
    ,output          inport_rvalid_o
    ,output [ 31:0]  inport_rdata_o
    ,output [  1:0]  inport_rresp_o
    ,output          outport0_awvalid_o
    ,output [ 31:0]  outport0_awaddr_o
    ,output          outport0_wvalid_o
    ,output [ 31:0]  outport0_wdata_o
    ,output [  3:0]  outport0_wstrb_o
    ,output          outport0_bready_o
    ,output          outport0_arvalid_o
    ,output [ 31:0]  outport0_araddr_o
    ,output          outport0_rready_o
    ,output          outport1_awvalid_o
    ,output [ 31:0]  outport1_awaddr_o
    ,output          outport1_wvalid_o
    ,output [ 31:0]  outport1_wdata_o
    ,output [  3:0]  outport1_wstrb_o
    ,output          outport1_bready_o
    ,output          outport1_arvalid_o
    ,output [ 31:0]  outport1_araddr_o
    ,output          outport1_rready_o
    ,output          outport2_awvalid_o
    ,output [ 31:0]  outport2_awaddr_o
    ,output          outport2_wvalid_o
    ,output [ 31:0]  outport2_wdata_o
    ,output [  3:0]  outport2_wstrb_o
    ,output          outport2_bready_o
    ,output          outport2_arvalid_o
    ,output [ 31:0]  outport2_araddr_o
    ,output          outport2_rready_o
    ,output          outport3_awvalid_o
    ,output [ 31:0]  outport3_awaddr_o
    ,output          outport3_wvalid_o
    ,output [ 31:0]  outport3_wdata_o
    ,output [  3:0]  outport3_wstrb_o
    ,output          outport3_bready_o
    ,output          outport3_arvalid_o
    ,output [ 31:0]  outport3_araddr_o
    ,output          outport3_rready_o
    ,output          outport4_awvalid_o
    ,output [ 31:0]  outport4_awaddr_o
    ,output          outport4_wvalid_o
    ,output [ 31:0]  outport4_wdata_o
    ,output [  3:0]  outport4_wstrb_o
    ,output          outport4_bready_o
    ,output          outport4_arvalid_o
    ,output [ 31:0]  outport4_araddr_o
    ,output          outport4_rready_o
    ,output          outport5_awvalid_o
    ,output [ 31:0]  outport5_awaddr_o
    ,output          outport5_wvalid_o
    ,output [ 31:0]  outport5_wdata_o
    ,output [  3:0]  outport5_wstrb_o
    ,output          outport5_bready_o
    ,output          outport5_arvalid_o
    ,output [ 31:0]  outport5_araddr_o
    ,output          outport5_rready_o
    ,output          outport6_awvalid_o
    ,output [ 31:0]  outport6_awaddr_o
    ,output          outport6_wvalid_o
    ,output [ 31:0]  outport6_wdata_o
    ,output [  3:0]  outport6_wstrb_o
    ,output          outport6_bready_o
    ,output          outport6_arvalid_o
    ,output [ 31:0]  outport6_araddr_o
    ,output          outport6_rready_o
    ,output          outport7_awvalid_o
    ,output [ 31:0]  outport7_awaddr_o
    ,output          outport7_wvalid_o
    ,output [ 31:0]  outport7_wdata_o
    ,output [  3:0]  outport7_wstrb_o
    ,output          outport7_bready_o
    ,output          outport7_arvalid_o
    ,output [ 31:0]  outport7_araddr_o
    ,output          outport7_rready_o
    ,output          outport8_awvalid_o
    ,output [ 31:0]  outport8_awaddr_o
    ,output          outport8_wvalid_o
    ,output [ 31:0]  outport8_wdata_o
    ,output [  3:0]  outport8_wstrb_o
    ,output          outport8_bready_o
    ,output          outport8_arvalid_o
    ,output [ 31:0]  outport8_araddr_o
    ,output          outport8_rready_o
    ,output          outport9_awvalid_o
    ,output [ 31:0]  outport9_awaddr_o
    ,output          outport9_wvalid_o
    ,output [ 31:0]  outport9_wdata_o
    ,output [  3:0]  outport9_wstrb_o
    ,output          outport9_bready_o
    ,output          outport9_arvalid_o
    ,output [ 31:0]  outport9_araddr_o
    ,output          outport9_rready_o
    ,output          outportA_awvalid_o
    ,output [ 31:0]  outportA_awaddr_o
    ,output          outportA_wvalid_o
    ,output [ 31:0]  outportA_wdata_o
    ,output [  3:0]  outportA_wstrb_o
    ,output          outportA_bready_o
    ,output          outportA_arvalid_o
    ,output [ 31:0]  outportA_araddr_o
    ,output          outportA_rready_o
    ,output          outportB_awvalid_o
    ,output [ 31:0]  outportB_awaddr_o
    ,output          outportB_wvalid_o
    ,output [ 31:0]  outportB_wdata_o
    ,output [  3:0]  outportB_wstrb_o
    ,output          outportB_bready_o
    ,output          outportB_arvalid_o
    ,output [ 31:0]  outportB_araddr_o
    ,output          outportB_rready_o
    ,output          outportC_awvalid_o
    ,output [ 31:0]  outportC_awaddr_o
    ,output          outportC_wvalid_o
    ,output [ 31:0]  outportC_wdata_o
    ,output [  3:0]  outportC_wstrb_o
    ,output          outportC_bready_o
    ,output          outportC_arvalid_o
    ,output [ 31:0]  outportC_araddr_o
    ,output          outportC_rready_o
    ,output          outportD_awvalid_o
    ,output [ 31:0]  outportD_awaddr_o
    ,output          outportD_wvalid_o
    ,output [ 31:0]  outportD_wdata_o
    ,output [  3:0]  outportD_wstrb_o
    ,output          outportD_bready_o
    ,output          outportD_arvalid_o
    ,output [ 31:0]  outportD_araddr_o
    ,output          outportD_rready_o
    ,output          outportE_awvalid_o
    ,output [ 31:0]  outportE_awaddr_o
    ,output          outportE_wvalid_o
    ,output [ 31:0]  outportE_wdata_o
    ,output [  3:0]  outportE_wstrb_o
    ,output          outportE_bready_o
    ,output          outportE_arvalid_o
    ,output [ 31:0]  outportE_araddr_o
    ,output          outportE_rready_o
    ,output          outportF_awvalid_o
    ,output [ 31:0]  outportF_awaddr_o
    ,output          outportF_wvalid_o
    ,output [ 31:0]  outportF_wdata_o
    ,output [  3:0]  outportF_wstrb_o
    ,output          outportF_bready_o
    ,output          outportF_arvalid_o
    ,output [ 31:0]  outportF_araddr_o
    ,output          outportF_rready_o
);



//-----------------------------------------------------------------
// Read Dist
//-----------------------------------------------------------------
reg [3:0] read_sel_r;
reg [3:0] read_sel_q;
reg read_pending_q;
reg read_pending_r;

always @ *
begin
    read_pending_r = read_pending_q;

    // Read response
    if (inport_rvalid_o && inport_rready_i)
        read_pending_r = 1'b0;
    // New request
    else if (!read_pending_r && inport_arvalid_i)
        read_pending_r = inport_arready_o;

    // Address to port selection
    if (!read_pending_q)
        read_sel_r  = inport_araddr_i[27:24];
    else
        read_sel_r  = read_sel_q;
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    read_sel_q      <= 4'b0;
    read_pending_q  <= 1'b0;
end
else
begin
    read_sel_q      <= read_sel_r;
    read_pending_q  <= read_pending_r;
end

//-----------------------------------------------------------------
// Read Request
//-----------------------------------------------------------------
assign outport0_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'h0) && !read_pending_q;
assign outport0_araddr_o  =  inport_araddr_i;
assign outport1_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'h1) && !read_pending_q;
assign outport1_araddr_o  =  inport_araddr_i;
assign outport2_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'h2) && !read_pending_q;
assign outport2_araddr_o  =  inport_araddr_i;
assign outport3_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'h3) && !read_pending_q;
assign outport3_araddr_o  =  inport_araddr_i;
assign outport4_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'h4) && !read_pending_q;
assign outport4_araddr_o  =  inport_araddr_i;
assign outport5_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'h5) && !read_pending_q;
assign outport5_araddr_o  =  inport_araddr_i;
assign outport6_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'h6) && !read_pending_q;
assign outport6_araddr_o  =  inport_araddr_i;
assign outport7_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'h7) && !read_pending_q;
assign outport7_araddr_o  =  inport_araddr_i;
assign outport8_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'h8) && !read_pending_q;
assign outport8_araddr_o  =  inport_araddr_i;
assign outport9_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'h9) && !read_pending_q;
assign outport9_araddr_o  =  inport_araddr_i;
assign outportA_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'hA) && !read_pending_q;
assign outportA_araddr_o  =  inport_araddr_i;
assign outportB_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'hB) && !read_pending_q;
assign outportB_araddr_o  =  inport_araddr_i;
assign outportC_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'hC) && !read_pending_q;
assign outportC_araddr_o  =  inport_araddr_i;
assign outportD_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'hD) && !read_pending_q;
assign outportD_araddr_o  =  inport_araddr_i;
assign outportE_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'hE) && !read_pending_q;
assign outportE_araddr_o  =  inport_araddr_i;
assign outportF_arvalid_o =  inport_arvalid_i && (read_sel_r == 4'hF) && !read_pending_q;
assign outportF_araddr_o  =  inport_araddr_i;

//-----------------------------------------------------------------
// Read Request Accept
//-----------------------------------------------------------------
reg inport_arready_r;

always @ *
begin
    inport_arready_r  = 1'b0;

    case (read_sel_r)
    4'h0:
        inport_arready_r = outport0_arready_i;
    4'h1:
        inport_arready_r = outport1_arready_i;
    4'h2:
        inport_arready_r = outport2_arready_i;
    4'h3:
        inport_arready_r = outport3_arready_i;
    4'h4:
        inport_arready_r = outport4_arready_i;
    4'h5:
        inport_arready_r = outport5_arready_i;
    4'h6:
        inport_arready_r = outport6_arready_i;
    4'h7:
        inport_arready_r = outport7_arready_i;
    4'h8:
        inport_arready_r = outport8_arready_i;
    4'h9:
        inport_arready_r = outport9_arready_i;
    4'hA:
        inport_arready_r = outportA_arready_i;
    4'hB:
        inport_arready_r = outportB_arready_i;
    4'hC:
        inport_arready_r = outportC_arready_i;
    4'hD:
        inport_arready_r = outportD_arready_i;
    4'hE:
        inport_arready_r = outportE_arready_i;
    4'hF:
        inport_arready_r = outportF_arready_i;
    default :
        ;
    endcase
end

assign inport_arready_o = inport_arready_r && !read_pending_q;

//-----------------------------------------------------------------
// Read Response
//-----------------------------------------------------------------
reg        inport_rvalid_r;
reg [31:0] inport_rdata_r;
reg [1:0]  inport_rresp_r;

always @ *
begin
    inport_rvalid_r  = 1'b0;
    inport_rdata_r   = 32'b0;
    inport_rresp_r   = 2'b0;

    case (read_sel_q)
    4'h0:
    begin
        inport_rvalid_r = outport0_rvalid_i;
        inport_rdata_r  = outport0_rdata_i;
        inport_rresp_r  = outport0_rresp_i;
    end
    4'h1:
    begin
        inport_rvalid_r = outport1_rvalid_i;
        inport_rdata_r  = outport1_rdata_i;
        inport_rresp_r  = outport1_rresp_i;
    end
    4'h2:
    begin
        inport_rvalid_r = outport2_rvalid_i;
        inport_rdata_r  = outport2_rdata_i;
        inport_rresp_r  = outport2_rresp_i;
    end
    4'h3:
    begin
        inport_rvalid_r = outport3_rvalid_i;
        inport_rdata_r  = outport3_rdata_i;
        inport_rresp_r  = outport3_rresp_i;
    end
    4'h4:
    begin
        inport_rvalid_r = outport4_rvalid_i;
        inport_rdata_r  = outport4_rdata_i;
        inport_rresp_r  = outport4_rresp_i;
    end
    4'h5:
    begin
        inport_rvalid_r = outport5_rvalid_i;
        inport_rdata_r  = outport5_rdata_i;
        inport_rresp_r  = outport5_rresp_i;
    end
    4'h6:
    begin
        inport_rvalid_r = outport6_rvalid_i;
        inport_rdata_r  = outport6_rdata_i;
        inport_rresp_r  = outport6_rresp_i;
    end
    4'h7:
    begin
        inport_rvalid_r = outport7_rvalid_i;
        inport_rdata_r  = outport7_rdata_i;
        inport_rresp_r  = outport7_rresp_i;
    end
    4'h8:
    begin
        inport_rvalid_r = outport8_rvalid_i;
        inport_rdata_r  = outport8_rdata_i;
        inport_rresp_r  = outport8_rresp_i;
    end
    4'h9:
    begin
        inport_rvalid_r = outport9_rvalid_i;
        inport_rdata_r  = outport9_rdata_i;
        inport_rresp_r  = outport9_rresp_i;
    end
    4'hA:
    begin
        inport_rvalid_r = outportA_rvalid_i;
        inport_rdata_r  = outportA_rdata_i;
        inport_rresp_r  = outportA_rresp_i;
    end
    4'hB:
    begin
        inport_rvalid_r = outportB_rvalid_i;
        inport_rdata_r  = outportB_rdata_i;
        inport_rresp_r  = outportB_rresp_i;
    end
    4'hC:
    begin
        inport_rvalid_r = outportC_rvalid_i;
        inport_rdata_r  = outportC_rdata_i;
        inport_rresp_r  = outportC_rresp_i;
    end
    4'hD:
    begin
        inport_rvalid_r = outportD_rvalid_i;
        inport_rdata_r  = outportD_rdata_i;
        inport_rresp_r  = outportD_rresp_i;
    end
    4'hE:
    begin
        inport_rvalid_r = outportE_rvalid_i;
        inport_rdata_r  = outportE_rdata_i;
        inport_rresp_r  = outportE_rresp_i;
    end
    4'hF:
    begin
        inport_rvalid_r = outportF_rvalid_i;
        inport_rdata_r  = outportF_rdata_i;
        inport_rresp_r  = outportF_rresp_i;
    end
    default :
        ;
    endcase
end

assign inport_rvalid_o = inport_rvalid_r;
assign inport_rdata_o  = inport_rdata_r;
assign inport_rresp_o  = inport_rresp_r;

//-----------------------------------------------------------------
// Read Response accept
//-----------------------------------------------------------------
assign outport0_rready_o = inport_rready_i && (read_sel_q == 4'h0);
assign outport1_rready_o = inport_rready_i && (read_sel_q == 4'h1);
assign outport2_rready_o = inport_rready_i && (read_sel_q == 4'h2);
assign outport3_rready_o = inport_rready_i && (read_sel_q == 4'h3);
assign outport4_rready_o = inport_rready_i && (read_sel_q == 4'h4);
assign outport5_rready_o = inport_rready_i && (read_sel_q == 4'h5);
assign outport6_rready_o = inport_rready_i && (read_sel_q == 4'h6);
assign outport7_rready_o = inport_rready_i && (read_sel_q == 4'h7);
assign outport8_rready_o = inport_rready_i && (read_sel_q == 4'h8);
assign outport9_rready_o = inport_rready_i && (read_sel_q == 4'h9);
assign outportA_rready_o = inport_rready_i && (read_sel_q == 4'hA);
assign outportB_rready_o = inport_rready_i && (read_sel_q == 4'hB);
assign outportC_rready_o = inport_rready_i && (read_sel_q == 4'hC);
assign outportD_rready_o = inport_rready_i && (read_sel_q == 4'hD);
assign outportE_rready_o = inport_rready_i && (read_sel_q == 4'hE);
assign outportF_rready_o = inport_rready_i && (read_sel_q == 4'hF);

//-----------------------------------------------------------------
// Write command tracking
//-----------------------------------------------------------------
reg  awvalid_q;
reg  wvalid_q;
wire wr_cmd_accepted_w  = (inport_awvalid_i && inport_awready_o) || awvalid_q;
wire wr_data_accepted_w = (inport_wvalid_i  && inport_wready_o)  || wvalid_q;

reg awvalid_r;

always @ *
begin
    awvalid_r   = awvalid_q;

    // Address ready, data not ready
    if (inport_awvalid_i && inport_awready_o && !wr_data_accepted_w)
        awvalid_r = 1'b1;
    else if (wr_data_accepted_w)
        awvalid_r = 1'b0;
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    awvalid_q   <= 1'b0;
else
    awvalid_q   <= awvalid_r;

//-----------------------------------------------------------------
// Write data tracking
//-----------------------------------------------------------------
reg wvalid_r;

always @ *
begin
    wvalid_r   = wvalid_q;

    // Data ready, address not ready
    if (inport_wvalid_i && inport_wready_o && !wr_cmd_accepted_w)
        wvalid_r = 1'b1;
    else if (wr_cmd_accepted_w)
        wvalid_r = 1'b0;
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    wvalid_q   <= 1'b0;
else
    wvalid_q   <= wvalid_r;

//-----------------------------------------------------------------
// Write Dist
//-----------------------------------------------------------------
reg [3:0] write_sel_r;
reg [3:0] write_sel_q;
reg write_pending_q;
reg write_pending_r;

always @ *
begin
    write_pending_r  = write_pending_q;
    write_sel_r      = write_sel_q;

    // Write response
    if (inport_bvalid_o && inport_bready_i)
        write_pending_r = 1'b0;
    // New request - both command and data accepted
    else if (wr_cmd_accepted_w && wr_data_accepted_w)
        write_pending_r = 1'b1;

    // New request - latch address to port selection
    if (inport_awvalid_i && !awvalid_q && !write_pending_q)
        write_sel_r     = inport_awaddr_i[27:24];
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    write_sel_q      <= 4'b0;
    write_pending_q  <= 1'b0;
end
else
begin
    write_sel_q      <= write_sel_r;
    write_pending_q  <= write_pending_r;
end

//-----------------------------------------------------------------
// Write Request
//-----------------------------------------------------------------
assign outport0_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'h0) && !awvalid_q && !write_pending_q;
assign outport0_awaddr_o  =  inport_awaddr_i;
assign outport0_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'h0) && !wvalid_q && !write_pending_q;
assign outport0_wdata_o   =  inport_wdata_i;
assign outport0_wstrb_o   =  inport_wstrb_i;
assign outport1_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'h1) && !awvalid_q && !write_pending_q;
assign outport1_awaddr_o  =  inport_awaddr_i;
assign outport1_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'h1) && !wvalid_q && !write_pending_q;
assign outport1_wdata_o   =  inport_wdata_i;
assign outport1_wstrb_o   =  inport_wstrb_i;
assign outport2_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'h2) && !awvalid_q && !write_pending_q;
assign outport2_awaddr_o  =  inport_awaddr_i;
assign outport2_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'h2) && !wvalid_q && !write_pending_q;
assign outport2_wdata_o   =  inport_wdata_i;
assign outport2_wstrb_o   =  inport_wstrb_i;
assign outport3_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'h3) && !awvalid_q && !write_pending_q;
assign outport3_awaddr_o  =  inport_awaddr_i;
assign outport3_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'h3) && !wvalid_q && !write_pending_q;
assign outport3_wdata_o   =  inport_wdata_i;
assign outport3_wstrb_o   =  inport_wstrb_i;
assign outport4_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'h4) && !awvalid_q && !write_pending_q;
assign outport4_awaddr_o  =  inport_awaddr_i;
assign outport4_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'h4) && !wvalid_q && !write_pending_q;
assign outport4_wdata_o   =  inport_wdata_i;
assign outport4_wstrb_o   =  inport_wstrb_i;
assign outport5_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'h5) && !awvalid_q && !write_pending_q;
assign outport5_awaddr_o  =  inport_awaddr_i;
assign outport5_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'h5) && !wvalid_q && !write_pending_q;
assign outport5_wdata_o   =  inport_wdata_i;
assign outport5_wstrb_o   =  inport_wstrb_i;
assign outport6_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'h6) && !awvalid_q && !write_pending_q;
assign outport6_awaddr_o  =  inport_awaddr_i;
assign outport6_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'h6) && !wvalid_q && !write_pending_q;
assign outport6_wdata_o   =  inport_wdata_i;
assign outport6_wstrb_o   =  inport_wstrb_i;
assign outport7_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'h7) && !awvalid_q && !write_pending_q;
assign outport7_awaddr_o  =  inport_awaddr_i;
assign outport7_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'h7) && !wvalid_q && !write_pending_q;
assign outport7_wdata_o   =  inport_wdata_i;
assign outport7_wstrb_o   =  inport_wstrb_i;
assign outport8_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'h8) && !awvalid_q && !write_pending_q;
assign outport8_awaddr_o  =  inport_awaddr_i;
assign outport8_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'h8) && !wvalid_q && !write_pending_q;
assign outport8_wdata_o   =  inport_wdata_i;
assign outport8_wstrb_o   =  inport_wstrb_i;
assign outport9_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'h9) && !awvalid_q && !write_pending_q;
assign outport9_awaddr_o  =  inport_awaddr_i;
assign outport9_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'h9) && !wvalid_q && !write_pending_q;
assign outport9_wdata_o   =  inport_wdata_i;
assign outport9_wstrb_o   =  inport_wstrb_i;
assign outportA_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'hA) && !awvalid_q && !write_pending_q;
assign outportA_awaddr_o  =  inport_awaddr_i;
assign outportA_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'hA) && !wvalid_q && !write_pending_q;
assign outportA_wdata_o   =  inport_wdata_i;
assign outportA_wstrb_o   =  inport_wstrb_i;
assign outportB_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'hB) && !awvalid_q && !write_pending_q;
assign outportB_awaddr_o  =  inport_awaddr_i;
assign outportB_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'hB) && !wvalid_q && !write_pending_q;
assign outportB_wdata_o   =  inport_wdata_i;
assign outportB_wstrb_o   =  inport_wstrb_i;
assign outportC_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'hC) && !awvalid_q && !write_pending_q;
assign outportC_awaddr_o  =  inport_awaddr_i;
assign outportC_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'hC) && !wvalid_q && !write_pending_q;
assign outportC_wdata_o   =  inport_wdata_i;
assign outportC_wstrb_o   =  inport_wstrb_i;
assign outportD_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'hD) && !awvalid_q && !write_pending_q;
assign outportD_awaddr_o  =  inport_awaddr_i;
assign outportD_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'hD) && !wvalid_q && !write_pending_q;
assign outportD_wdata_o   =  inport_wdata_i;
assign outportD_wstrb_o   =  inport_wstrb_i;
assign outportE_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'hE) && !awvalid_q && !write_pending_q;
assign outportE_awaddr_o  =  inport_awaddr_i;
assign outportE_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'hE) && !wvalid_q && !write_pending_q;
assign outportE_wdata_o   =  inport_wdata_i;
assign outportE_wstrb_o   =  inport_wstrb_i;
assign outportF_awvalid_o =  inport_awvalid_i && (write_sel_r == 4'hF) && !awvalid_q && !write_pending_q;
assign outportF_awaddr_o  =  inport_awaddr_i;
assign outportF_wvalid_o  =  inport_wvalid_i && (inport_awvalid_i || awvalid_q) && (write_sel_r == 4'hF) && !wvalid_q && !write_pending_q;
assign outportF_wdata_o   =  inport_wdata_i;
assign outportF_wstrb_o   =  inport_wstrb_i;

//-----------------------------------------------------------------
// Write Request Accept
//-----------------------------------------------------------------
reg inport_awready_r;
reg inport_wready_r;

always @ *
begin
    inport_awready_r  = 1'b0;
    inport_wready_r   = 1'b0;

    case (write_sel_r)
    4'h0:
    begin
        inport_awready_r = outport0_awready_i;
        inport_wready_r  = outport0_wready_i;
    end
    4'h1:
    begin
        inport_awready_r = outport1_awready_i;
        inport_wready_r  = outport1_wready_i;
    end
    4'h2:
    begin
        inport_awready_r = outport2_awready_i;
        inport_wready_r  = outport2_wready_i;
    end
    4'h3:
    begin
        inport_awready_r = outport3_awready_i;
        inport_wready_r  = outport3_wready_i;
    end
    4'h4:
    begin
        inport_awready_r = outport4_awready_i;
        inport_wready_r  = outport4_wready_i;
    end
    4'h5:
    begin
        inport_awready_r = outport5_awready_i;
        inport_wready_r  = outport5_wready_i;
    end
    4'h6:
    begin
        inport_awready_r = outport6_awready_i;
        inport_wready_r  = outport6_wready_i;
    end
    4'h7:
    begin
        inport_awready_r = outport7_awready_i;
        inport_wready_r  = outport7_wready_i;
    end
    4'h8:
    begin
        inport_awready_r = outport8_awready_i;
        inport_wready_r  = outport8_wready_i;
    end
    4'h9:
    begin
        inport_awready_r = outport9_awready_i;
        inport_wready_r  = outport9_wready_i;
    end
    4'hA:
    begin
        inport_awready_r = outportA_awready_i;
        inport_wready_r  = outportA_wready_i;
    end
    4'hB:
    begin
        inport_awready_r = outportB_awready_i;
        inport_wready_r  = outportB_wready_i;
    end
    4'hC:
    begin
        inport_awready_r = outportC_awready_i;
        inport_wready_r  = outportC_wready_i;
    end
    4'hD:
    begin
        inport_awready_r = outportD_awready_i;
        inport_wready_r  = outportD_wready_i;
    end
    4'hE:
    begin
        inport_awready_r = outportE_awready_i;
        inport_wready_r  = outportE_wready_i;
    end
    4'hF:
    begin
        inport_awready_r = outportF_awready_i;
        inport_wready_r  = outportF_wready_i;
    end
    default :
        ;
    endcase
end

assign inport_awready_o = inport_awready_r && !awvalid_q && !write_pending_q;
assign inport_wready_o  = inport_wready_r  && !wvalid_q  && !write_pending_q;

//-----------------------------------------------------------------
// Write Response
//-----------------------------------------------------------------
reg        inport_bvalid_r;
reg [1:0]  inport_bresp_r;

always @ *
begin
    inport_bvalid_r  = 1'b0;
    inport_bresp_r   = 2'b0;

    case (write_sel_q)
    4'h0:
    begin
        inport_bvalid_r = outport0_bvalid_i;
        inport_bresp_r  = outport0_bresp_i;
    end
    4'h1:
    begin
        inport_bvalid_r = outport1_bvalid_i;
        inport_bresp_r  = outport1_bresp_i;
    end
    4'h2:
    begin
        inport_bvalid_r = outport2_bvalid_i;
        inport_bresp_r  = outport2_bresp_i;
    end
    4'h3:
    begin
        inport_bvalid_r = outport3_bvalid_i;
        inport_bresp_r  = outport3_bresp_i;
    end
    4'h4:
    begin
        inport_bvalid_r = outport4_bvalid_i;
        inport_bresp_r  = outport4_bresp_i;
    end
    4'h5:
    begin
        inport_bvalid_r = outport5_bvalid_i;
        inport_bresp_r  = outport5_bresp_i;
    end
    4'h6:
    begin
        inport_bvalid_r = outport6_bvalid_i;
        inport_bresp_r  = outport6_bresp_i;
    end
    4'h7:
    begin
        inport_bvalid_r = outport7_bvalid_i;
        inport_bresp_r  = outport7_bresp_i;
    end
    4'h8:
    begin
        inport_bvalid_r = outport8_bvalid_i;
        inport_bresp_r  = outport8_bresp_i;
    end
    4'h9:
    begin
        inport_bvalid_r = outport9_bvalid_i;
        inport_bresp_r  = outport9_bresp_i;
    end
    4'hA:
    begin
        inport_bvalid_r = outportA_bvalid_i;
        inport_bresp_r  = outportA_bresp_i;
    end
    4'hB:
    begin
        inport_bvalid_r = outportB_bvalid_i;
        inport_bresp_r  = outportB_bresp_i;
    end
    4'hC:
    begin
        inport_bvalid_r = outportC_bvalid_i;
        inport_bresp_r  = outportC_bresp_i;
    end
    4'hD:
    begin
        inport_bvalid_r = outportD_bvalid_i;
        inport_bresp_r  = outportD_bresp_i;
    end
    4'hE:
    begin
        inport_bvalid_r = outportE_bvalid_i;
        inport_bresp_r  = outportE_bresp_i;
    end
    4'hF:
    begin
        inport_bvalid_r = outportF_bvalid_i;
        inport_bresp_r  = outportF_bresp_i;
    end
    default :
        ;
    endcase
end

assign inport_bvalid_o = inport_bvalid_r;
assign inport_bresp_o  = inport_bresp_r;

//-----------------------------------------------------------------
// Write Response accept
//-----------------------------------------------------------------
assign outport0_bready_o = inport_bready_i && (write_sel_q == 4'h0);
assign outport1_bready_o = inport_bready_i && (write_sel_q == 4'h1);
assign outport2_bready_o = inport_bready_i && (write_sel_q == 4'h2);
assign outport3_bready_o = inport_bready_i && (write_sel_q == 4'h3);
assign outport4_bready_o = inport_bready_i && (write_sel_q == 4'h4);
assign outport5_bready_o = inport_bready_i && (write_sel_q == 4'h5);
assign outport6_bready_o = inport_bready_i && (write_sel_q == 4'h6);
assign outport7_bready_o = inport_bready_i && (write_sel_q == 4'h7);
assign outport8_bready_o = inport_bready_i && (write_sel_q == 4'h8);
assign outport9_bready_o = inport_bready_i && (write_sel_q == 4'h9);
assign outportA_bready_o = inport_bready_i && (write_sel_q == 4'hA);
assign outportB_bready_o = inport_bready_i && (write_sel_q == 4'hB);
assign outportC_bready_o = inport_bready_i && (write_sel_q == 4'hC);
assign outportD_bready_o = inport_bready_i && (write_sel_q == 4'hD);
assign outportE_bready_o = inport_bready_i && (write_sel_q == 4'hE);
assign outportF_bready_o = inport_bready_i && (write_sel_q == 4'hF);



endmodule
