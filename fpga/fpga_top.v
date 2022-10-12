//-----------------------------------------------------------------
//                        FPGA Test Soc
//                           V0.1
//                     Ultra-Embedded.com
//                       Copyright 2019
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

module fpga_top
//-----------------------------------------------------------------
// Params
//-----------------------------------------------------------------
#(
     parameter CLK_FREQ         = 50000000
    ,parameter BAUDRATE         = 1000000
    ,parameter UART_SPEED       = 1000000
    ,parameter C_SCK_RATIO      = 50
    ,parameter CPU              = "riscv" // riscv or armv6m
)
//-----------------------------------------------------------------
// Ports
//-----------------------------------------------------------------
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           dbg_txd_i
    ,input           spi_miso_i
    ,input           uart_rx_i
    ,input  [ 31:0]  gpio_input_i
    ,input           clock_125_i

    // Outputs
    ,output          dbg_rxd_o
    ,output          spi_clk_o
    ,output          spi_mosi_o
    ,output [  7:0]  spi_cs_o
    ,output          uart_tx_o
    ,output [ 31:0]  gpio_output_o
    ,output [ 31:0]  gpio_output_enable_o
    ,output [ 23:0]  boot_spi_adr_o
    ,output          reboot_o

`ifdef INCLUDE_ETHERNET
     // MII (Media-independent interface)
     ,input         mii_tx_clk_i
     ,output        mii_tx_er_o
     ,output        mii_tx_en_o
     ,output [7:0]  mii_txd_o
     ,input         mii_rx_clk_i
     ,input         mii_rx_er_i
     ,input         mii_rx_dv_i
     ,input [7:0]   mii_rxd_i

 // GMII (Gigabit media-independent interface)
     ,output        gmii_gtx_clk_o

 // RGMII (Reduced pin count gigabit media-independent interface)
     ,output        rgmii_tx_ctl_o
     ,input         rgmii_rx_ctl_i

 // MII Management Interface
     ,output        mdc_o
     ,inout         mdio_io
`endif
   
`ifdef INCLUDE_USB
// UTMI Interface
    ,input  [  7:0]  utmi_data_out_i
    ,input  [  7:0]  utmi_data_in_i
    ,input           utmi_txvalid_i
    ,input           utmi_txready_i
    ,input           utmi_rxvalid_i
    ,input           utmi_rxactive_i
    ,input           utmi_rxerror_i
    ,input  [  1:0]  utmi_linestate_i

    ,output [  1:0]  utmi_op_mode_o
    ,output [  1:0]  utmi_xcvrselect_o
    ,output          utmi_termselect_o
    ,output          utmi_dppulldown_o
    ,output          utmi_dmpulldown_o
`endif

// I2C Interfaces 0/1/2/3
    ,inout           i2c0_scl
    ,inout           i2c0_sda
    ,inout           i2c1_scl
    ,inout           i2c1_sda
    ,inout           i2c2_scl
    ,inout           i2c2_sda
    ,inout           i2c3_scl
    ,inout           i2c3_sda

// DVI Interfaces 0/1
    ,input           gpu_clk
    ,input           gpu_rst

    ,input           dvi_clk
    ,input           dvi_clk180
    ,input           dvi_clk315

    ,output          dvi0_hsync
    ,output          dvi0_vsync
    ,output          dvi0_de
    ,output          dvi0_clkp
    ,output          dvi0_clkn
    ,output  [11:0]  dvi0_data
    ,output          dvi0_resetn

    ,output          dvi1_hsync
    ,output          dvi1_vsync
    ,output          dvi1_de
    ,output          dvi1_clkp
    ,output          dvi1_clkn
    ,output  [11:0]  dvi1_data
    ,output          dvi1_resetn


);

wire   [63:0]  registers_w;

wire  [  3:0]  axi_t_awid_w;
wire           axi_l_awvalid_w;
wire           axi_l_arvalid_w;
wire  [  1:0]  axi_i_bresp_w;
wire  [  1:0]  axi_l_bresp_w;
wire  [ 31:0]  axi_t_wdata_w;
wire           axi_t_rlast_w;
wire  [  3:0]  axi_i_wstrb_w;
wire  [ 31:0]  axi_t_rdata_w;
wire           axi_t_bvalid_w;
wire           axi_t_awready_w;
wire           axi_l_wvalid_w;
wire  [  3:0]  axi_t_arid_w;
wire  [ 31:0]  axi_t_awaddr_w;
wire  [  1:0]  axi_i_rresp_w;
wire  [  7:0]  axi_t_arlen_w;
wire           axi_l_bvalid_w;
wire           axi_i_wlast_w;
wire           axi_i_arready_w;
wire           axi_t_wvalid_w;
wire  [ 31:0]  axi_t_araddr_w;
wire  [  3:0]  axi_i_bid_w;
wire  [  1:0]  axi_t_rresp_w;
wire           axi_l_awready_w;
wire           axi_t_wlast_w;
wire  [ 31:0]  axi_l_rdata_w;
wire  [  1:0]  axi_i_awburst_w;
wire           axi_t_rvalid_w;
wire           axi_i_rvalid_w;
wire           axi_t_arvalid_w;
wire           axi_t_arready_w;
wire  [  1:0]  axi_i_arburst_w;
wire           axi_t_awvalid_w;
wire  [  7:0]  axi_i_arlen_w;
wire           axi_l_rready_w;
wire  [  1:0]  axi_l_rresp_w;
wire  [ 31:0]  axi_i_rdata_w;
wire           axi_i_rlast_w;
wire  [ 31:0]  cpu_intr_w;
wire  [  3:0]  axi_i_awid_w;
wire  [ 31:0]  axi_l_awaddr_w;
wire  [  7:0]  axi_t_awlen_w;
wire           axi_i_wready_w;
wire  [ 31:0]  axi_l_wdata_w;
wire  [ 31:0]  enable_w;
wire  [ 31:0]  axi_l_araddr_w;
wire  [  3:0]  axi_l_wstrb_w;
wire           soc_intr_w;
wire  [  1:0]  axi_t_arburst_w;
wire  [  1:0]  axi_t_awburst_w;
wire  [  3:0]  axi_i_rid_w;
wire  [  7:0]  axi_i_awlen_w;
wire           axi_l_wready_w;
wire           axi_i_arvalid_w;
wire           axi_l_bready_w;
wire  [ 31:0]  axi_i_awaddr_w;
wire           axi_t_rready_w;
wire           axi_i_bready_w;
wire  [ 31:0]  axi_i_wdata_w;
wire           axi_t_bready_w;
wire  [  3:0]  axi_i_arid_w;
wire           axi_i_bvalid_w;
wire           axi_l_rvalid_w;
wire  [  3:0]  axi_t_bid_w;
wire           axi_l_arready_w;
wire           axi_i_rready_w;
wire  [  3:0]  axi_t_wstrb_w;
wire  [  1:0]  axi_t_bresp_w;
wire           axi_i_wvalid_w;
wire           axi_i_awready_w;
wire           rst_cpu_w;
wire           axi_i_awvalid_w;
wire  [ 31:0]  axi_i_araddr_w;
wire           axi_t_wready_w;
wire  [  3:0]  axi_t_rid_w;

wire           periph5_awready_w;
wire           periph5_wready_w;
wire           periph5_bvalid_w;
wire  [  1:0]  periph5_bresp_w;
wire           periph5_arready_w;
wire           periph5_rvalid_w;
wire  [ 31:0]  periph5_rdata_w;
wire  [  1:0]  periph5_rresp_w;
wire           periph5_irq_w = 1'b0;
wire           periph6_awready_w;
wire           periph6_wready_w;
wire           periph6_bvalid_w;
wire  [  1:0]  periph6_bresp_w;
wire           periph6_arready_w;
wire           periph6_rvalid_w;
wire  [ 31:0]  periph6_rdata_w;
wire  [  1:0]  periph6_rresp_w;
wire           periph6_irq_w = 1'b0;
wire           periph7_awready_w;
wire           periph7_wready_w;
wire           periph7_bvalid_w;
wire  [  1:0]  periph7_bresp_w;
wire           periph7_arready_w;
wire           periph7_rvalid_w;
wire  [ 31:0]  periph7_rdata_w;
wire  [  1:0]  periph7_rresp_w;
wire           periph7_irq_w = 1'b0;
wire           periph8_awready_w;
wire           periph8_wready_w;
wire           periph8_bvalid_w;
wire  [  1:0]  periph8_bresp_w;
wire           periph8_arready_w;
wire           periph8_rvalid_w;
wire  [ 31:0]  periph8_rdata_w;
wire  [  1:0]  periph8_rresp_w;
wire           periph8_irq_w = 1'b0;
wire           periph9_awready_w = 1'b0;
wire           periph9_wready_w = 1'b0;
wire           periph9_bvalid_w = 1'b0;
wire  [  1:0]  periph9_bresp_w = 2'b0;
wire           periph9_arready_w = 1'b0;
wire           periph9_rvalid_w = 1'b0;
wire  [ 31:0]  periph9_rdata_w = 32'b0;
wire  [  1:0]  periph9_rresp_w = 2'b0;
wire           periph9_irq_w = 1'b0;
wire           periphA_awready_w = 1'b0;
wire           periphA_wready_w = 1'b0;
wire           periphA_bvalid_w = 1'b0;
wire  [  1:0]  periphA_bresp_w = 2'b0;
wire           periphA_arready_w = 1'b0;
wire           periphA_rvalid_w = 1'b0;
wire  [ 31:0]  periphA_rdata_w = 32'b0;
wire  [  1:0]  periphA_rresp_w = 2'b0;
wire           periphA_irq_w = 1'b0;
wire           periphB_awready_w = 1'b0;
wire           periphB_wready_w = 1'b0;
wire           periphB_bvalid_w = 1'b0;
wire  [  1:0]  periphB_bresp_w = 2'b0;
wire           periphB_arready_w = 1'b0;
wire           periphB_rvalid_w = 1'b0;
wire  [ 31:0]  periphB_rdata_w = 32'b0;
wire  [  1:0]  periphB_rresp_w = 2'b0;
wire           periphB_irq_w = 1'b0;
wire           periphC_awready_w = 1'b0;
wire           periphC_wready_w = 1'b0;
wire           periphC_bvalid_w = 1'b0;
wire  [  1:0]  periphC_bresp_w = 2'b0;
wire           periphC_arready_w = 1'b0;
wire           periphC_rvalid_w = 1'b0;
wire  [ 31:0]  periphC_rdata_w = 32'b0;
wire  [  1:0]  periphC_rresp_w = 2'b0;
wire           periphC_irq_w = 1'b0;
wire           periphD_awready_w = 1'b0;
wire           periphD_wready_w = 1'b0;
wire           periphD_bvalid_w = 1'b0;
wire  [  1:0]  periphD_bresp_w = 2'b0;
wire           periphD_arready_w = 1'b0;
wire           periphD_rvalid_w = 1'b0;
wire  [ 31:0]  periphD_rdata_w = 32'b0;
wire  [  1:0]  periphD_rresp_w = 2'b0;
wire           periphD_irq_w = 1'b0;
wire           periphE_awready_w = 1'b0;
wire           periphE_wready_w = 1'b0;
wire           periphE_bvalid_w = 1'b0;
wire  [  1:0]  periphE_bresp_w = 2'b0;
wire           periphE_arready_w = 1'b0;
wire           periphE_rvalid_w = 1'b0;
wire  [ 31:0]  periphE_rdata_w = 32'b0;
wire  [  1:0]  periphE_rresp_w = 2'b0;
wire           periphE_irq_w = 1'b0;
wire           periphF_awready_w = 1'b0;
wire           periphF_wready_w = 1'b0;
wire           periphF_bvalid_w = 1'b0;
wire  [  1:0]  periphF_bresp_w = 2'b0;
wire           periphF_arready_w = 1'b0;
wire           periphF_rvalid_w = 1'b0;
wire  [ 31:0]  periphF_rdata_w = 32'b0;
wire  [  1:0]  periphF_rresp_w = 2'b0;
wire           periphF_irq_w = 1'b0;

