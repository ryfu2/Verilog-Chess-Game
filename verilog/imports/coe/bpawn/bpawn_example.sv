module bpawn_example (
	input logic vga_clk,
	input logic [9:0] DrawX, DrawY,
	input logic [9:0] offsetX, offsetY,
	output logic [3:0] red, green, blue,
	output logic pawn_on
);

logic [11:0] rom_address;
logic [3:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

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
		red <= palette_red;
		green <= palette_green;
		blue <= palette_blue;
end

bpawn bpawn_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_q)
);

bpawn_palette bpawn_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule
