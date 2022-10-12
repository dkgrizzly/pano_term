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

module core_soc
//-----------------------------------------------------------------
// Params
//-----------------------------------------------------------------
#(
     parameter CLK_FREQ         = 50000000
    ,parameter BAUDRATE         = 1000000
    ,parameter C_SCK_RATIO      = 50
)
//-----------------------------------------------------------------
// Ports
//-----------------------------------------------------------------
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
    ,input           spi_miso_i
    ,input           uart_rx_i
    ,input  [ 31:0]  gpio_input_i
    ,input           periph5_awready_i
    ,input           periph5_wready_i
    ,input           periph5_bvalid_i
    ,input  [  1:0]  periph5_bresp_i
    ,input           periph5_arready_i
    ,input           periph5_rvalid_i
    ,input  [ 31:0]  periph5_rdata_i
    ,input  [  1:0]  periph5_rresp_i
    ,input           periph5_irq_i
    ,input           periph6_awready_i
    ,input           periph6_wready_i
    ,input           periph6_bvalid_i
    ,input  [  1:0]  periph6_bresp_i
    ,input           periph6_arready_i
    ,input           periph6_rvalid_i
    ,input  [ 31:0]  periph6_rdata_i
    ,input  [  1:0]  periph6_rresp_i
    ,input           periph6_irq_i
    ,input           periph7_awready_i
    ,input           periph7_wready_i
    ,input           periph7_bvalid_i
    ,input  [  1:0]  periph7_bresp_i
    ,input           periph7_arready_i
    ,input           periph7_rvalid_i
    ,input  [ 31:0]  periph7_rdata_i
    ,input  [  1:0]  periph7_rresp_i
    ,input           periph7_irq_i
    ,input           periph8_awready_i
    ,input           periph8_wready_i
    ,input           periph8_bvalid_i
    ,input  [  1:0]  periph8_bresp_i
    ,input           periph8_arready_i
    ,input           periph8_rvalid_i
    ,input  [ 31:0]  periph8_rdata_i
    ,input  [  1:0]  periph8_rresp_i
    ,input           periph8_irq_i
    ,input           periph9_awready_i
    ,input           periph9_wready_i
    ,input           periph9_bvalid_i
    ,input  [  1:0]  periph9_bresp_i
    ,input           periph9_arready_i
    ,input           periph9_rvalid_i
    ,input  [ 31:0]  periph9_rdata_i
    ,input  [  1:0]  periph9_rresp_i
    ,input           periph9_irq_i
    ,input           periphA_awready_i
    ,input           periphA_wready_i
    ,input           periphA_bvalid_i
    ,input  [  1:0]  periphA_bresp_i
    ,input           periphA_arready_i
    ,input           periphA_rvalid_i
    ,input  [ 31:0]  periphA_rdata_i
    ,input  [  1:0]  periphA_rresp_i
    ,input           periphA_irq_i
    ,input           periphB_awready_i
    ,input           periphB_wready_i
    ,input           periphB_bvalid_i
    ,input  [  1:0]  periphB_bresp_i
    ,input           periphB_arready_i
    ,input           periphB_rvalid_i
    ,input  [ 31:0]  periphB_rdata_i
    ,input  [  1:0]  periphB_rresp_i
    ,input           periphB_irq_i
    ,input           periphC_awready_i
    ,input           periphC_wready_i
    ,input           periphC_bvalid_i
    ,input  [  1:0]  periphC_bresp_i
    ,input           periphC_arready_i
    ,input           periphC_rvalid_i
    ,input  [ 31:0]  periphC_rdata_i
    ,input  [  1:0]  periphC_rresp_i
    ,input           periphC_irq_i
    ,input           periphD_awready_i
    ,input           periphD_wready_i
    ,input           periphD_bvalid_i
    ,input  [  1:0]  periphD_bresp_i
    ,input           periphD_arready_i
    ,input           periphD_rvalid_i
    ,input  [ 31:0]  periphD_rdata_i
    ,input  [  1:0]  periphD_rresp_i
    ,input           periphD_irq_i
    ,input           periphE_awready_i
    ,input           periphE_wready_i
    ,input           periphE_bvalid_i
    ,input  [  1:0]  periphE_bresp_i
    ,input           periphE_arready_i
    ,input           periphE_rvalid_i
    ,input  [ 31:0]  periphE_rdata_i
    ,input  [  1:0]  periphE_rresp_i
    ,input           periphE_irq_i
    ,input           periphF_awready_i
    ,input           periphF_wready_i
    ,input           periphF_bvalid_i
    ,input  [  1:0]  periphF_bresp_i
    ,input           periphF_arready_i
    ,input           periphF_rvalid_i
    ,input  [ 31:0]  periphF_rdata_i
    ,input  [  1:0]  periphF_rresp_i
    ,input           periphF_irq_i

    // Outputs
    ,output          intr_o
    ,output          inport_awready_o
    ,output          inport_wready_o
    ,output          inport_bvalid_o
    ,output [  1:0]  inport_bresp_o
    ,output          inport_arready_o
    ,output          inport_rvalid_o
    ,output [ 31:0]  inport_rdata_o
    ,output [  1:0]  inport_rresp_o
    ,output          spi_clk_o
    ,output          spi_mosi_o
    ,output [  7:0]  spi_cs_o
    ,output          uart_tx_o
    ,output [ 31:0]  gpio_output_o
    ,output [ 31:0]  gpio_output_enable_o
    ,output          periph5_awvalid_o
    ,output [ 31:0]  periph5_awaddr_o
    ,output          periph5_wvalid_o
    ,output [ 31:0]  periph5_wdata_o
    ,output [  3:0]  periph5_wstrb_o
    ,output          periph5_bready_o
    ,output          periph5_arvalid_o
    ,output [ 31:0]  periph5_araddr_o
    ,output          periph5_rready_o
    ,output          periph6_awvalid_o
    ,output [ 31:0]  periph6_awaddr_o
    ,output          periph6_wvalid_o
    ,output [ 31:0]  periph6_wdata_o
    ,output [  3:0]  periph6_wstrb_o
    ,output          periph6_bready_o
    ,output          periph6_arvalid_o
    ,output [ 31:0]  periph6_araddr_o
    ,output          periph6_rready_o
    ,output          periph7_awvalid_o
    ,output [ 31:0]  periph7_awaddr_o
    ,output          periph7_wvalid_o
    ,output [ 31:0]  periph7_wdata_o
    ,output [  3:0]  periph7_wstrb_o
    ,output          periph7_bready_o
    ,output          periph7_arvalid_o
    ,output [ 31:0]  periph7_araddr_o
    ,output          periph7_rready_o
    ,output          periph8_awvalid_o
    ,output [ 31:0]  periph8_awaddr_o
    ,output          periph8_wvalid_o
    ,output [ 31:0]  periph8_wdata_o
    ,output [  3:0]  periph8_wstrb_o
    ,output          periph8_bready_o
    ,output          periph8_arvalid_o
    ,output [ 31:0]  periph8_araddr_o
    ,output          periph8_rready_o
    ,output          periph9_awvalid_o
    ,output [ 31:0]  periph9_awaddr_o
    ,output          periph9_wvalid_o
    ,output [ 31:0]  periph9_wdata_o
    ,output [  3:0]  periph9_wstrb_o
    ,output          periph9_bready_o
    ,output          periph9_arvalid_o
    ,output [ 31:0]  periph9_araddr_o
    ,output          periph9_rready_o
    ,output          periphA_awvalid_o
    ,output [ 31:0]  periphA_awaddr_o
    ,output          periphA_wvalid_o
    ,output [ 31:0]  periphA_wdata_o
    ,output [  3:0]  periphA_wstrb_o
    ,output          periphA_bready_o
    ,output          periphA_arvalid_o
    ,output [ 31:0]  periphA_araddr_o
    ,output          periphA_rready_o
    ,output          periphB_awvalid_o
    ,output [ 31:0]  periphB_awaddr_o
    ,output          periphB_wvalid_o
    ,output [ 31:0]  periphB_wdata_o
    ,output [  3:0]  periphB_wstrb_o
    ,output          periphB_bready_o
    ,output          periphB_arvalid_o
    ,output [ 31:0]  periphB_araddr_o
    ,output          periphB_rready_o
    ,output          periphC_awvalid_o
    ,output [ 31:0]  periphC_awaddr_o
    ,output          periphC_wvalid_o
    ,output [ 31:0]  periphC_wdata_o
    ,output [  3:0]  periphC_wstrb_o
    ,output          periphC_bready_o
    ,output          periphC_arvalid_o
    ,output [ 31:0]  periphC_araddr_o
    ,output          periphC_rready_o
    ,output          periphD_awvalid_o
    ,output [ 31:0]  periphD_awaddr_o
    ,output          periphD_wvalid_o
    ,output [ 31:0]  periphD_wdata_o
    ,output [  3:0]  periphD_wstrb_o
    ,output          periphD_bready_o
    ,output          periphD_arvalid_o
    ,output [ 31:0]  periphD_araddr_o
    ,output          periphD_rready_o
    ,output          periphE_awvalid_o
    ,output [ 31:0]  periphE_awaddr_o
    ,output          periphE_wvalid_o
    ,output [ 31:0]  periphE_wdata_o
    ,output [  3:0]  periphE_wstrb_o
    ,output          periphE_bready_o
    ,output          periphE_arvalid_o
    ,output [ 31:0]  periphE_araddr_o
    ,output          periphE_rready_o
    ,output          periphF_awvalid_o
    ,output [ 31:0]  periphF_awaddr_o
    ,output          periphF_wvalid_o
    ,output [ 31:0]  periphF_wdata_o
    ,output [  3:0]  periphF_wstrb_o
    ,output          periphF_bready_o
    ,output          periphF_arvalid_o
    ,output [ 31:0]  periphF_araddr_o
    ,output          periphF_rready_o

    ,output [ 23:0]  boot_spi_adr_o
    ,output          reboot_o
);

