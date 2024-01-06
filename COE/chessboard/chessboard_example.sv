module chessboard_example (
	input logic vga_clk,
	input logic [9:0] DrawX, DrawY,
	output logic [3:0] red, green, blue,
	output logic boardon
);

logic [17:0] rom_address;
logic [3:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

logic negedge_vga_clk;

// read from ROM on negedge, set pixel on posedge
assign negedge_vga_clk = ~vga_clk;

// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
// this will stretch out the sprite across the entire screen

always_ff @ (posedge vga_clk) begin
		red <= palette_red;
		green <= palette_green;
		blue <= palette_blue;
end

always_comb begin
	if (DrawX >= 80 && DrawX <= 559) begin
		boardon  = 1;
//		rom_address = (DrawX - 80)/2 + DrawY * 120;
        rom_address = ((DrawX - 80) * 240) / 480 + (((DrawY * 240) / 480) * 240);
    end
	else begin
		boardon = 0;
		rom_address = 0;
	end
end

chessboard_rom chessboard_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_q)
);

chessboard_palette chessboard_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule
