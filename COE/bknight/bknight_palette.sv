module bknight_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

localparam [0:3][11:0] palette = {
	{4'hD, 4'h4, 4'h3},
	{4'h3, 4'h3, 4'h3},
	{4'h5, 4'h5, 4'h5},
	{4'hD, 4'h7, 4'h6}
};

assign {red, green, blue} = palette[index];

endmodule
