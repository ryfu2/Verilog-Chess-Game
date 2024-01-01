`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/21/2023 02:51:25 PM
// Design Name: 
// Module Name: board_info
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module board_info(
    input Clk, reset, wren,
    input [2:0] wrrol, wrcol,
    input [3:0] wdatain,
    input [2:0] rol1, col1, rol2, col2, rol3, col3, rol4, col4,
    output[3:0] dout1, dout2, dout3, dout4 
    );
    reg [3:0] Board [7:0][7:0];
    always @ (posedge Clk) begin
        if (reset) begin
        // Board Info
        Board[0][0] <= 4'b1110;
        Board[1][0] <= 4'b1100;
        Board[2][0] <= 4'b1101;
        Board[3][0] <= 4'b1011;
        Board[4][0] <= 4'b1010;
        Board[5][0] <= 4'b1101;
        Board[6][0] <= 4'b1100;
        Board[7][0] <= 4'b1110;
        Board[0][1] <= 4'b1001;
        Board[1][1] <= 4'b1001;
        Board[2][1] <= 4'b1001;
        Board[3][1] <= 4'b1001;
        Board[4][1] <= 4'b1001;
        Board[5][1] <= 4'b1001;
        Board[6][1] <= 4'b1001;
        Board[7][1] <= 4'b1001;
        Board[0][6] <= 4'b0001;
        Board[1][6] <= 4'b0001;
        Board[2][6] <= 4'b0001;
        Board[3][6] <= 4'b0001;
        Board[4][6] <= 4'b0001;
        Board[5][6] <= 4'b0001;
        Board[6][6] <= 4'b0001;
        Board[7][6] <= 4'b0001;
        Board[0][7] <= 4'b0110;
        Board[1][7] <= 4'b0100;
        Board[2][7] <= 4'b0101;
        Board[3][7] <= 4'b0011;
        Board[4][7] <= 4'b0010;
        Board[5][7] <= 4'b0101;
        Board[6][7] <= 4'b0100;
        Board[7][7] <= 4'b0110;
        Board[0][5] <= 4'b0000;
        Board[1][5] <= 4'b0000;
        Board[2][5] <= 4'b0000;
        Board[3][5] <= 4'b0000;
        Board[4][5] <= 4'b0000;
        Board[5][5] <= 4'b0000;
        Board[6][5] <= 4'b0000;
        Board[7][5] <= 4'b0000;
        Board[0][4] <= 4'b0000;
        Board[1][4] <= 4'b0000;
        Board[2][4] <= 4'b0000;
        Board[3][4] <= 4'b0000;
        Board[4][4] <= 4'b0000;
        Board[5][4] <= 4'b0000;
        Board[6][4] <= 4'b0000;
        Board[7][4] <= 4'b0000;
        Board[0][3] <= 4'b0000;
        Board[1][3] <= 4'b0000;
        Board[2][3] <= 4'b0000;
        Board[3][3] <= 4'b0000;
        Board[4][3] <= 4'b0000;
        Board[5][3] <= 4'b0000;
        Board[6][3] <= 4'b0000;
        Board[7][3] <= 4'b0000;
        Board[0][2] <= 4'b0000;
        Board[1][2] <= 4'b0000;
        Board[2][2] <= 4'b0000;
        Board[3][2] <= 4'b0000;
        Board[4][2] <= 4'b0000;
        Board[5][2] <= 4'b0000;
        Board[6][2] <= 4'b0000;
        Board[7][2] <= 4'b0000;
        end
        if (wren) begin
        Board[wrrol][wrcol] <= wdatain;
        end
    end
    assign dout1 = Board[rol1][col1];
    assign dout2 = Board[rol2][col2];
    assign dout3 = Board[rol3][col3];
    assign dout4 = Board[rol4][col4];
endmodule