wire           periph0_awready_w;
wire           periph0_wready_w;
wire           periph0_bvalid_w;
wire  [  1:0]  periph0_bresp_w;
wire           periph0_arready_w;
wire           periph0_rvalid_w;
wire  [ 31:0]  periph0_rdata_w;
wire  [  1:0]  periph0_rresp_w;
wire           periph0_awvalid_w;
wire  [ 31:0]  periph0_awaddr_w;
wire           periph0_wvalid_w;
wire  [ 31:0]  periph0_wdata_w;
wire  [  3:0]  periph0_wstrb_w;
wire           periph0_bready_w;
wire           periph0_arvalid_w;
wire  [ 31:0]  periph0_araddr_w;
wire           periph0_rready_w;

wire           periph1_awready_w;
wire           periph1_wready_w;
wire           periph1_bvalid_w;
wire  [  1:0]  periph1_bresp_w;
wire           periph1_arready_w;
wire           periph1_rvalid_w;
wire  [ 31:0]  periph1_rdata_w;
wire  [  1:0]  periph1_rresp_w;
wire           periph1_awvalid_w;
wire  [ 31:0]  periph1_awaddr_w;
wire           periph1_wvalid_w;
wire  [ 31:0]  periph1_wdata_w;
wire  [  3:0]  periph1_wstrb_w;
wire           periph1_bready_w;
wire           periph1_arvalid_w;
wire  [ 31:0]  periph1_araddr_w;
wire           periph1_rready_w;
wire           periph1_irq_w;

wire           periph2_awready_w;
wire           periph2_wready_w;
wire           periph2_bvalid_w;
wire  [  1:0]  periph2_bresp_w;
wire           periph2_arready_w;
wire           periph2_rvalid_w;
wire  [ 31:0]  periph2_rdata_w;
wire  [  1:0]  periph2_rresp_w;
wire           periph2_awvalid_w;
wire  [ 31:0]  periph2_awaddr_w;
wire           periph2_wvalid_w;
wire  [ 31:0]  periph2_wdata_w;
wire  [  3:0]  periph2_wstrb_w;
wire           periph2_bready_w;
wire           periph2_arvalid_w;
wire  [ 31:0]  periph2_araddr_w;
wire           periph2_rready_w;
wire           periph2_irq_w;

wire           periph3_awready_w;
wire           periph3_wready_w;
wire           periph3_bvalid_w;
wire  [  1:0]  periph3_bresp_w;
wire           periph3_arready_w;
wire           periph3_rvalid_w;
wire  [ 31:0]  periph3_rdata_w;
wire  [  1:0]  periph3_rresp_w;
wire           periph3_awvalid_w;
wire  [ 31:0]  periph3_awaddr_w;
wire           periph3_wvalid_w;
wire  [ 31:0]  periph3_wdata_w;
wire  [  3:0]  periph3_wstrb_w;
wire           periph3_bready_w;
wire           periph3_arvalid_w;
wire  [ 31:0]  periph3_araddr_w;
wire           periph3_rready_w;
wire           periph3_irq_w;

wire           periph4_awready_w;
wire           periph4_wready_w;
wire           periph4_bvalid_w;
wire  [  1:0]  periph4_bresp_w;
wire           periph4_arready_w;
wire           periph4_rvalid_w;
wire  [ 31:0]  periph4_rdata_w;
wire  [  1:0]  periph4_rresp_w;
wire           periph4_awvalid_w;
wire  [ 31:0]  periph4_awaddr_w;
wire           periph4_wvalid_w;
wire  [ 31:0]  periph4_wdata_w;
wire  [  3:0]  periph4_wstrb_w;
wire           periph4_bready_w;
wire           periph4_arvalid_w;
wire  [ 31:0]  periph4_araddr_w;
wire           periph4_rready_w;
wire           periph4_irq_w;



irq_ctrl
u_intc
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.cfg_awvalid_i(periph0_awvalid_w)
    ,.cfg_awaddr_i(periph0_awaddr_w)
    ,.cfg_wvalid_i(periph0_wvalid_w)
    ,.cfg_wdata_i(periph0_wdata_w)
    ,.cfg_wstrb_i(periph0_wstrb_w)
    ,.cfg_bready_i(periph0_bready_w)
    ,.cfg_arvalid_i(periph0_arvalid_w)
    ,.cfg_araddr_i(periph0_araddr_w)
    ,.cfg_rready_i(periph0_rready_w)
    ,.interrupt0_i(1'b0)
    ,.interrupt1_i(periph1_irq_w)
    ,.interrupt2_i(periph2_irq_w)
    ,.interrupt3_i(periph3_irq_w)
    ,.interrupt4_i(periph4_irq_w)
    ,.interrupt5_i(periph5_irq_i)
    ,.interrupt6_i(periph6_irq_i)
    ,.interrupt7_i(periph7_irq_i)
    ,.interrupt8_i(periph8_irq_i)
    ,.interrupt9_i(periph9_irq_i)
    ,.interruptA_i(periphA_irq_i)
    ,.interruptB_i(periphB_irq_i)
    ,.interruptC_i(periphC_irq_i)
    ,.interruptD_i(periphD_irq_i)
    ,.interruptE_i(periphE_irq_i)
    ,.interruptF_i(periphF_irq_i)

    // Outputs
    ,.cfg_awready_o(periph0_awready_w)
    ,.cfg_wready_o(periph0_wready_w)
    ,.cfg_bvalid_o(periph0_bvalid_w)
    ,.cfg_bresp_o(periph0_bresp_w)
    ,.cfg_arready_o(periph0_arready_w)
    ,.cfg_rvalid_o(periph0_rvalid_w)
    ,.cfg_rdata_o(periph0_rdata_w)
    ,.cfg_rresp_o(periph0_rresp_w)
    ,.intr_o(intr_o)
);


