module console (
     input cpu_clk_i
    ,input cpu_rst_i

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

    ,input          gpu_clk_i
    ,input          gpu_rst_i

    ,input          vsync_i
    ,input          hsync_i

    ,input  [11:0]  py_i
    ,input  [11:0]  px_i

    ,input          valid_i

    ,output [23:0]  pixel_o
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

always @ (posedge cpu_clk_i or posedge cpu_rst_i)
if (cpu_rst_i)
    awvalid_q <= 1'b0;
else if (cfg_awvalid_i && cfg_awready_o && !wr_data_accepted_w)
    awvalid_q <= 1'b1;
else if (wr_data_accepted_w)
    awvalid_q <= 1'b0;

always @ (posedge cpu_clk_i or posedge cpu_rst_i)
if (cpu_rst_i)
    wvalid_q <= 1'b0;
else if (cfg_wvalid_i && cfg_wready_o && !wr_cmd_accepted_w)
    wvalid_q <= 1'b1;
else if (wr_cmd_accepted_w)
    wvalid_q <= 1'b0;


//-----------------------------------------------------------------
// Capture write address (for delayed data)
//-----------------------------------------------------------------
reg [15:0] wr_addr_q;

always @ (posedge cpu_clk_i or posedge cpu_rst_i)
if (cpu_rst_i)
    wr_addr_q <= 16'b0;
else if (cfg_awvalid_i && cfg_awready_o)
    wr_addr_q <= cfg_awaddr_i[17:2];

wire [15:0] wr_addr_w = awvalid_q ? wr_addr_q : cfg_awaddr_i[17:2];


//-----------------------------------------------------------------
// Retime write data
//-----------------------------------------------------------------
reg [31:0] wr_data_q;

always @ (posedge cpu_clk_i or posedge cpu_rst_i)
if (cpu_rst_i)
    wr_data_q <= 32'b0;
else if (cfg_wvalid_i && cfg_wready_o)
    wr_data_q <= cfg_wdata_i[31:0];

wire [31:0] wr_data_w = wvalid_q ? wr_data_q : cfg_wdata_i[31:0];


//-----------------------------------------------------------------
// RVALID
//-----------------------------------------------------------------
reg rvalid_q;

always @ (posedge cpu_clk_i or posedge cpu_rst_i)
if (cpu_rst_i)
    rvalid_q <= 1'b0;
else if (axil_read_ready)
    rvalid_q <= 1'b1;
else if (cfg_rready_i)
    rvalid_q <= 1'b0;

assign cfg_rvalid_o = rvalid_q;


//-----------------------------------------------------------------
// Read Address
//-----------------------------------------------------------------
reg arvalid_q;

wire rd_data_accepted_w = (cfg_rvalid_o && cfg_rready_i) || rvalid_q;

always @ (posedge cpu_clk_i or posedge cpu_rst_i)
if (cpu_rst_i)
    arvalid_q <= 1'b0;
else if (cfg_arvalid_i && cfg_arready_o && !rd_data_accepted_w)
    arvalid_q <= 1'b1;
else if (rd_data_accepted_w)
    arvalid_q <= 1'b0;

reg [15:0] rd_addr_q;

always @ (posedge cpu_clk_i or posedge cpu_rst_i)
if (cpu_rst_i)
    rd_addr_q <= 16'b0;
else if (cfg_arvalid_i && cfg_arready_o)
    rd_addr_q <= cfg_araddr_i[17:2];

wire [15:0] rd_addr_w = arvalid_q ? rd_addr_q : cfg_araddr_i[17:2];


//-----------------------------------------------------------------
// Request Logic
//-----------------------------------------------------------------
wire axil_read_ready = cfg_arvalid_i && cfg_arready_o;
wire read_en_w  = ~cfg_rvalid_o || cfg_rready_i;
wire write_en_w = wr_cmd_accepted_w && wr_data_accepted_w;


//-----------------------------------------------------------------
// Accept Logic
//-----------------------------------------------------------------
assign cfg_arready_o = ~cfg_rvalid_o;
assign cfg_awready_o = ~cfg_bvalid_o && ~cfg_arvalid_i && ~awvalid_q;
assign cfg_wready_o  = ~cfg_bvalid_o && ~cfg_arvalid_i && ~wvalid_q;


//-----------------------------------------------------------------
// Register read response
//-----------------------------------------------------------------
assign cfg_rresp_o = 2'b0;


//-----------------------------------------------------------------
// BVALID
//-----------------------------------------------------------------
reg bvalid_q;

always @ (posedge cpu_clk_i or posedge cpu_rst_i)
if (cpu_rst_i)
    bvalid_q <= 1'b0;
else if (write_en_w)
    bvalid_q <= 1'b1;
else if (cfg_bready_i)
    bvalid_q <= 1'b0;

assign cfg_bvalid_o = bvalid_q;
assign cfg_bresp_o  = 2'b0;


//-----------------------------------------------------------------
// Memories
//-----------------------------------------------------------------

reg [15:0] font[4095:0];

initial begin
    $readmemb("ptermhfont.bin", font);
end

reg [31:0] vram0[16383:0];
reg [31:0] vram1[16383:0];
reg [31:0] shadow[32767:0];
reg [31:0] rd_data_q;

assign cfg_rdata_o = rd_data_q;

always @ (posedge cpu_clk_i) begin
    if (cpu_rst_i) begin
        rd_data_q <= 32'b0;
    end else begin
        if(write_en_w) begin
            shadow[wr_addr_w] <= wr_data_w;
        end
        if(write_en_w && ~wr_addr_w[0]) begin
            vram0[wr_addr_w[14:1]] <= wr_data_w;
        end
        if(write_en_w && wr_addr_w[0]) begin
            vram1[wr_addr_w[14:1]] <= wr_data_w;
        end

        if(!cfg_rvalid_o || cfg_rready_i) begin
            rd_data_q <= shadow[rd_addr_w[14:0]];
        end
    end
end


reg [6:0] v_row;
reg [7:0] v_col;
reg [3:0] v_x;
reg [3:0] v_y;

reg [14:0] v_addr;
reg [63:0] v_data;

reg [15:0] cbits;

reg [23:0] fg = 24'hffffff;
reg [23:0] bg = 24'h000000;

wire [23:0] border = ((py_i > 12'd19) && (py_i < 12'd22)) ? 24'h777777 : 24'h000000;
wire [23:0] text = cbits[15] ? fg : bg;
assign pixel_o = valid_i ? (((py_i < 12'd16) || (py_i > 12'd25)) ? text : border) : 24'h000000;

always @ (posedge gpu_clk_i or posedge gpu_rst_i) begin
    if(gpu_rst_i) begin
        fg <= 24'hffffff;
        bg <= 24'h000000;
        v_col <= 8'd0;
        v_row <= 7'd0;
        v_x <= 4'd0;
        v_y <= 4'd0;
        v_addr <= 15'h0;
        cbits <= 16'h0;

    end else if(hsync_i) begin
        v_x <= 4'd0;
        v_col <= 8'd0;

    end else if(vsync_i) begin
        v_addr <= 15'h0;
        v_col <= 8'd0;
        v_row <= 7'd0;
        v_x <= 4'd0;
        v_y <= 4'd0;

    end else if(valid_i && ((py_i < 12'd16) || (py_i > 12'd25))) begin
        if(v_x == 4'd5) begin
            v_addr <= ((v_row == 7'd65) && (v_col == 8'd159) && (v_y != 4'hf)) ? 15'd0 :
                      (((v_col == 8'd159) && (v_y != 4'hf)) ? (v_addr - 15'd159) : (v_addr + 15'd1));
            v_row <= ((v_col == 8'd159) && (v_y == 4'hf)) ? (v_row + 7'd1) : v_row;
            v_y <= (v_col == 8'd159) ? (v_y + 4'd1) : v_y;
            v_col <= (v_col == 8'd159) ? 8'd0 : (v_col + 8'd1);

        end else if(v_x == 4'd8) begin
            v_data[63:32] <= vram1[ v_addr ];
            v_data[31:0]  <= vram0[ v_addr ];
        end

        if(v_x == 4'd11) begin
            cbits <= font[ { v_data[7:0], v_y[3:0] } ];
            fg <= v_data[31:8];
            bg <= v_data[63:40];
        end else begin
            cbits <= { cbits[14:0], 1'b0 };
        end

        v_x <= (v_x == 4'd11) ? 4'd0 : (v_x + 4'd1);
    end
end

endmodule