wire          periph5_awvalid_w;
wire [ 31:0]  periph5_awaddr_w;
wire          periph5_wvalid_w;
wire [ 31:0]  periph5_wdata_w;
wire [  3:0]  periph5_wstrb_w;
wire          periph5_bready_w;
wire          periph5_arvalid_w;
wire [ 31:0]  periph5_araddr_w;
wire          periph5_rready_w;
wire          periph6_awvalid_w;
wire [ 31:0]  periph6_awaddr_w;
wire          periph6_wvalid_w;
wire [ 31:0]  periph6_wdata_w;
wire [  3:0]  periph6_wstrb_w;
wire          periph6_bready_w;
wire          periph6_arvalid_w;
wire [ 31:0]  periph6_araddr_w;
wire          periph6_rready_w;
wire          periph7_awvalid_w;
wire [ 31:0]  periph7_awaddr_w;
wire          periph7_wvalid_w;
wire [ 31:0]  periph7_wdata_w;
wire [  3:0]  periph7_wstrb_w;
wire          periph7_bready_w;
wire          periph7_arvalid_w;
wire [ 31:0]  periph7_araddr_w;
wire          periph7_rready_w;
wire          periph8_awvalid_w;
wire [ 31:0]  periph8_awaddr_w;
wire          periph8_wvalid_w;
wire [ 31:0]  periph8_wdata_w;
wire [  3:0]  periph8_wstrb_w;
wire          periph8_bready_w;
wire          periph8_arvalid_w;
wire [ 31:0]  periph8_araddr_w;
wire          periph8_rready_w;
wire          periph9_awvalid_w;
wire [ 31:0]  periph9_awaddr_w;
wire          periph9_wvalid_w;
wire [ 31:0]  periph9_wdata_w;
wire [  3:0]  periph9_wstrb_w;
wire          periph9_bready_w;
wire          periph9_arvalid_w;
wire [ 31:0]  periph9_araddr_w;
wire          periph9_rready_w;
wire          periphA_awvalid_w;
wire [ 31:0]  periphA_awaddr_w;
wire          periphA_wvalid_w;
wire [ 31:0]  periphA_wdata_w;
wire [  3:0]  periphA_wstrb_w;
wire          periphA_bready_w;
wire          periphA_arvalid_w;
wire [ 31:0]  periphA_araddr_w;
wire          periphA_rready_w;
wire          periphB_awvalid_w;
wire [ 31:0]  periphB_awaddr_w;
wire          periphB_wvalid_w;
wire [ 31:0]  periphB_wdata_w;
wire [  3:0]  periphB_wstrb_w;
wire          periphB_bready_w;
wire          periphB_arvalid_w;
wire [ 31:0]  periphB_araddr_w;
wire          periphB_rready_w;
wire          periphC_awvalid_w;
wire [ 31:0]  periphC_awaddr_w;
wire          periphC_wvalid_w;
wire [ 31:0]  periphC_wdata_w;
wire [  3:0]  periphC_wstrb_w;
wire          periphC_bready_w;
wire          periphC_arvalid_w;
wire [ 31:0]  periphC_araddr_w;
wire          periphC_rready_w;
wire          periphD_awvalid_w;
wire [ 31:0]  periphD_awaddr_w;
wire          periphD_wvalid_w;
wire [ 31:0]  periphD_wdata_w;
wire [  3:0]  periphD_wstrb_w;
wire          periphD_bready_w;
wire          periphD_arvalid_w;
wire [ 31:0]  periphD_araddr_w;
wire          periphD_rready_w;
wire          periphE_awvalid_w;
wire [ 31:0]  periphE_awaddr_w;
wire          periphE_wvalid_w;
wire [ 31:0]  periphE_wdata_w;
wire [  3:0]  periphE_wstrb_w;
wire          periphE_bready_w;
wire          periphE_arvalid_w;
wire [ 31:0]  periphE_araddr_w;
wire          periphE_rready_w;
wire          periphF_awvalid_w;
wire [ 31:0]  periphF_awaddr_w;
wire          periphF_wvalid_w;
wire [ 31:0]  periphF_wdata_w;
wire [  3:0]  periphF_wstrb_w;
wire          periphF_bready_w;
wire          periphF_arvalid_w;
wire [ 31:0]  periphF_araddr_w;
wire          periphF_rready_w;

dbg_bridge
#(
     .CLK_FREQ(CLK_FREQ)
    ,.UART_SPEED(UART_SPEED)
)
u_dbg
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.uart_rxd_i(dbg_txd_i)
    ,.mem_awready_i(axi_t_awready_w)
    ,.mem_wready_i(axi_t_wready_w)
    ,.mem_bvalid_i(axi_t_bvalid_w)
    ,.mem_bresp_i(axi_t_bresp_w)
    ,.mem_bid_i(axi_t_bid_w)
    ,.mem_arready_i(axi_t_arready_w)
    ,.mem_rvalid_i(axi_t_rvalid_w)
    ,.mem_rdata_i(axi_t_rdata_w)
    ,.mem_rresp_i(axi_t_rresp_w)
    ,.mem_rid_i(axi_t_rid_w)
    ,.mem_rlast_i(axi_t_rlast_w)
    ,.gpio_inputs_i(32'b0)

    // Outputs
    ,.uart_txd_o(dbg_rxd_o)
    ,.mem_awvalid_o(axi_t_awvalid_w)
    ,.mem_awaddr_o(axi_t_awaddr_w)
    ,.mem_awid_o(axi_t_awid_w)
    ,.mem_awlen_o(axi_t_awlen_w)
    ,.mem_awburst_o(axi_t_awburst_w)
    ,.mem_wvalid_o(axi_t_wvalid_w)
    ,.mem_wdata_o(axi_t_wdata_w)
    ,.mem_wstrb_o(axi_t_wstrb_w)
    ,.mem_wlast_o(axi_t_wlast_w)
    ,.mem_bready_o(axi_t_bready_w)
    ,.mem_arvalid_o(axi_t_arvalid_w)
    ,.mem_araddr_o(axi_t_araddr_w)
    ,.mem_arid_o(axi_t_arid_w)
    ,.mem_arlen_o(axi_t_arlen_w)
    ,.mem_arburst_o(axi_t_arburst_w)
    ,.mem_rready_o(axi_t_rready_w)
    ,.gpio_outputs_o(enable_w)
);


axi4_axi4lite_conv
u_conv
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(axi_i_awvalid_w)
    ,.inport_awaddr_i(axi_i_awaddr_w)
    ,.inport_awid_i(axi_i_awid_w)
    ,.inport_awlen_i(axi_i_awlen_w)
    ,.inport_awburst_i(axi_i_awburst_w)
    ,.inport_wvalid_i(axi_i_wvalid_w)
    ,.inport_wdata_i(axi_i_wdata_w)
    ,.inport_wstrb_i(axi_i_wstrb_w)
    ,.inport_wlast_i(axi_i_wlast_w)
    ,.inport_bready_i(axi_i_bready_w)
    ,.inport_arvalid_i(axi_i_arvalid_w)
    ,.inport_araddr_i(axi_i_araddr_w)
    ,.inport_arid_i(axi_i_arid_w)
    ,.inport_arlen_i(axi_i_arlen_w)
    ,.inport_arburst_i(axi_i_arburst_w)
    ,.inport_rready_i(axi_i_rready_w)
    ,.outport_awready_i(axi_l_awready_w)
    ,.outport_wready_i(axi_l_wready_w)
    ,.outport_bvalid_i(axi_l_bvalid_w)
    ,.outport_bresp_i(axi_l_bresp_w)
    ,.outport_arready_i(axi_l_arready_w)
    ,.outport_rvalid_i(axi_l_rvalid_w)
    ,.outport_rdata_i(axi_l_rdata_w)
    ,.outport_rresp_i(axi_l_rresp_w)

    // Outputs
    ,.inport_awready_o(axi_i_awready_w)
    ,.inport_wready_o(axi_i_wready_w)
    ,.inport_bvalid_o(axi_i_bvalid_w)
    ,.inport_bresp_o(axi_i_bresp_w)
    ,.inport_bid_o(axi_i_bid_w)
    ,.inport_arready_o(axi_i_arready_w)
    ,.inport_rvalid_o(axi_i_rvalid_w)
    ,.inport_rdata_o(axi_i_rdata_w)
    ,.inport_rresp_o(axi_i_rresp_w)
    ,.inport_rid_o(axi_i_rid_w)
    ,.inport_rlast_o(axi_i_rlast_w)
    ,.outport_awvalid_o(axi_l_awvalid_w)
    ,.outport_awaddr_o(axi_l_awaddr_w)
    ,.outport_wvalid_o(axi_l_wvalid_w)
    ,.outport_wdata_o(axi_l_wdata_w)
    ,.outport_wstrb_o(axi_l_wstrb_w)
    ,.outport_bready_o(axi_l_bready_w)
    ,.outport_arvalid_o(axi_l_arvalid_w)
    ,.outport_araddr_o(axi_l_araddr_w)
    ,.outport_rready_o(axi_l_rready_w)
);

riscv_tcm_wrapper
u_cpu
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.rst_cpu_i(rst_cpu_w)
    ,.axi_i_awready_i(axi_i_awready_w)
    ,.axi_i_wready_i(axi_i_wready_w)
    ,.axi_i_bvalid_i(axi_i_bvalid_w)
    ,.axi_i_bresp_i(axi_i_bresp_w)
    ,.axi_i_bid_i(axi_i_bid_w)
    ,.axi_i_arready_i(axi_i_arready_w)
    ,.axi_i_rvalid_i(axi_i_rvalid_w)
    ,.axi_i_rdata_i(axi_i_rdata_w)
    ,.axi_i_rresp_i(axi_i_rresp_w)
    ,.axi_i_rid_i(axi_i_rid_w)
    ,.axi_i_rlast_i(axi_i_rlast_w)
    ,.axi_t_awvalid_i(axi_t_awvalid_w)
    ,.axi_t_awaddr_i(axi_t_awaddr_w)
    ,.axi_t_awid_i(axi_t_awid_w)
    ,.axi_t_awlen_i(axi_t_awlen_w)
    ,.axi_t_awburst_i(axi_t_awburst_w)
    ,.axi_t_wvalid_i(axi_t_wvalid_w)
    ,.axi_t_wdata_i(axi_t_wdata_w)
    ,.axi_t_wstrb_i(axi_t_wstrb_w)
    ,.axi_t_wlast_i(axi_t_wlast_w)
    ,.axi_t_bready_i(axi_t_bready_w)
    ,.axi_t_arvalid_i(axi_t_arvalid_w)
    ,.axi_t_araddr_i(axi_t_araddr_w)
    ,.axi_t_arid_i(axi_t_arid_w)
    ,.axi_t_arlen_i(axi_t_arlen_w)
    ,.axi_t_arburst_i(axi_t_arburst_w)
    ,.axi_t_rready_i(axi_t_rready_w)
    ,.intr_i(cpu_intr_w)

    // Outputs
    ,.axi_i_awvalid_o(axi_i_awvalid_w)
    ,.axi_i_awaddr_o(axi_i_awaddr_w)
    ,.axi_i_awid_o(axi_i_awid_w)
    ,.axi_i_awlen_o(axi_i_awlen_w)
    ,.axi_i_awburst_o(axi_i_awburst_w)
    ,.axi_i_wvalid_o(axi_i_wvalid_w)
    ,.axi_i_wdata_o(axi_i_wdata_w)
    ,.axi_i_wstrb_o(axi_i_wstrb_w)
    ,.axi_i_wlast_o(axi_i_wlast_w)
    ,.axi_i_bready_o(axi_i_bready_w)
    ,.axi_i_arvalid_o(axi_i_arvalid_w)
    ,.axi_i_araddr_o(axi_i_araddr_w)
    ,.axi_i_arid_o(axi_i_arid_w)
    ,.axi_i_arlen_o(axi_i_arlen_w)
    ,.axi_i_arburst_o(axi_i_arburst_w)
    ,.axi_i_rready_o(axi_i_rready_w)
    ,.axi_t_awready_o(axi_t_awready_w)
    ,.axi_t_wready_o(axi_t_wready_w)
    ,.axi_t_bvalid_o(axi_t_bvalid_w)
    ,.axi_t_bresp_o(axi_t_bresp_w)
    ,.axi_t_bid_o(axi_t_bid_w)
    ,.axi_t_arready_o(axi_t_arready_w)
    ,.axi_t_rvalid_o(axi_t_rvalid_w)
    ,.axi_t_rdata_o(axi_t_rdata_w)
    ,.axi_t_rresp_o(axi_t_rresp_w)
    ,.axi_t_rid_o(axi_t_rid_w)
    ,.axi_t_rlast_o(axi_t_rlast_w)
);

core_soc
#(
     .CLK_FREQ(CLK_FREQ)
    ,.BAUDRATE(BAUDRATE)
    ,.C_SCK_RATIO(C_SCK_RATIO)
)
u_soc
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(axi_l_awvalid_w)
    ,.inport_awaddr_i(axi_l_awaddr_w)
    ,.inport_wvalid_i(axi_l_wvalid_w)
    ,.inport_wdata_i(axi_l_wdata_w)
    ,.inport_wstrb_i(axi_l_wstrb_w)
    ,.inport_bready_i(axi_l_bready_w)
    ,.inport_arvalid_i(axi_l_arvalid_w)
    ,.inport_araddr_i(axi_l_araddr_w)
    ,.inport_rready_i(axi_l_rready_w)
    ,.spi_miso_i(spi_miso_i)
    ,.uart_rx_i(uart_rx_i)
    ,.gpio_input_i(gpio_input_i)
    ,.periph5_awready_i(periph5_awready_w)
    ,.periph5_wready_i(periph5_wready_w)
    ,.periph5_bvalid_i(periph5_bvalid_w)
    ,.periph5_bresp_i(periph5_bresp_w)
    ,.periph5_arready_i(periph5_arready_w)
    ,.periph5_rvalid_i(periph5_rvalid_w)
    ,.periph5_rdata_i(periph5_rdata_w)
    ,.periph5_rresp_i(periph5_rresp_w)
    ,.periph5_irq_i(periph5_irq_w)
    ,.periph6_awready_i(periph6_awready_w)
    ,.periph6_wready_i(periph6_wready_w)
    ,.periph6_bvalid_i(periph6_bvalid_w)
    ,.periph6_bresp_i(periph6_bresp_w)
    ,.periph6_arready_i(periph6_arready_w)
    ,.periph6_rvalid_i(periph6_rvalid_w)
    ,.periph6_rdata_i(periph6_rdata_w)
    ,.periph6_rresp_i(periph6_rresp_w)
    ,.periph6_irq_i(periph6_irq_w)
    ,.periph7_awready_i(periph7_awready_w)
    ,.periph7_wready_i(periph7_wready_w)
    ,.periph7_bvalid_i(periph7_bvalid_w)
    ,.periph7_bresp_i(periph7_bresp_w)
    ,.periph7_arready_i(periph7_arready_w)
    ,.periph7_rvalid_i(periph7_rvalid_w)
    ,.periph7_rdata_i(periph7_rdata_w)
    ,.periph7_rresp_i(periph7_rresp_w)
    ,.periph7_irq_i(periph7_irq_w)
    ,.periph8_awready_i(periph8_awready_w)
    ,.periph8_wready_i(periph8_wready_w)
    ,.periph8_bvalid_i(periph8_bvalid_w)
    ,.periph8_bresp_i(periph8_bresp_w)
    ,.periph8_arready_i(periph8_arready_w)
    ,.periph8_rvalid_i(periph8_rvalid_w)
    ,.periph8_rdata_i(periph8_rdata_w)
    ,.periph8_rresp_i(periph8_rresp_w)
    ,.periph8_irq_i(periph8_irq_w)
    ,.periph9_awready_i(periph9_awready_w)
    ,.periph9_wready_i(periph9_wready_w)
    ,.periph9_bvalid_i(periph9_bvalid_w)
    ,.periph9_bresp_i(periph9_bresp_w)
    ,.periph9_arready_i(periph9_arready_w)
    ,.periph9_rvalid_i(periph9_rvalid_w)
    ,.periph9_rdata_i(periph9_rdata_w)
    ,.periph9_rresp_i(periph9_rresp_w)
    ,.periph9_irq_i(periph9_irq_w)
    ,.periphA_awready_i(periphA_awready_w)
    ,.periphA_wready_i(periphA_wready_w)
    ,.periphA_bvalid_i(periphA_bvalid_w)
    ,.periphA_bresp_i(periphA_bresp_w)
    ,.periphA_arready_i(periphA_arready_w)
    ,.periphA_rvalid_i(periphA_rvalid_w)
    ,.periphA_rdata_i(periphA_rdata_w)
    ,.periphA_rresp_i(periphA_rresp_w)
    ,.periphA_irq_i(periphA_irq_w)
    ,.periphB_awready_i(periphB_awready_w)
    ,.periphB_wready_i(periphB_wready_w)
    ,.periphB_bvalid_i(periphB_bvalid_w)
    ,.periphB_bresp_i(periphB_bresp_w)
    ,.periphB_arready_i(periphB_arready_w)
    ,.periphB_rvalid_i(periphB_rvalid_w)
    ,.periphB_rdata_i(periphB_rdata_w)
    ,.periphB_rresp_i(periphB_rresp_w)
    ,.periphB_irq_i(periphB_irq_w)

    ,.periphC_awready_i(periphC_awready_w)
    ,.periphC_wready_i(periphC_wready_w)
    ,.periphC_bvalid_i(periphC_bvalid_w)
    ,.periphC_bresp_i(periphC_bresp_w)
    ,.periphC_arready_i(periphC_arready_w)
    ,.periphC_rvalid_i(periphC_rvalid_w)
    ,.periphC_rdata_i(periphC_rdata_w)
    ,.periphC_rresp_i(periphC_rresp_w)
    ,.periphC_irq_i(periphC_irq_w)
    ,.periphD_awready_i(periphD_awready_w)
    ,.periphD_wready_i(periphD_wready_w)
    ,.periphD_bvalid_i(periphD_bvalid_w)
    ,.periphD_bresp_i(periphD_bresp_w)
    ,.periphD_arready_i(periphD_arready_w)
    ,.periphD_rvalid_i(periphD_rvalid_w)
    ,.periphD_rdata_i(periphD_rdata_w)
    ,.periphD_rresp_i(periphD_rresp_w)
    ,.periphD_irq_i(periphD_irq_w)
    ,.periphE_awready_i(periphE_awready_w)
    ,.periphE_wready_i(periphE_wready_w)
    ,.periphE_bvalid_i(periphE_bvalid_w)
    ,.periphE_bresp_i(periphE_bresp_w)
    ,.periphE_arready_i(periphE_arready_w)
    ,.periphE_rvalid_i(periphE_rvalid_w)
    ,.periphE_rdata_i(periphE_rdata_w)
    ,.periphE_rresp_i(periphE_rresp_w)
    ,.periphE_irq_i(periphE_irq_w)
    ,.periphF_awready_i(periphF_awready_w)
    ,.periphF_wready_i(periphF_wready_w)
    ,.periphF_bvalid_i(periphF_bvalid_w)
    ,.periphF_bresp_i(periphF_bresp_w)
    ,.periphF_arready_i(periphF_arready_w)
    ,.periphF_rvalid_i(periphF_rvalid_w)
    ,.periphF_rdata_i(periphF_rdata_w)
    ,.periphF_rresp_i(periphF_rresp_w)
    ,.periphF_irq_i(periphF_irq_w)

    // Outputs
    ,.intr_o(soc_intr_w)
    ,.inport_awready_o(axi_l_awready_w)
    ,.inport_wready_o(axi_l_wready_w)
    ,.inport_bvalid_o(axi_l_bvalid_w)
    ,.inport_bresp_o(axi_l_bresp_w)
    ,.inport_arready_o(axi_l_arready_w)
    ,.inport_rvalid_o(axi_l_rvalid_w)
    ,.inport_rdata_o(axi_l_rdata_w)
    ,.inport_rresp_o(axi_l_rresp_w)
    ,.spi_clk_o(spi_clk_o)
    ,.spi_mosi_o(spi_mosi_o)
    ,.spi_cs_o(spi_cs_o)
    ,.uart_tx_o(uart_tx_o)
    ,.gpio_output_o(gpio_output_o)
    ,.gpio_output_enable_o(gpio_output_enable_o)
    ,.boot_spi_adr_o(boot_spi_adr_o)
    ,.reboot_o(reboot_o)

    ,.periph5_awvalid_o(periph5_awvalid_w)
    ,.periph5_awaddr_o(periph5_awaddr_w)
    ,.periph5_wvalid_o(periph5_wvalid_w)
    ,.periph5_wdata_o(periph5_wdata_w)
    ,.periph5_wstrb_o(periph5_wstrb_w)
    ,.periph5_bready_o(periph5_bready_w)
    ,.periph5_arvalid_o(periph5_arvalid_w)
    ,.periph5_araddr_o(periph5_araddr_w)
    ,.periph5_rready_o(periph5_rready_w)
    ,.periph6_awvalid_o(periph6_awvalid_w)
    ,.periph6_awaddr_o(periph6_awaddr_w)
    ,.periph6_wvalid_o(periph6_wvalid_w)
    ,.periph6_wdata_o(periph6_wdata_w)
    ,.periph6_wstrb_o(periph6_wstrb_w)
    ,.periph6_bready_o(periph6_bready_w)
    ,.periph6_arvalid_o(periph6_arvalid_w)
    ,.periph6_araddr_o(periph6_araddr_w)
    ,.periph6_rready_o(periph6_rready_w)
    ,.periph7_awvalid_o(periph7_awvalid_w)
    ,.periph7_awaddr_o(periph7_awaddr_w)
    ,.periph7_wvalid_o(periph7_wvalid_w)
    ,.periph7_wdata_o(periph7_wdata_w)
    ,.periph7_wstrb_o(periph7_wstrb_w)
    ,.periph7_bready_o(periph7_bready_w)
    ,.periph7_arvalid_o(periph7_arvalid_w)
    ,.periph7_araddr_o(periph7_araddr_w)
    ,.periph7_rready_o(periph7_rready_w)
    ,.periph8_awvalid_o(periph8_awvalid_w)
    ,.periph8_awaddr_o(periph8_awaddr_w)
    ,.periph8_wvalid_o(periph8_wvalid_w)
    ,.periph8_wdata_o(periph8_wdata_w)
    ,.periph8_wstrb_o(periph8_wstrb_w)
    ,.periph8_bready_o(periph8_bready_w)
    ,.periph8_arvalid_o(periph8_arvalid_w)
    ,.periph8_araddr_o(periph8_araddr_w)
    ,.periph8_rready_o(periph8_rready_w)

    ,.periph9_awvalid_o(periph9_awvalid_w)
    ,.periph9_awaddr_o(periph9_awaddr_w)
    ,.periph9_wvalid_o(periph9_wvalid_w)
    ,.periph9_wdata_o(periph9_wdata_w)
    ,.periph9_wstrb_o(periph9_wstrb_w)
    ,.periph9_bready_o(periph9_bready_w)
    ,.periph9_arvalid_o(periph9_arvalid_w)
    ,.periph9_araddr_o(periph9_araddr_w)
    ,.periph9_rready_o(periph9_rready_w)

    ,.periphA_awvalid_o(periphA_awvalid_w)
    ,.periphA_awaddr_o(periphA_awaddr_w)
    ,.periphA_wvalid_o(periphA_wvalid_w)
    ,.periphA_wdata_o(periphA_wdata_w)
    ,.periphA_wstrb_o(periphA_wstrb_w)
    ,.periphA_bready_o(periphA_bready_w)
    ,.periphA_arvalid_o(periphA_arvalid_w)
    ,.periphA_araddr_o(periphA_araddr_w)
    ,.periphA_rready_o(periphA_rready_w)

    ,.periphB_awvalid_o(periphB_awvalid_w)
    ,.periphB_awaddr_o(periphB_awaddr_w)
    ,.periphB_wvalid_o(periphB_wvalid_w)
    ,.periphB_wdata_o(periphB_wdata_w)
    ,.periphB_wstrb_o(periphB_wstrb_w)
    ,.periphB_bready_o(periphB_bready_w)
    ,.periphB_arvalid_o(periphB_arvalid_w)
    ,.periphB_araddr_o(periphB_araddr_w)
    ,.periphB_rready_o(periphB_rready_w)

    ,.periphC_awvalid_o(periphC_awvalid_w)
    ,.periphC_awaddr_o(periphC_awaddr_w)
    ,.periphC_wvalid_o(periphC_wvalid_w)
    ,.periphC_wdata_o(periphC_wdata_w)
    ,.periphC_wstrb_o(periphC_wstrb_w)
    ,.periphC_bready_o(periphC_bready_w)
    ,.periphC_arvalid_o(periphC_arvalid_w)
    ,.periphC_araddr_o(periphC_araddr_w)
    ,.periphC_rready_o(periphC_rready_w)
    ,.periphD_awvalid_o(periphD_awvalid_w)
    ,.periphD_awaddr_o(periphD_awaddr_w)
    ,.periphD_wvalid_o(periphD_wvalid_w)
    ,.periphD_wdata_o(periphD_wdata_w)
    ,.periphD_wstrb_o(periphD_wstrb_w)
    ,.periphD_bready_o(periphD_bready_w)
    ,.periphD_arvalid_o(periphD_arvalid_w)
    ,.periphD_araddr_o(periphD_araddr_w)
    ,.periphD_rready_o(periphD_rready_w)
    ,.periphE_awvalid_o(periphE_awvalid_w)
    ,.periphE_awaddr_o(periphE_awaddr_w)
    ,.periphE_wvalid_o(periphE_wvalid_w)
    ,.periphE_wdata_o(periphE_wdata_w)
    ,.periphE_wstrb_o(periphE_wstrb_w)
    ,.periphE_bready_o(periphE_bready_w)
    ,.periphE_arvalid_o(periphE_arvalid_w)
    ,.periphE_araddr_o(periphE_araddr_w)
    ,.periphE_rready_o(periphE_rready_w)
    ,.periphF_awvalid_o(periphF_awvalid_w)
    ,.periphF_awaddr_o(periphF_awaddr_w)
    ,.periphF_wvalid_o(periphF_wvalid_w)
    ,.periphF_wdata_o(periphF_wdata_w)
    ,.periphF_wstrb_o(periphF_wstrb_w)
    ,.periphF_bready_o(periphF_bready_w)
    ,.periphF_arvalid_o(periphF_arvalid_w)
    ,.periphF_araddr_o(periphF_araddr_w)
    ,.periphF_rready_o(periphF_rready_w)
);

// enable_w[0] from the dbg_bridge is used for a reset, but  we want to 
// come up running so ignore it until it has been asserted and released once
reg bridge_rst_enable;
reg rst_cpu_r;

always @(posedge clk_i or posedge rst_i) 
    if (rst_i) begin
        bridge_rst_enable <= 0;
        rst_cpu_r <= 1;
    end
    else begin
        if(!bridge_rst_enable)
            bridge_rst_enable <= enable_w[0];

        if(bridge_rst_enable)
            rst_cpu_r <= ~enable_w[0];
        else
            rst_cpu_r <= 0;
    end


assign rst_cpu_w       = rst_cpu_r;
assign cpu_intr_w      = {31'b0, soc_intr_w};

`ifdef INCLUDE_ETHERNET
eth_axi4lite u_eth (
      // axi4lite Inputs
    .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.cfg_awvalid_i(periph5_awvalid_w)
    ,.cfg_awaddr_i(periph5_awaddr_w)
    ,.cfg_wvalid_i(periph5_wvalid_w)
    ,.cfg_wdata_i(periph5_wdata_w)
    ,.cfg_wstrb_i(periph5_wstrb_w)
    ,.cfg_bready_i(periph5_bready_w)
    ,.cfg_arvalid_i(periph5_arvalid_w)
    ,.cfg_araddr_i(periph5_araddr_w)
    ,.cfg_rready_i(periph5_rready_w)

    // axi4lite Outputs
    ,.cfg_awready_o(periph5_awready_w)
    ,.cfg_wready_o(periph5_wready_w)
    ,.cfg_bvalid_o(periph5_bvalid_w)
    ,.cfg_bresp_o(periph5_bresp_w)
    ,.cfg_arready_o(periph5_arready_w)
    ,.cfg_rvalid_o(periph5_rvalid_w)
    ,.cfg_rdata_o(periph5_rdata_w)
    ,.cfg_rresp_o(periph5_rresp_w)


    // peripheral inputs
    ,.clock_125_i(clock_125_i)

    // MII (Media-independent interface)
    ,.mii_tx_clk_i(mii_tx_clk_i)
    ,.mii_tx_er_o(mii_tx_er_o)
    ,.mii_tx_en_o(mii_tx_en_o)
    ,.mii_txd_o(mii_txd_o)
    ,.mii_rx_clk_i(mii_rx_clk_i)
    ,.mii_rx_er_i(mii_rx_er_i)
    ,.mii_rx_dv_i(mii_rx_dv_i)
    ,.mii_rxd_i(mii_rxd_i)

    // GMII (Gigabit media-independent interface)
    ,.gmii_gtx_clk_o(gmii_gtx_clk_o)

    // RGMII (Reduced pin count gigabit media-independent interface)
    ,.rgmii_tx_ctl_o(rgmii_tx_ctl_o)
    ,.rgmii_rx_ctl_i(rgmii_rx_ctl_i)

    // MII Management Interface
    ,.mdc_o(mdc_o)
    ,.mdio_io(mdio_io)
);
`endif

i2c_master_axil #(
    .DEFAULT_DIVIDER(71)
) i2c0_master (
    .clk_i(clk_i)
    ,.rst_i(rst_i)

    ,.cfg_awvalid_i(periph6_awvalid_w)
    ,.cfg_awaddr_i(periph6_awaddr_w)
    ,.cfg_wvalid_i(periph6_wvalid_w)
    ,.cfg_wdata_i(periph6_wdata_w)
    ,.cfg_wstrb_i(periph6_wstrb_w)
    ,.cfg_bready_i(periph6_bready_w)
    ,.cfg_arvalid_i(periph6_arvalid_w)
    ,.cfg_araddr_i(periph6_araddr_w)
    ,.cfg_rready_i(periph6_rready_w)

    ,.cfg_awready_o(periph6_awready_w)
    ,.cfg_wready_o(periph6_wready_w)
    ,.cfg_bvalid_o(periph6_bvalid_w)
    ,.cfg_bresp_o(periph6_bresp_w)
    ,.cfg_arready_o(periph6_arready_w)
    ,.cfg_rvalid_o(periph6_rvalid_w)
    ,.cfg_rdata_o(periph6_rdata_w)
    ,.cfg_rresp_o(periph6_rresp_w)

    ,.i2c0_scl(i2c0_scl)
    ,.i2c0_sda(i2c0_sda)

    ,.i2c1_scl(i2c1_scl)
    ,.i2c1_sda(i2c1_sda)

    ,.i2c2_scl(i2c2_scl)
    ,.i2c2_sda(i2c2_sda)

    ,.i2c3_scl(i2c3_scl)
    ,.i2c3_sda(i2c3_sda)
);