axi4lite_dist
u_dist
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(inport_awvalid_i)
    ,.inport_awaddr_i(inport_awaddr_i)
    ,.inport_wvalid_i(inport_wvalid_i)
    ,.inport_wdata_i(inport_wdata_i)
    ,.inport_wstrb_i(inport_wstrb_i)
    ,.inport_bready_i(inport_bready_i)
    ,.inport_arvalid_i(inport_arvalid_i)
    ,.inport_araddr_i(inport_araddr_i)
    ,.inport_rready_i(inport_rready_i)
    ,.outport0_awready_i(periph0_awready_w)
    ,.outport0_wready_i(periph0_wready_w)
    ,.outport0_bvalid_i(periph0_bvalid_w)
    ,.outport0_bresp_i(periph0_bresp_w)
    ,.outport0_arready_i(periph0_arready_w)
    ,.outport0_rvalid_i(periph0_rvalid_w)
    ,.outport0_rdata_i(periph0_rdata_w)
    ,.outport0_rresp_i(periph0_rresp_w)
    ,.outport1_awready_i(periph1_awready_w)
    ,.outport1_wready_i(periph1_wready_w)
    ,.outport1_bvalid_i(periph1_bvalid_w)
    ,.outport1_bresp_i(periph1_bresp_w)
    ,.outport1_arready_i(periph1_arready_w)
    ,.outport1_rvalid_i(periph1_rvalid_w)
    ,.outport1_rdata_i(periph1_rdata_w)
    ,.outport1_rresp_i(periph1_rresp_w)
    ,.outport2_awready_i(periph2_awready_w)
    ,.outport2_wready_i(periph2_wready_w)
    ,.outport2_bvalid_i(periph2_bvalid_w)
    ,.outport2_bresp_i(periph2_bresp_w)
    ,.outport2_arready_i(periph2_arready_w)
    ,.outport2_rvalid_i(periph2_rvalid_w)
    ,.outport2_rdata_i(periph2_rdata_w)
    ,.outport2_rresp_i(periph2_rresp_w)
    ,.outport3_awready_i(periph3_awready_w)
    ,.outport3_wready_i(periph3_wready_w)
    ,.outport3_bvalid_i(periph3_bvalid_w)
    ,.outport3_bresp_i(periph3_bresp_w)
    ,.outport3_arready_i(periph3_arready_w)
    ,.outport3_rvalid_i(periph3_rvalid_w)
    ,.outport3_rdata_i(periph3_rdata_w)
    ,.outport3_rresp_i(periph3_rresp_w)
    ,.outport4_awready_i(periph4_awready_w)
    ,.outport4_wready_i(periph4_wready_w)
    ,.outport4_bvalid_i(periph4_bvalid_w)
    ,.outport4_bresp_i(periph4_bresp_w)
    ,.outport4_arready_i(periph4_arready_w)
    ,.outport4_rvalid_i(periph4_rvalid_w)
    ,.outport4_rdata_i(periph4_rdata_w)
    ,.outport4_rresp_i(periph4_rresp_w)
    ,.outport5_awready_i(periph5_awready_i)
    ,.outport5_wready_i(periph5_wready_i)
    ,.outport5_bvalid_i(periph5_bvalid_i)
    ,.outport5_bresp_i(periph5_bresp_i)
    ,.outport5_arready_i(periph5_arready_i)
    ,.outport5_rvalid_i(periph5_rvalid_i)
    ,.outport5_rdata_i(periph5_rdata_i)
    ,.outport5_rresp_i(periph5_rresp_i)
    ,.outport6_awready_i(periph6_awready_i)
    ,.outport6_wready_i(periph6_wready_i)
    ,.outport6_bvalid_i(periph6_bvalid_i)
    ,.outport6_bresp_i(periph6_bresp_i)
    ,.outport6_arready_i(periph6_arready_i)
    ,.outport6_rvalid_i(periph6_rvalid_i)
    ,.outport6_rdata_i(periph6_rdata_i)
    ,.outport6_rresp_i(periph6_rresp_i)
    ,.outport7_awready_i(periph7_awready_i)
    ,.outport7_wready_i(periph7_wready_i)
    ,.outport7_bvalid_i(periph7_bvalid_i)
    ,.outport7_bresp_i(periph7_bresp_i)
    ,.outport7_arready_i(periph7_arready_i)
    ,.outport7_rvalid_i(periph7_rvalid_i)
    ,.outport7_rdata_i(periph7_rdata_i)
    ,.outport7_rresp_i(periph7_rresp_i)
    ,.outport8_awready_i(periph8_awready_i)
    ,.outport8_wready_i(periph8_wready_i)
    ,.outport8_bvalid_i(periph8_bvalid_i)
    ,.outport8_bresp_i(periph8_bresp_i)
    ,.outport8_arready_i(periph8_arready_i)
    ,.outport8_rvalid_i(periph8_rvalid_i)
    ,.outport8_rdata_i(periph8_rdata_i)
    ,.outport8_rresp_i(periph8_rresp_i)
    ,.outport9_awready_i(periph9_awready_i)
    ,.outport9_wready_i(periph9_wready_i)
    ,.outport9_bvalid_i(periph9_bvalid_i)
    ,.outport9_bresp_i(periph9_bresp_i)
    ,.outport9_arready_i(periph9_arready_i)
    ,.outport9_rvalid_i(periph9_rvalid_i)
    ,.outport9_rdata_i(periph9_rdata_i)
    ,.outport9_rresp_i(periph9_rresp_i)
    ,.outportA_awready_i(periphA_awready_i)
    ,.outportA_wready_i(periphA_wready_i)
    ,.outportA_bvalid_i(periphA_bvalid_i)
    ,.outportA_bresp_i(periphA_bresp_i)
    ,.outportA_arready_i(periphA_arready_i)
    ,.outportA_rvalid_i(periphA_rvalid_i)
    ,.outportA_rdata_i(periphA_rdata_i)
    ,.outportA_rresp_i(periphA_rresp_i)
    ,.outportB_awready_i(periphB_awready_i)
    ,.outportB_wready_i(periphB_wready_i)
    ,.outportB_bvalid_i(periphB_bvalid_i)
    ,.outportB_bresp_i(periphB_bresp_i)
    ,.outportB_arready_i(periphB_arready_i)
    ,.outportB_rvalid_i(periphB_rvalid_i)
    ,.outportB_rdata_i(periphB_rdata_i)
    ,.outportB_rresp_i(periphB_rresp_i)
    ,.outportC_awready_i(periphC_awready_i)
    ,.outportC_wready_i(periphC_wready_i)
    ,.outportC_bvalid_i(periphC_bvalid_i)
    ,.outportC_bresp_i(periphC_bresp_i)
    ,.outportC_arready_i(periphC_arready_i)
    ,.outportC_rvalid_i(periphC_rvalid_i)
    ,.outportC_rdata_i(periphC_rdata_i)
    ,.outportC_rresp_i(periphC_rresp_i)
    ,.outportD_awready_i(periphD_awready_i)
    ,.outportD_wready_i(periphD_wready_i)
    ,.outportD_bvalid_i(periphD_bvalid_i)
    ,.outportD_bresp_i(periphD_bresp_i)
    ,.outportD_arready_i(periphD_arready_i)
    ,.outportD_rvalid_i(periphD_rvalid_i)
    ,.outportD_rdata_i(periphD_rdata_i)
    ,.outportD_rresp_i(periphD_rresp_i)
    ,.outportE_awready_i(periphE_awready_i)
    ,.outportE_wready_i(periphE_wready_i)
    ,.outportE_bvalid_i(periphE_bvalid_i)
    ,.outportE_bresp_i(periphE_bresp_i)
    ,.outportE_arready_i(periphE_arready_i)
    ,.outportE_rvalid_i(periphE_rvalid_i)
    ,.outportE_rdata_i(periphE_rdata_i)
    ,.outportE_rresp_i(periphE_rresp_i)
    ,.outportF_awready_i(periphF_awready_i)
    ,.outportF_wready_i(periphF_wready_i)
    ,.outportF_bvalid_i(periphF_bvalid_i)
    ,.outportF_bresp_i(periphF_bresp_i)
    ,.outportF_arready_i(periphF_arready_i)
    ,.outportF_rvalid_i(periphF_rvalid_i)
    ,.outportF_rdata_i(periphF_rdata_i)
    ,.outportF_rresp_i(periphF_rresp_i)

    // Outputs
    ,.inport_awready_o(inport_awready_o)
    ,.inport_wready_o(inport_wready_o)
    ,.inport_bvalid_o(inport_bvalid_o)
    ,.inport_bresp_o(inport_bresp_o)
    ,.inport_arready_o(inport_arready_o)
    ,.inport_rvalid_o(inport_rvalid_o)
    ,.inport_rdata_o(inport_rdata_o)
    ,.inport_rresp_o(inport_rresp_o)
    ,.outport0_awvalid_o(periph0_awvalid_w)
    ,.outport0_awaddr_o(periph0_awaddr_w)
    ,.outport0_wvalid_o(periph0_wvalid_w)
    ,.outport0_wdata_o(periph0_wdata_w)
    ,.outport0_wstrb_o(periph0_wstrb_w)
    ,.outport0_bready_o(periph0_bready_w)
    ,.outport0_arvalid_o(periph0_arvalid_w)
    ,.outport0_araddr_o(periph0_araddr_w)
    ,.outport0_rready_o(periph0_rready_w)
    ,.outport1_awvalid_o(periph1_awvalid_w)
    ,.outport1_awaddr_o(periph1_awaddr_w)
    ,.outport1_wvalid_o(periph1_wvalid_w)
    ,.outport1_wdata_o(periph1_wdata_w)
    ,.outport1_wstrb_o(periph1_wstrb_w)
    ,.outport1_bready_o(periph1_bready_w)
    ,.outport1_arvalid_o(periph1_arvalid_w)
    ,.outport1_araddr_o(periph1_araddr_w)
    ,.outport1_rready_o(periph1_rready_w)
    ,.outport2_awvalid_o(periph2_awvalid_w)
    ,.outport2_awaddr_o(periph2_awaddr_w)
    ,.outport2_wvalid_o(periph2_wvalid_w)
    ,.outport2_wdata_o(periph2_wdata_w)
    ,.outport2_wstrb_o(periph2_wstrb_w)
    ,.outport2_bready_o(periph2_bready_w)
    ,.outport2_arvalid_o(periph2_arvalid_w)
    ,.outport2_araddr_o(periph2_araddr_w)
    ,.outport2_rready_o(periph2_rready_w)
    ,.outport3_awvalid_o(periph3_awvalid_w)
    ,.outport3_awaddr_o(periph3_awaddr_w)
    ,.outport3_wvalid_o(periph3_wvalid_w)
    ,.outport3_wdata_o(periph3_wdata_w)
    ,.outport3_wstrb_o(periph3_wstrb_w)
    ,.outport3_bready_o(periph3_bready_w)
    ,.outport3_arvalid_o(periph3_arvalid_w)
    ,.outport3_araddr_o(periph3_araddr_w)
    ,.outport3_rready_o(periph3_rready_w)
    ,.outport4_awvalid_o(periph4_awvalid_w)
    ,.outport4_awaddr_o(periph4_awaddr_w)
    ,.outport4_wvalid_o(periph4_wvalid_w)
    ,.outport4_wdata_o(periph4_wdata_w)
    ,.outport4_wstrb_o(periph4_wstrb_w)
    ,.outport4_bready_o(periph4_bready_w)
    ,.outport4_arvalid_o(periph4_arvalid_w)
    ,.outport4_araddr_o(periph4_araddr_w)
    ,.outport4_rready_o(periph4_rready_w)
    ,.outport5_awvalid_o(periph5_awvalid_o)
    ,.outport5_awaddr_o(periph5_awaddr_o)
    ,.outport5_wvalid_o(periph5_wvalid_o)
    ,.outport5_wdata_o(periph5_wdata_o)
    ,.outport5_wstrb_o(periph5_wstrb_o)
    ,.outport5_bready_o(periph5_bready_o)
    ,.outport5_arvalid_o(periph5_arvalid_o)
    ,.outport5_araddr_o(periph5_araddr_o)
    ,.outport5_rready_o(periph5_rready_o)
    ,.outport6_awvalid_o(periph6_awvalid_o)
    ,.outport6_awaddr_o(periph6_awaddr_o)
    ,.outport6_wvalid_o(periph6_wvalid_o)
    ,.outport6_wdata_o(periph6_wdata_o)
    ,.outport6_wstrb_o(periph6_wstrb_o)
    ,.outport6_bready_o(periph6_bready_o)
    ,.outport6_arvalid_o(periph6_arvalid_o)
    ,.outport6_araddr_o(periph6_araddr_o)
    ,.outport6_rready_o(periph6_rready_o)
    ,.outport7_awvalid_o(periph7_awvalid_o)
    ,.outport7_awaddr_o(periph7_awaddr_o)
    ,.outport7_wvalid_o(periph7_wvalid_o)
    ,.outport7_wdata_o(periph7_wdata_o)
    ,.outport7_wstrb_o(periph7_wstrb_o)
    ,.outport7_bready_o(periph7_bready_o)
    ,.outport7_arvalid_o(periph7_arvalid_o)
    ,.outport7_araddr_o(periph7_araddr_o)
    ,.outport7_rready_o(periph7_rready_o)
    ,.outport8_awvalid_o(periph8_awvalid_o)
    ,.outport8_awaddr_o(periph8_awaddr_o)
    ,.outport8_wvalid_o(periph8_wvalid_o)
    ,.outport8_wdata_o(periph8_wdata_o)
    ,.outport8_wstrb_o(periph8_wstrb_o)
    ,.outport8_bready_o(periph8_bready_o)
    ,.outport8_arvalid_o(periph8_arvalid_o)
    ,.outport8_araddr_o(periph8_araddr_o)
    ,.outport8_rready_o(periph8_rready_o)
    ,.outport9_awvalid_o(periph9_awvalid_o)
    ,.outport9_awaddr_o(periph9_awaddr_o)
    ,.outport9_wvalid_o(periph9_wvalid_o)
    ,.outport9_wdata_o(periph9_wdata_o)
    ,.outport9_wstrb_o(periph9_wstrb_o)
    ,.outport9_bready_o(periph9_bready_o)
    ,.outport9_arvalid_o(periph9_arvalid_o)
    ,.outport9_araddr_o(periph9_araddr_o)
    ,.outport9_rready_o(periph9_rready_o)
    ,.outportA_awvalid_o(periphA_awvalid_o)
    ,.outportA_awaddr_o(periphA_awaddr_o)
    ,.outportA_wvalid_o(periphA_wvalid_o)
    ,.outportA_wdata_o(periphA_wdata_o)
    ,.outportA_wstrb_o(periphA_wstrb_o)
    ,.outportA_bready_o(periphA_bready_o)
    ,.outportA_arvalid_o(periphA_arvalid_o)
    ,.outportA_araddr_o(periphA_araddr_o)
    ,.outportA_rready_o(periphA_rready_o)
    ,.outportB_awvalid_o(periphB_awvalid_o)
    ,.outportB_awaddr_o(periphB_awaddr_o)
    ,.outportB_wvalid_o(periphB_wvalid_o)
    ,.outportB_wdata_o(periphB_wdata_o)
    ,.outportB_wstrb_o(periphB_wstrb_o)
    ,.outportB_bready_o(periphB_bready_o)
    ,.outportB_arvalid_o(periphB_arvalid_o)
    ,.outportB_araddr_o(periphB_araddr_o)
    ,.outportB_rready_o(periphB_rready_o)
    ,.outportC_awvalid_o(periphC_awvalid_o)
    ,.outportC_awaddr_o(periphC_awaddr_o)
    ,.outportC_wvalid_o(periphC_wvalid_o)
    ,.outportC_wdata_o(periphC_wdata_o)
    ,.outportC_wstrb_o(periphC_wstrb_o)
    ,.outportC_bready_o(periphC_bready_o)
    ,.outportC_arvalid_o(periphC_arvalid_o)
    ,.outportC_araddr_o(periphC_araddr_o)
    ,.outportC_rready_o(periphC_rready_o)
    ,.outportD_awvalid_o(periphD_awvalid_o)
    ,.outportD_awaddr_o(periphD_awaddr_o)
    ,.outportD_wvalid_o(periphD_wvalid_o)
    ,.outportD_wdata_o(periphD_wdata_o)
    ,.outportD_wstrb_o(periphD_wstrb_o)
    ,.outportD_bready_o(periphD_bready_o)
    ,.outportD_arvalid_o(periphD_arvalid_o)
    ,.outportD_araddr_o(periphD_araddr_o)
    ,.outportD_rready_o(periphD_rready_o)
    ,.outportE_awvalid_o(periphE_awvalid_o)
    ,.outportE_awaddr_o(periphE_awaddr_o)
    ,.outportE_wvalid_o(periphE_wvalid_o)
    ,.outportE_wdata_o(periphE_wdata_o)
    ,.outportE_wstrb_o(periphE_wstrb_o)
    ,.outportE_bready_o(periphE_bready_o)
    ,.outportE_arvalid_o(periphE_arvalid_o)
    ,.outportE_araddr_o(periphE_araddr_o)
    ,.outportE_rready_o(periphE_rready_o)
    ,.outportF_awvalid_o(periphF_awvalid_o)
    ,.outportF_awaddr_o(periphF_awaddr_o)
    ,.outportF_wvalid_o(periphF_wvalid_o)
    ,.outportF_wdata_o(periphF_wdata_o)
    ,.outportF_wstrb_o(periphF_wstrb_o)
    ,.outportF_bready_o(periphF_bready_o)
    ,.outportF_arvalid_o(periphF_arvalid_o)
    ,.outportF_araddr_o(periphF_araddr_o)
    ,.outportF_rready_o(periphF_rready_o)
);


uart_lite
#(
     .CLK_FREQ(CLK_FREQ)
    ,.BAUDRATE(BAUDRATE)
)
u_uart
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.cfg_awvalid_i(periph2_awvalid_w)
    ,.cfg_awaddr_i(periph2_awaddr_w)
    ,.cfg_wvalid_i(periph2_wvalid_w)
    ,.cfg_wdata_i(periph2_wdata_w)
    ,.cfg_wstrb_i(periph2_wstrb_w)
    ,.cfg_bready_i(periph2_bready_w)
    ,.cfg_arvalid_i(periph2_arvalid_w)
    ,.cfg_araddr_i(periph2_araddr_w)
    ,.cfg_rready_i(periph2_rready_w)
    ,.rx_i(uart_rx_i)

    // Outputs
    ,.cfg_awready_o(periph2_awready_w)
    ,.cfg_wready_o(periph2_wready_w)
    ,.cfg_bvalid_o(periph2_bvalid_w)
    ,.cfg_bresp_o(periph2_bresp_w)
    ,.cfg_arready_o(periph2_arready_w)
    ,.cfg_rvalid_o(periph2_rvalid_w)
    ,.cfg_rdata_o(periph2_rdata_w)
    ,.cfg_rresp_o(periph2_rresp_w)
    ,.tx_o(uart_tx_o)
    ,.intr_o(periph2_irq_w)
);


timer
u_timer
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.cfg_awvalid_i(periph1_awvalid_w)
    ,.cfg_awaddr_i(periph1_awaddr_w)
    ,.cfg_wvalid_i(periph1_wvalid_w)
    ,.cfg_wdata_i(periph1_wdata_w)
    ,.cfg_wstrb_i(periph1_wstrb_w)
    ,.cfg_bready_i(periph1_bready_w)
    ,.cfg_arvalid_i(periph1_arvalid_w)
    ,.cfg_araddr_i(periph1_araddr_w)
    ,.cfg_rready_i(periph1_rready_w)

    // Outputs
    ,.cfg_awready_o(periph1_awready_w)
    ,.cfg_wready_o(periph1_wready_w)
    ,.cfg_bvalid_o(periph1_bvalid_w)
    ,.cfg_bresp_o(periph1_bresp_w)
    ,.cfg_arready_o(periph1_arready_w)
    ,.cfg_rvalid_o(periph1_rvalid_w)
    ,.cfg_rdata_o(periph1_rdata_w)
    ,.cfg_rresp_o(periph1_rresp_w)
    ,.intr_o(periph1_irq_w)
);


spi_lite
#(
     .C_SCK_RATIO(C_SCK_RATIO)
)
u_spi
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.cfg_awvalid_i(periph3_awvalid_w)
    ,.cfg_awaddr_i(periph3_awaddr_w)
    ,.cfg_wvalid_i(periph3_wvalid_w)
    ,.cfg_wdata_i(periph3_wdata_w)
    ,.cfg_wstrb_i(periph3_wstrb_w)
    ,.cfg_bready_i(periph3_bready_w)
    ,.cfg_arvalid_i(periph3_arvalid_w)
    ,.cfg_araddr_i(periph3_araddr_w)
    ,.cfg_rready_i(periph3_rready_w)
    ,.spi_miso_i(spi_miso_i)

    // Outputs
    ,.cfg_awready_o(periph3_awready_w)
    ,.cfg_wready_o(periph3_wready_w)
    ,.cfg_bvalid_o(periph3_bvalid_w)
    ,.cfg_bresp_o(periph3_bresp_w)
    ,.cfg_arready_o(periph3_arready_w)
    ,.cfg_rvalid_o(periph3_rvalid_w)
    ,.cfg_rdata_o(periph3_rdata_w)
    ,.cfg_rresp_o(periph3_rresp_w)
    ,.spi_clk_o(spi_clk_o)
    ,.spi_mosi_o(spi_mosi_o)
    ,.spi_cs_o(spi_cs_o)
    ,.intr_o(periph3_irq_w)
);


