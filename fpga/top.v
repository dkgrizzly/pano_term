//-----------------------------------------------------------------
// TOP
//-----------------------------------------------------------------
module top
(
     input           SYSCLK
    ,inout           pano_button
    ,output          GMII_RST_N
    ,output          led_red
    ,inout           led_green
    ,inout           led_blue

    ,output [3:0]    pwr_status

    // UART
    //,input           uart_txd_i
    //,output          uart_rxd_o

    // SPI-Flash
    ,output          flash_sck_o
    ,output          flash_cs_o
    ,output          flash_si_o
    ,input           flash_so_i

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

     // I2C bus to Audio Codec
     ,inout          codec_scl
     ,inout          codec_sda

     ,output         codec_mclk
     ,output         codec_bclk
     ,output         codec_adclrc
     ,output         codec_daclrc
     ,output         codec_dacdat

     // I2C bus to DVI Encoders
     ,inout          encoder_scl
     ,inout          encoder_sda

     // I2C bus to DVI DDC (LCD on DZ22)
     ,inout          dvi0_scl
     ,inout          dvi0_sda

     // I2C bus to HDMI DDC (DVI on DZ22)
     ,inout          dvi1_scl
     ,inout          dvi1_sda

     // DVI/LCD
     ,output         DVI0_HSYNC
     ,output         DVI0_VSYNC
     ,output         DVI0_DE
     ,output         DVI0_CLK_P
     ,output         DVI0_CLK_N
     ,output  [11:0] DVI0_DATA
     ,output         DVI0_RESET_N

     // microHDMI/DVI
     ,output         DVI1_HSYNC
     ,output         DVI1_VSYNC
     ,output         DVI1_DE
     ,output         DVI1_CLK_P
     ,output  [11:0] DVI1_DATA
     ,output         DVI1_RESET_N

);


wire uart_txd_i = 1'b1;
wire uart_rxd_o;

wire cpu_clk;
wire cpu_rst;
wire cpu_locked;

wire codec_clk;
wire codec_rst;
wire codec_locked;

wire dvi_clk0;
wire dvi_clk180;
wire gpu_clk = dvi_clk0;
wire gpu_rst;
wire gpu_locked;

wire axi65_rst;
wire axi80_rst;

wire single_w;
wire step_w;

// Buffer 125 MHz Clock Input from Ethernet PHY
IBUFG clk125_buf
(   .O (clk125),
    .I (SYSCLK)
);

cpu_clock cpu_clock_inst (
    .CLK_IN1(clk125),
    .CLK_OUT1(cpu_clk),
    .LOCKED(cpu_locked)
);

audio_clock audio_clock_inst (
    .CLK_IN1(clk125),
    .CLK_OUT1(codec_clk),
    .LOCKED(codec_locked)
);

dvi_clock dvi_clock_inst (
    .CLK_IN1(clk125),
    .CLK_OUT1(dvi_clk0),
    .CLK_OUT2(dvi_clk180),
    .CLK_OUT3(dvi_clk315),
    .LOCKED(gpu_locked),
    .RESET(cpu_rst)
);

//-----------------------------------------------------------------
// Reset
//-----------------------------------------------------------------

reset_gen
cpu_rst_gen
(
    .clk_i(cpu_clk),
    .rst_o(cpu_rst)
);


reset_gen
codec_rst_gen
(
    .clk_i(codec_clk),
    .rst_o(codec_rst)
);


reset_gen
gpu_rst_gen
(
    .clk_i(gpu_clk),
    .rst_o(gpu_rst)
);

assign DVI0_RESET_N = ~cpu_rst;
assign DVI1_RESET_N = ~cpu_rst;

//-----------------------------------------------------------------
// Core
//-----------------------------------------------------------------
wire        dbg_txd_w;
wire        uart_txd_w;

wire        spi_clk_w;
wire        spi_so_w;
wire        spi_si_w;
wire [7:0]  spi_cs_w;

wire [31:0] gpio_in_w;
wire [31:0] gpio_out_w;
wire [31:0] gpio_out_en_w;
wire [23:0] boot_spi_adr_w;

fpga_top
#(
    .CLK_FREQ(28320000)
   ,.BAUDRATE(1000000)   // SoC UART baud rate
   ,.UART_SPEED(1000000) // Debug bridge UART baud (should match BAUDRATE)
   ,.C_SCK_RATIO(1)      // SPI clock divider (M25P128 maxclock = 54 Mhz)
   ,.CPU("riscv")        // riscv or armv6m
)
u_top
(
    .clock_125_i(clk125)
    ,.clk_i(cpu_clk)
    ,.rst_i(cpu_rst)

    ,.dbg_rxd_o(dbg_txd_w)
    ,.dbg_txd_i(uart_txd_i)

    ,.uart_tx_o(uart_txd_w)
    ,.uart_rx_i(uart_txd_i)

    ,.spi_clk_o(spi_clk_w)
    ,.spi_mosi_o(spi_si_w)
    ,.spi_miso_i(spi_so_w)
    ,.spi_cs_o(spi_cs_w)
    ,.gpio_input_i(gpio_in_w)
    ,.gpio_output_o(gpio_out_w)
    ,.gpio_output_enable_o(gpio_out_en_w)
    ,.boot_spi_adr_o(boot_spi_adr_w)
    ,.reboot_o(reboot_o)

`ifdef INCLUDE_ETHERNET
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
  // 
    ,.mdc_o(mdc_o)
    ,.mdio_io(mdio_io)
`endif

    // I2C busses
    ,.i2c0_scl()//codec_scl)
    ,.i2c0_sda()//codec_sda)

    ,.i2c1_scl(encoder_scl)
    ,.i2c1_sda(encoder_sda)

    ,.i2c2_scl(dvi0_scl)
    ,.i2c2_sda(dvi0_sda)

    ,.i2c3_scl(dvi1_scl)
    ,.i2c3_sda(dvi1_sda)


    // DVI Interfaces
    ,.gpu_clk(gpu_clk)
    ,.dvi_clk(dvi_clk0)
    ,.dvi_clk180(dvi_clk180)
    ,.dvi_clk315(dvi_clk315)
    ,.gpu_rst(gpu_rst)
    ,.dvi0_hsync(DVI0_HSYNC)
    ,.dvi0_vsync(DVI0_VSYNC)
    ,.dvi0_de(DVI0_DE)
    ,.dvi0_clkp(DVI0_CLK_P)
    ,.dvi0_clkn(DVI0_CLK_N)
    ,.dvi0_data(DVI0_DATA)
    ,.dvi0_resetn(DVI0_RESET_N)

    ,.dvi1_hsync(DVI1_HSYNC)
    ,.dvi1_vsync(DVI1_VSYNC)
    ,.dvi1_de(DVI1_DE)
    ,.dvi1_clkp(DVI1_CLK_P)
    ,.dvi1_clkn()
    ,.dvi1_data(DVI1_DATA)
    ,.dvi1_resetn(DVI1_RESET_N)
);