wire vsync_w, hsync_w, vde_w;
wire vinvert_w, hinvert_w;

wire [11:0] px_w;
wire [11:0] py_w;

wire hsync_q = hsync_w ^ hinvert_w;
wire vsync_q = vsync_w ^ vinvert_w;
wire vde_q = vde_w;

wire [23:0] gpu_pixel;

dvi_interface dvi0_inst (
     .gpu_clk0(gpu_clk)
    ,.dvi_clk0(dvi_clk)
    ,.dvi_clk180(dvi_clk180)
    ,.dvi_clk315(dvi_clk315)
    ,.Rst(gpu_rst)
    ,.red_in(gpu_pixel[23:16])
    ,.green_in(gpu_pixel[15:8])
    ,.blue_in(gpu_pixel[7:0])
    ,.hsync_in(hsync_q)
    ,.vsync_in(vsync_q)
    ,.de_in(vde_q)
    ,.HSYNC(dvi0_hsync)
    ,.VSYNC(dvi0_vsync)
    ,.DE(dvi0_de)
    ,.DVI_CLK_P(dvi0_clkp)
    ,.DVI_CLK_N(dvi0_clkn)
    ,.DVI_DATA(dvi0_data)
);

dvi_interface dvi1_inst (
     .gpu_clk0(gpu_clk)
    ,.dvi_clk0(dvi_clk)
    ,.dvi_clk180(dvi_clk180)
    ,.dvi_clk315(dvi_clk315)
    ,.Rst(gpu_rst)
    ,.red_in(gpu_pixel[23:16])
    ,.green_in(gpu_pixel[15:8])
    ,.blue_in(gpu_pixel[7:0])
    ,.hsync_in(hsync_q)
    ,.vsync_in(vsync_q)
    ,.de_in(vde_q)
    ,.HSYNC(dvi1_hsync)
    ,.VSYNC(dvi1_vsync)
    ,.DE(dvi1_de)
    ,.DVI_CLK_P(dvi1_clkp)
    ,.DVI_CLK_N(dvi1_clkn)
    ,.DVI_DATA(dvi1_data)
);

