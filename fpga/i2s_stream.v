// 48KHz Stereo I2S stream from a 16-bit DAC input

module i2s_stream(
     input          clk_i
    ,input          rst_i
    ,input          speaker_i

    ,output         mclk_o
    ,output         bclk_o
    ,output         lrc_o
    ,output         sda_o
);

// We'll use 48 Khz so our sample rate is MCLK / 256

reg [15:0] next_sample;
reg [15:0] this_sample;
reg  [8:0] clk_div;

// clk_div[0] = 12.288 MHz
// clk_div[1] =  6.144 MHz
// clk_div[2] =  3.072 MHz
// clk_div[3] =  1.536 MHz
// clk_div[4] =    768 KHz
// clk_div[5] =    384 KHz
// clk_div[6] =    192 KHz
// clk_div[7] =     96 KHz
// clk_div[8] =     48 KHz

assign mclk_o = ~clk_div[0]; // 12.288 MHz
assign bclk_o = ~clk_div[2]; //  3.072 MHz
assign lrc_o  = clk_div[8:3] == 6'b0; // 48.000 KHz
assign sda_o  = this_sample[~clk_div[6:3]];

reg last_speaker = 1'b0;
reg [15:0] timeout = 16'd0;

always @(posedge clk_i) begin
    if (rst_i) begin
        clk_div <= 0;
    end
    else begin
        if(speaker_i != last_speaker) begin
           next_sample <= next_sample ? 16'h0000 : 16'h3fff;
           timeout <= 16'hffff;
           last_speaker <= speaker_i;
        end

        clk_div <= clk_div + 1;

        if(clk_div[7:0] == 8'hff) begin
            this_sample <= next_sample;
            if(timeout == 16'h1)
                next_sample <= 16'h0;
            if(timeout != 16'b0)
                timeout <= timeout - 1;
        end
    end
end

endmodule
