module wking_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

localparam [0:3][11:0] palette = {
	{4'hE, 4'h5, 4'h4},
	{4'hF, 4'hF, 4'hF},
	{4'h6, 4'h4, 4'h4},
	{4'hA, 4'hA, 4'hA}
};

assign {red, green, blue} = palette[index];

endmodule
