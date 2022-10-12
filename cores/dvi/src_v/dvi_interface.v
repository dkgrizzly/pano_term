
module dvi_interface (
    input         gpu_clk0,           // Pixel Clock
    input         dvi_clk0,           // TFT Clock
    input         dvi_clk180,         // TFT Clock 180 Phase
    input         dvi_clk315,         // TFT Clock 315 Phase
    input         Rst,                // TFT Reset
    input         hsync_in,           // Hsync input
    input         vsync_in,           // Vsync input
    input         de_in,              // Data Enable
    input   [7:0] red_in,             // RED pixel data 
    input   [7:0] green_in,           // Green pixel data
    input   [7:0] blue_in,            // Blue pixel data
    output        HSYNC,              // TFT Hsync
    output        VSYNC,              // TFT Vsync
    output        DE,                 // TFT data enable
    output        DVI_CLK_P,          // TFT DVI differential clock
    output        DVI_CLK_N,          // TFT DVI differential clock
    output [11:0] DVI_DATA            // TFT DVI pixel data
);

   wire gpu_clk180 = ~gpu_clk0;

    // HSYNC
    FDS FDS_HSYNC (
         .Q(HSYNC)
        ,.C(dvi_clk180)
        ,.S(Rst)
        ,.D(hsync_in)
    ); 

    // VSYNC
    FDS FDS_VSYNC (
         .Q(VSYNC)
        ,.C(dvi_clk180)
        ,.S(Rst)
        ,.D(vsync_in)
    );

    // DE
    FDR FDR_DE (
         .Q(DE)
        ,.C(dvi_clk180)
        ,.R(Rst)
        ,.D(de_in)
    );

    wire [11:0] dvi_data_a;
    wire [11:0] dvi_data_b;

    assign dvi_data_b[3:0]  = green_in[7:4];
    assign dvi_data_b[11:4] = red_in[7:0];
    assign dvi_data_a[7:0]  = blue_in[7:0];
    assign dvi_data_a[11:8] = green_in[3:0];

    //// DVI Clock P
    ODDR2 CLKP_ODDR2 (
         .Q(DVI_CLK_P)
        ,.C0(dvi_clk315)
        ,.C1(~dvi_clk315)
        ,.CE(1'b1)
        ,.R(Rst)
        ,.D0(1'b0)
        ,.D1(1'b1)
        ,.S(1'b0)
    );
                        
    // DVI Clock N
    ODDR2 CLKN_ODDR2 (
         .Q(DVI_CLK_N)
        ,.C0(dvi_clk315)
        ,.C1(~dvi_clk315)
        ,.CE(1'b1)
        ,.R(Rst)
        ,.D0(1'b1)
        ,.D1(1'b0)
        ,.S(1'b0)
    );

    generate
        begin : gen_dvi_if
            genvar i;
            for (i=0;i<12;i=i+1) begin : replicate_tft_dvi_data
                ODDR2 #(
                     .DDR_ALIGNMENT ("C0")
                    ,.SRTYPE        ("ASYNC")
                ) ODDR2_DATA (
                      .Q(DVI_DATA[i])
                     ,.C0(gpu_clk0)
                     ,.C1(gpu_clk180)
                     ,.CE(1'b1)
                     ,.R(~de_in|Rst)
                     ,.D1(dvi_data_b[i])
                     ,.D0(dvi_data_a[i])
                     ,.S(1'b0)
                );
            end 
        end 
    endgenerate  
endmodule