crtc_axil crtc_inst (
     .clk_i(clk_i)
    ,.rst_i(rst_i)

    ,.cfg_awvalid_i(periph7_awvalid_w)
    ,.cfg_awaddr_i(periph7_awaddr_w)
    ,.cfg_wvalid_i(periph7_wvalid_w)
    ,.cfg_wdata_i(periph7_wdata_w)
    ,.cfg_wstrb_i(periph7_wstrb_w)
    ,.cfg_bready_i(periph7_bready_w)
    ,.cfg_arvalid_i(periph7_arvalid_w)
    ,.cfg_araddr_i(periph7_araddr_w)
    ,.cfg_rready_i(periph7_rready_w)

    ,.cfg_awready_o(periph7_awready_w)
    ,.cfg_wready_o(periph7_wready_w)
    ,.cfg_bvalid_o(periph7_bvalid_w)
    ,.cfg_bresp_o(periph7_bresp_w)
    ,.cfg_arready_o(periph7_arready_w)
    ,.cfg_rvalid_o(periph7_rvalid_w)
    ,.cfg_rdata_o(periph7_rdata_w)
    ,.cfg_rresp_o(periph7_rresp_w)

    ,.pclk_i(gpu_clk)
    ,.prst_i(gpu_rst)
    ,.vsync_o(vsync_w)
    ,.hsync_o(hsync_w)
    ,.valid_o(vde_w)
    ,.x_o(px_w)
    ,.y_o(py_w)

    ,.vinvert_o(vinvert_w)
    ,.hinvert_o(hinvert_w)
);

console console_inst (
     .cpu_clk_i(clk_i)
    ,.cpu_rst_i(rst_i)

    ,.cfg_awvalid_i(periph8_awvalid_w)
    ,.cfg_awaddr_i(periph8_awaddr_w)
    ,.cfg_wvalid_i(periph8_wvalid_w)
    ,.cfg_wdata_i(periph8_wdata_w)
    ,.cfg_wstrb_i(periph8_wstrb_w)
    ,.cfg_bready_i(periph8_bready_w)
    ,.cfg_arvalid_i(periph8_arvalid_w)
    ,.cfg_araddr_i(periph8_araddr_w)
    ,.cfg_rready_i(periph8_rready_w)

    ,.cfg_awready_o(periph8_awready_w)
    ,.cfg_wready_o(periph8_wready_w)
    ,.cfg_bvalid_o(periph8_bvalid_w)
    ,.cfg_bresp_o(periph8_bresp_w)
    ,.cfg_arready_o(periph8_arready_w)
    ,.cfg_rvalid_o(periph8_rvalid_w)
    ,.cfg_rdata_o(periph8_rdata_w)
    ,.cfg_rresp_o(periph8_rresp_w)

    ,.gpu_clk_i(gpu_clk)
    ,.gpu_rst_i(gpu_rst)
    ,.vsync_i(vsync_w)
    ,.hsync_i(hsync_w)
    ,.valid_i(vde_w)
    ,.px_i(px_w)
    ,.py_i(py_w)
    ,.pixel_o(gpu_pixel)
);

endmodule
