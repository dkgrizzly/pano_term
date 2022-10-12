module crtc
(
    // CPU Clock Domain
     input wire clk_i
    ,input wire rst_i

    ,input wire enable_i

    ,input wire [11:0] ha_i
    ,input wire [11:0] hfw_i
    ,input wire [11:0] hsw_i
    ,input wire [11:0] hbw_i

    ,input wire [11:0] va_i
    ,input wire [11:0] vfw_i
    ,input wire [11:0] vsw_i
    ,input wire [11:0] vbw_i

    // Video Clock Domain
    ,input wire pclk_i
    ,input wire prst_i
    ,output wire vsync_o
    ,output wire hsync_o
    ,output wire valid_o
    ,output wire [11:0] x_o
    ,output wire [11:0] y_o
    ,output wire [11:0] raw_x_o
    ,output wire [11:0] raw_y_o
);

wire [11:0] H_BLANK;
wire [11:0] V_BLANK;
wire [11:0] H_TOTAL;
wire [11:0] V_TOTAL;

assign H_BLANK = hfw_i + hsw_i + hbw_i;
assign V_BLANK = vfw_i + vsw_i + vbw_i;

assign H_TOTAL = H_BLANK + ha_i;
assign V_TOTAL = V_BLANK + va_i;

// Absolute Coordinates
reg [11:0] xcoord;
reg [11:0] ycoord;

// Active Coordinates
wire [11:0] pixel_y;
wire [11:0] pixel_x;

assign vsync_o = enable_i && (ycoord >= vfw_i) && (ycoord < (vfw_i + vsw_i));
assign hsync_o = enable_i && (xcoord >= hfw_i) && (xcoord < (hfw_i + hsw_i));

assign pixel_y = (ycoord - V_BLANK);
assign pixel_x = (xcoord - H_BLANK);

assign y_o = enable_i ? pixel_y[11:0] : 12'd0;
assign x_o = enable_i ? pixel_x[11:0] : 12'd0;

assign raw_y_o = ycoord;
assign raw_x_o = xcoord;

assign valid_o = enable_i && (ycoord >= V_BLANK) && (xcoord >= H_BLANK);

always @ (posedge pclk_i or posedge prst_i) begin
    if(prst_i) begin
        ycoord = 12'd0;
        xcoord = 12'd0;
    end else if(xcoord < H_TOTAL) begin
        xcoord = xcoord + 12'd1;
    end else if(ycoord < V_TOTAL) begin
        ycoord = ycoord + 12'd1;
        xcoord = 12'd0;
    end else begin
        ycoord = 12'd0;
        xcoord = 12'd0;
    end
end

endmodule