gpio
u_gpio
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.cfg_awvalid_i(periph4_awvalid_w)
    ,.cfg_awaddr_i(periph4_awaddr_w)
    ,.cfg_wvalid_i(periph4_wvalid_w)
    ,.cfg_wdata_i(periph4_wdata_w)
    ,.cfg_wstrb_i(periph4_wstrb_w)
    ,.cfg_bready_i(periph4_bready_w)
    ,.cfg_arvalid_i(periph4_arvalid_w)
    ,.cfg_araddr_i(periph4_araddr_w)
    ,.cfg_rready_i(periph4_rready_w)
    ,.gpio_input_i(gpio_input_i)

    // Outputs
    ,.cfg_awready_o(periph4_awready_w)
    ,.cfg_wready_o(periph4_wready_w)
    ,.cfg_bvalid_o(periph4_bvalid_w)
    ,.cfg_bresp_o(periph4_bresp_w)
    ,.cfg_arready_o(periph4_arready_w)
    ,.cfg_rvalid_o(periph4_rvalid_w)
    ,.cfg_rdata_o(periph4_rdata_w)
    ,.cfg_rresp_o(periph4_rresp_w)
    ,.gpio_output_o(gpio_output_o)
    ,.gpio_output_enable_o(gpio_output_enable_o)
    ,.intr_o(periph4_irq_w)

    ,.boot_spi_adr_o(boot_spi_adr_o)
    ,.reboot_o(reboot_o)
);



endmodule