//-----------------------------------------------------------------
// Speaker
//-----------------------------------------------------------------
i2s_stream audio_out (
    .clk_i(codec_clk)
   ,.rst_i(codec_rst)

   ,.speaker_i(1'b0)

   ,.mclk_o(codec_mclk)
   ,.bclk_o(codec_bclk)
   ,.lrc_o(codec_daclrc)
   ,.sda_o(codec_dacdat)
);

assign codec_adclrc = codec_daclrc;

//-----------------------------------------------------------------
// SPI Flash
//-----------------------------------------------------------------
assign flash_sck_o = spi_clk_w;
assign flash_si_o  = spi_si_w;
assign flash_cs_o  = spi_cs_w[0];
assign spi_so_w    = flash_so_i;

//-----------------------------------------------------------------
// GPIO bits
// 0: Not implmented
// 1: Pano button
// 2: Output only - red LED
// 3: In/out - green LED
// 4: In/out - blue LED
// 5: Wolfson codec SDA
// 6: Wolfson codec SCL
// 7: GMII reset
// 9...31: Not implmented
//-----------------------------------------------------------------

assign gpio_in_w[0]  = gpio_out_w[0];

assign pano_button = gpio_out_en_w[1]  ? gpio_out_w[1]  : 1'bz;
assign gpio_in_w[1]  = pano_button;

assign led_red = gpio_out_w[2];
assign gpio_in_w[2]  = led_red;

assign led_green = gpio_out_en_w[3]  ? gpio_out_w[3]  : 1'bz;
assign gpio_in_w[3]  = led_green;

assign led_blue = gpio_out_en_w[4]  ? gpio_out_w[4]  : 1'bz;
assign gpio_in_w[4]  = led_blue;

assign codec_sda = gpio_out_en_w[5] ? gpio_out_w[5] : 1'bz;
assign gpio_in_w[5]  = codec_sda;

assign codec_scl = gpio_out_en_w[6] ? gpio_out_w[6] : 1'bz;
assign gpio_in_w[6]  = codec_scl;

//assign gpio_in_w[5]  = 1'b0;

//assign gpio_in_w[6]  = 1'b0;

assign gpio_in_w[7]  = 1'b0;

assign pwr_status[0] = gpio_out_en_w[8] ? gpio_out_w[8] : 1'bz;
assign gpio_in_w[8]  = pwr_status[0];

assign pwr_status[1] = gpio_out_en_w[8] ? gpio_out_w[9] : 1'bz;
assign gpio_in_w[9]  = pwr_status[1];

assign pwr_status[2] = gpio_out_en_w[10] ? gpio_out_w[10] : 1'bz;
assign gpio_in_w[10]  = pwr_status[2];

assign pwr_status[3] = gpio_out_en_w[11] ? gpio_out_w[11] : 1'bz;
assign gpio_in_w[11]  = pwr_status[3];

genvar i;
generate
for (i=12; i < 32; i=i+1) begin : gpio_in
    assign gpio_in_w[i]  = gpio_out_w[i];
end
endgenerate

//-----------------------------------------------------------------
// UART Tx combine
//-----------------------------------------------------------------
// Xilinx placement pragmas:
//synthesis attribute IOB of uart_rxd_o is "TRUE"
//reg txd_q;
//
//always @ (posedge cpu_clk or posedge cpu_rst)
//if (cpu_rst)
//    txd_q <= 1'b1;
//else
//    txd_q <= dbg_txd_w & uart_txd_w;
//
// 'OR' two UARTs together
//assign uart_rxd_o  = txd_q;

//-----------------------------------------------------------------
// Tie-offs
//-----------------------------------------------------------------

// Must remove reset from the Ethernet Phy for 125 Mhz input clock.
// See https://github.com/tomverbeure/panologic-g2
assign GMII_RST_N = !gpio_out_w[7];

//-----------------------------------------------------------------
// Boot another bitstream
//-----------------------------------------------------------------

multiboot u_boot
(
    .clk(cpu_clk)
    ,.rst(cpu_rst)
    ,.boot(reboot_o)
    ,.boot_spi_adr(boot_spi_adr_w)
);

endmodule
