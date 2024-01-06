module bpawn_example (
	input logic vga_clk,
	input logic [9:0] DrawX, DrawY,
	input logic [9:0] offsetX, offsetY,
	input logic [2:0] promotion,
	output logic [3:0] red, green, blue,
	output logic pawn_on
);

logic [11:0] rom_address;
logic [3:0] rom_pq, rom_qq, rom_kq, rom_bq, rom_rq;

logic [3:0] ppalette_red, ppalette_green, ppalette_blue;
logic [3:0] kpalette_red, kpalette_green, kpalette_blue;
logic [3:0] bpalette_red, bpalette_green, bpalette_blue;
logic [3:0] qpalette_red, qpalette_green, qpalette_blue;
logic [3:0] rpalette_red, rpalette_green, rpalette_blue;

logic negedge_vga_clk;

// read from ROM on negedge, set pixel on posedge
assign negedge_vga_clk = ~vga_clk;

// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
// this will stretch out the sprite across the entire screen
always_comb begin
        if ((DrawX - offsetX) <= 54 && (DrawX - offsetX) >= 0 && (DrawY - offsetY) <= 54 && (DrawY - offsetY) >= 0)
        begin
            rom_address = (DrawX - offsetX) + (DrawY - offsetY) * 55;
            pawn_on = 1;
        end
        else
        begin
            rom_address = 0;
            pawn_on = 0;  
        end
end
always_ff @ (posedge vga_clk) begin
    case (promotion)
    0: begin
		red <= ppalette_red;
		green <= ppalette_green;
		blue <= ppalette_blue;
    end
    1: begin
		red <= qpalette_red;
		green <= qpalette_green;
		blue <= qpalette_blue;
    end
    4: begin
		red <= bpalette_red;
		green <= bpalette_green;
		blue <= bpalette_blue;
    end
    2: begin
		red <= kpalette_red;
		green <= kpalette_green;
		blue <= kpalette_blue;
    end
    3: begin
        red <= rpalette_red;
		green <= rpalette_green;
		blue <= rpalette_blue;
    end
    endcase
end

bpawn bpawn_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_pq)
);

bpawn_palette bpawn_palette (
	.index (rom_pq),
	.red   (ppalette_red),
	.green (ppalette_green),
	.blue  (ppalette_blue)
);

bknight_rom bknight_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_kq)
);

bknight_palette bknight_palette (
	.index (rom_kq),
	.red   (kpalette_red),
	.green (kpalette_green),
	.blue  (kpalette_blue)
);

bbishop bbishop_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_bq)
);

bbishop_palette bbishop_palette (
	.index (rom_bq),
	.red   (bpalette_red),
	.green (bpalette_green),
	.blue  (bpalette_blue)
);

bqueen_rom bqueen_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_qq)
);

bqueen_palette bqueen_palette (
	.index (rom_qq),
	.red   (qpalette_red),
	.green (qpalette_green),
	.blue  (qpalette_blue)
);

brock_rom brock_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_rq)
);

brock_palette brock_palette (
	.index (rom_rq),
	.red   (rpalette_red),
	.green (rpalette_green),
	.blue  (rpalette_blue)
);

endmodule
