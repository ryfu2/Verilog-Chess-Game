`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/21/2023 02:36:55 PM
// Design Name: 
// Module Name: moving_states
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


module moving_states(
    input Clk, reset,
    input [3:0] click, 
    input [9:0] mousex, mousey,
    output reg [3:0] wp1x, wp2x, wp3x, wp4x, wp5x, wp6x, wp7x, wp8x,
    output reg [3:0] wp1y, wp2y, wp3y, wp4y, wp5y, wp6y, wp7y, wp8y,
    output reg [3:0] bp1x, bp2x, bp3x, bp4x, bp5x, bp6x, bp7x, bp8x,
    output reg [3:0] bp1y, bp2y, bp3y, bp4y, bp5y, bp6y, bp7y, bp8y,
    output reg [3:0] wr1x, wr1y, wr2x, wr2y, br1x, br1y, br2x, br2y,
    output reg [3:0] wb1x, wb1y, wb2x, wb2y, bb1x, bb1y, bb2x, bb2y,
    output reg [3:0] wk1x, wk1y, wk2x, wk2y, bk1x, bk1y, bk2x, bk2y,
    output reg [3:0] wqx, wqy, bqx, bqy,
    output reg [3:0] wkx, wky, bkx, bky,
    output reg [5:0] state,
    output reg [5:0] capturecode
//    output reg [3:0] wp1x, wp2x, wp3x, wp4x, wp5x, wp6x, wp7x, wp8x,
//    output reg [3:0] wp1y, wp2y, wp3y, wp4y, wp5y, wp6y, wp7y, wp8y
    );
    reg [5:0] Board [0:8][0:8];
    integer i;
    reg wr1moved, wr2moved, br1moved, br2moved, wkmoved, bkmoved;
    parameter wt = 6'd0;
    parameter bt = 6'd1;
    parameter wp1 = 6'd2;
    parameter bp1 = 6'd3;
    parameter wp2 = 6'd4;
    parameter bp2 = 6'd5;
    parameter wp3 = 6'd6;
    parameter bp3 = 6'd7;
    parameter wp4 = 6'd8;
    parameter bp4 = 6'd9;
    parameter wp5 = 6'd10;
    parameter bp5 = 6'd11;
    parameter wp6 = 6'd12;
    parameter bp6 = 6'd13;
    parameter wp7 = 6'd14;
    parameter bp7 = 6'd15;
    parameter wp8 = 6'd16;
    parameter bp8 = 6'd17;
    parameter wr1 = 6'd18;
    parameter br1 = 6'd19;
    parameter wr2 = 6'd20;
    parameter br2 = 6'd21;
    parameter wb1 = 6'd22;
    parameter bb1 = 6'd23;
    parameter wb2 = 6'd24;
    parameter bb2 = 6'd25;
    parameter wk1 = 6'd26;
    parameter bk1 = 6'd27;
    parameter wk2 = 6'd28;
    parameter bk2 = 6'd29;
    parameter wq = 6'd30;
    parameter bq = 6'd31;
    parameter wk = 6'd32;
    parameter bk = 6'd33;
    reg [3:0] rol, col;
    reg [3:0] clickedrol, clickedcol;
    wire[4:0] blackpiece;
    reg[6:0] movementvalid;
    assign blackpiece = Board[rol][col][4:0];
    
    
    always @(*) begin
        if (mousex < 100 || mousex >= 560)
            rol = 8;
        else
            rol = (mousex - 10'd100) / 55;
        if (mousey < 20 || mousey >= 480)
            col = 8;
        else
            col = (mousey - 10'd20) / 55;
    end
    
    always @ (posedge Clk)
    begin
        if (reset) begin
            capturecode <= 0;
            state <= wt;
            wr1moved <= 0;
            wr2moved <= 0;
            br1moved <= 0;
            br2moved <= 0;
            wkmoved <= 0;
            bkmoved <= 0;
            Board[0][1] <= 6'b100001;
            Board[1][1] <= 6'b100010;
            Board[2][1] <= 6'b100011;
            Board[3][1] <= 6'b100100;
            Board[4][1] <= 6'b100101;
            Board[5][1] <= 6'b100110;
            Board[6][1] <= 6'b100111;
            Board[7][1] <= 6'b101000;
            Board[0][0] <= 6'b101001;
            Board[1][0] <= 6'b101101;
            Board[2][0] <= 6'b101011;
            Board[3][0] <= 6'b101111;
            Board[4][0] <= 6'b110000;
            Board[5][0] <= 6'b101100;
            Board[6][0] <= 6'b101110;
            Board[7][0] <= 6'b101010;
            Board[0][6] <= 6'b000001;
            Board[1][6] <= 6'b000010;
            Board[2][6] <= 6'b000011;
            Board[3][6] <= 6'b000100;
            Board[4][6] <= 6'b000101;
            Board[5][6] <= 6'b000110;
            Board[6][6] <= 6'b000111;
            Board[7][6] <= 6'b001000;
            Board[0][7] <= 6'b001001;
            Board[1][7] <= 6'b001101;
            Board[2][7] <= 6'b001011;
            Board[3][7] <= 6'b001111;
            Board[4][7] <= 6'b010000;
            Board[5][7] <= 6'b001100;
            Board[6][7] <= 6'b001110;
            Board[7][7] <= 6'b001010;
            Board[0][5] <= 0;
            Board[1][5] <= 0;
            Board[2][5] <= 0;
            Board[3][5] <= 0;
            Board[4][5] <= 0;
            Board[5][5] <= 0;
            Board[6][5] <= 0;
            Board[7][5] <= 0;
            Board[0][4] <= 0;
            Board[1][4] <= 0;
            Board[2][4] <= 0;
            Board[3][4] <= 0;
            Board[4][4] <= 0;
            Board[5][4] <= 0;
            Board[6][4] <= 0;
            Board[7][4] <= 0;
            Board[0][3] <= 0;
            Board[1][3] <= 0;
            Board[2][3] <= 0;
            Board[3][3] <= 0;
            Board[4][3] <= 0;
            Board[5][3] <= 0;
            Board[6][3] <= 0;
            Board[7][3] <= 0;
            Board[0][2] <= 0;
            Board[1][2] <= 0;
            Board[2][2] <= 0;
            Board[3][2] <= 0;
            Board[4][2] <= 0;
            Board[5][2] <= 0;
            Board[6][2] <= 0;
            Board[7][2] <= 0;
            Board[0][8] <= 0;
            Board[1][8] <= 0;
            Board[2][8] <= 0;
            Board[3][8] <= 0;
            Board[4][8] <= 0;
            Board[5][8] <= 0;
            Board[6][8] <= 0;
            Board[7][8] <= 0;
            Board[8][0] <= 0;
            Board[8][1] <= 0;
            Board[8][2] <= 0;
            Board[8][3] <= 0;
            Board[8][4] <= 0;
            Board[8][5] <= 0;
            Board[8][6] <= 0;
            Board[8][7] <= 0;
            Board[8][8] <= 0;
            wp1x <= 0;
            wp1y <= 6;
            wp2x <= 1;
            wp2y <= 6;
            wp3x <= 2;
            wp3y <= 6;
            wp4x <= 3;
            wp4y <= 6;
            wp5x <= 4;
            wp5y <= 6;
            wp6x <= 5;
            wp6y <= 6;
            wp7x <= 6;
            wp7y <= 6;
            wp8x <= 7;
            wp8y <= 6;
            bp1x <= 0;
            bp1y <= 1;
            bp2x <= 1;
            bp2y <= 1;
            bp3x <= 2;
            bp3y <= 1;
            bp4x <= 3;
            bp4y <= 1;
            bp5x <= 4;
            bp5y <= 1;
            bp6x <= 5;
            bp6y <= 1;
            bp7x <= 6;
            bp7y <= 1;
            bp8x <= 7;
            bp8y <= 1;
            wr1x <= 0;
            wr1y <= 7;
            wr2x <= 7;
            wr2y <= 7;
            br1x <= 0;
            br1y <= 0;
            br2x <= 7;
            br2y <= 0;
            wb1x <= 2;
            wb1y <= 7;
            wb2x <= 5;
            wb2y <= 7;
            bb1x <= 2;
            bb1y <= 0;
            bb2x <= 5;
            bb2y <= 0;
            wk1x <= 1;
            wk1y <= 7;
            wk2x <= 6;
            wk2y <= 7;
            bk1x <= 1;
            bk1y <= 0;
            bk2x <= 6;
            bk2y <= 0;
            wqx <= 3;
            wqy <= 7;
            bqx <= 3;
            bqy <= 0;
            wkx <= 4;
            wky <= 7;
            bkx <= 4;
            bky <= 0;
        end
        else
            //White Pieces
            case (state)
            wt: begin
                capturecode <= 0;
                clickedrol <= 0;
                clickedcol <= 0;
                movementvalid <= 7'b0111111;
                if (click == 1) begin
                    if (Board[rol][col][5] == 0 && Board[rol][col] != 0) begin
                        state <= 2*Board[rol][col];
                        clickedcol <= col;
                        clickedrol <= rol;
                    end
                end
            end
            wp1: begin
                if(click == 1 && rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 6 && (col == 4 || col == 5)) begin
                        wp1x <= rol;
                        wp1y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 1;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp1x <= rol;
                        wp1y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 1;
                        state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp1x <= rol;
                        wp1y <= col;
                        capturecode <= Board[rol][col];
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 1;
                        state <= bt;
                        end
                    end
                end
                else if (click == 2)
                    state <= wt;
            end
            wp2: begin
                if(click == 1 && rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 6 && (col == 4 || col == 5)) begin
                        wp2x <= rol;
                        wp2y <= col;
                        Board[rol][col] <= 2;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp2x <= rol;
                        wp2y <= col;
                        Board[rol][col] <= 2;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp2x <= rol;
                        wp2y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 2;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                end
                else if (click == 2)
                    state <= wt;
            end
            wp3: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 6 && (col == 4 || col == 5)) begin
                        wp3x <= rol;
                        wp3y <= col;
                        Board[rol][col] <= 3;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp3x <= rol;
                        wp3y <= col;
                        Board[rol][col] <= 3;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp3x <= rol;
                        wp3y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 3;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                end
                else if (click == 2)
                    state <= wt;
            end
            wp4: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 6 && (col == 4 || col == 5)) begin
                        wp4x <= rol;
                        wp4y <= col;
                        Board[rol][col] <= 4;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp4x <= rol;
                        wp4y <= col;
                        Board[rol][col] <= 4;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp4x <= rol;
                        wp4y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 4;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                end
                else if (click == 2)
                    state <= wt;
            end
            wp5: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 6 && (col == 4 || col == 5)) begin
                        wp5x <= rol;
                        wp5y <= col;
                        Board[rol][col] <= 5;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp5x <= rol;
                        wp5y <= col;
                        Board[rol][col] <= 5;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp5x <= rol;
                        wp5y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 5;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                end
                else if (click == 2)
                    state <= wt;
            end
            wp6: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 6 && (col == 4 || col == 5)) begin
                        wp6x <= rol;
                        wp6y <= col;
                        Board[rol][col] <= 6;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp6x <= rol;
                        wp6y <= col;
                        Board[rol][col] <= 6;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp6x <= rol;
                        wp6y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 6;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                end
                else if (click == 2)
                    state <= wt;
            end
            wp7: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 6 && (col == 4 || col == 5)) begin
                        wp7x <= rol;
                        wp7y <= col;
                        Board[rol][col] <= 7;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp7x <= rol;
                        wp7y <= col;
                        Board[rol][col] <= 7;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp7x <= rol;
                        wp7y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 7;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                end
                else if (click == 2)
                    state <= wt;
            end
            wp8: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 6 && (col == 4 || col == 5)) begin
                        wp8x <= rol;
                        wp8y <= col;
                        Board[rol][col] <= 8;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp8x <= rol;
                        wp8y <= col;
                        Board[rol][col] <= 8;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp8x <= rol;
                        wp8y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 8;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= bt;
                        end
                    end
                end
                else if (click == 2)
                    state <= wt;
            end
            wr1: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedcol > col) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       if (movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               wr1x <= rol;
                               wr1y <= col;
                               Board[rol][col] <= 9;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                               wr1moved <= 1;
                           end
                           else if (Board[rol][col][5]) begin
                               wr1x <= rol;
                               wr1y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 9;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                               wr1moved <= 1;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedrol > rol) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       if (movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               wr1x <= rol;
                               wr1y <= col;
                               Board[rol][col] <= 9;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                               wr1moved <= 1;
                           end
                           else if (Board[rol][col][5]) begin
                               wr1x <= rol;
                               wr1y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 9;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                               wr1moved <= 1;
                           end
                        end
                    end
                    else if (!wkmoved && !wr1moved && (rol == 4 && col == 7) && !(Board[1][7] || Board[2][7] || Board[3][7])) begin
                         wkx <= 2;
                         wky <= 7;
                         wr1x <= 3;
                         wr1y <= 7;
                         Board[0][7] <= 0;
                         Board[1][7] <= 0;
                         Board[2][7] <= 16;
                         Board[3][7] <= 9;
                         Board[4][7] <= 0;
                         state <= bt;
                         wkmoved <= 1;
                         wr1moved <= 1;
                    end
                end
                else if (click == 2)
                    state <= wt;
            end
            wr2: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedcol > col) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       if (movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               wr2x <= rol;
                               wr2y <= col;
                               Board[rol][col] <= 10;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                               wr2moved <= 1;
                           end
                           else if (Board[rol][col][5]) begin
                               wr2x <= rol;
                               wr2y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 10;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                               wr2moved <= 1;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedrol > rol) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       if (movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               wr2x <= rol;
                               wr2y <= col;
                               Board[rol][col] <= 10;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                               wr2moved <= 1;
                           end
                           else if (Board[rol][col][5]) begin
                               wr2x <= rol;
                               wr2y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 10;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                               wr2moved <= 1;
                           end
                        end
                    end
                    else if (!wkmoved && !wr2moved && (rol == 4 && col == 7) && !(Board[5][7] || Board[6][7])) begin
                         wkx <= 6;
                         wky <= 7;
                         wr2x <= 5;
                         wr2y <= 7;
                         Board[7][7] <= 0;
                         Board[6][7] <= 16;
                         Board[5][7] <= 10;
                         Board[4][7] <= 0;
                         state <= bt;
                         wkmoved <= 1;
                         wr1moved <= 1;
                    end  
                end
                else if (click == 2)
                    state <= wt;
            end
            wb1: begin
                 if(click == 1 && rol < 8 && col < 8) begin
                    if ((rol > clickedrol) && (clickedcol > col) && ((rol - clickedrol) == -(col - clickedcol)) && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == rol - clickedrol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (rol - clickedrol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((rol > clickedrol) &&(col > clickedcol) && ((rol - clickedrol) == (col - clickedcol)) && (Board[rol][col][5] == 1 || !Board[rol][col]))begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == rol - clickedrol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (rol - clickedrol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((clickedrol > rol) &&(col > clickedcol) && (-(rol - clickedrol) == (col - clickedcol)) && (Board[rol][col][5] == 1 || !Board[rol][col]))begin
                       for (i = 1; i < col - clickedcol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == col - clickedcol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (col - clickedcol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((clickedrol > rol) &&(clickedcol > col) && ((clickedrol- rol) == (clickedcol - col)) && (Board[rol][col][5] == 1 || !Board[rol][col]))begin
                       for (i = 1; i < clickedrol - rol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == clickedrol - rol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (clickedrol - rol == 1)
                            movementvalid[6] <= 1;
                   end
                   if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wb1x <= rol;
                            wb1y <= col;
                            Board[rol][col] <= 11;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wb1x <= rol;
                            wb1y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 11;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
            else if (click == 2)
                state <= wt;
            end
            wb2: begin
                 if(click == 1 && rol < 8 && col < 8) begin
                    if ((rol > clickedrol) && (clickedcol > col) && ((rol - clickedrol) == -(col - clickedcol)) && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == rol - clickedrol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (rol - clickedrol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((rol > clickedrol) &&(col > clickedcol) && ((rol - clickedrol) == (col - clickedcol)) && (Board[rol][col][5] == 1 || !Board[rol][col]))begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == rol - clickedrol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (rol - clickedrol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((clickedrol > rol) &&(col > clickedcol) && (-(rol - clickedrol) == (col - clickedcol)) && (Board[rol][col][5] == 1 || !Board[rol][col]))begin
                       for (i = 1; i < col - clickedcol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == col - clickedcol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (col - clickedcol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((clickedrol > rol) &&(clickedcol > col) && ((clickedrol- rol) == (clickedcol - col)) && (Board[rol][col][5] == 1 || !Board[rol][col]))begin
                       for (i = 1; i < clickedrol - rol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == clickedrol - rol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (clickedrol - rol == 1)
                            movementvalid[6] <= 1;
                   end
                   if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wb2x <= rol;
                            wb2y <= col;
                            Board[rol][col] <= 12;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wb2x <= rol;
                            wb2y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 12;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
            else if (click == 2)
                state <= wt;
            end
            wk1: begin
                 if(click == 1 && rol < 8 && col < 8 && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                   if (rol - clickedrol == 2 && col - clickedcol == 1)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 1 && col - clickedcol == 2)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 2 && clickedcol - col == 1)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 1 && clickedcol - col == 2)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 2 && col - clickedcol == 1)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 1 && col - clickedcol == 2)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 2 && clickedcol - col == 1)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 1 && clickedcol - col == 2)
                       movementvalid[6] <= 1;
                   if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wk1x <= rol;
                            wk1y <= col;
                            Board[rol][col] <= 13;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wk1x <= rol;
                            wk1y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 13;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
            else if (click == 2)
                state <= wt;
            end
            wk2: begin
                 if(click == 1 && rol < 8 && col < 8 && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                   if (rol - clickedrol == 2 && col - clickedcol == 1)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 1 && col - clickedcol == 2)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 2 && clickedcol - col == 1)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 1 && clickedcol - col == 2)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 2 && col - clickedcol == 1)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 1 && col - clickedcol == 2)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 2 && clickedcol - col == 1)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 1 && clickedcol - col == 2)
                       movementvalid[6] <= 1;
                   if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wk2x <= rol;
                            wk2y <= col;
                            Board[rol][col] <= 14;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wk2x <= rol;
                            wk2y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 14;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
            else if (click == 2)
                state <= wt;
            end
            wq: begin
                if(click == 1 && rol < 8 && col < 8) begin
                   if ((rol > clickedrol) && (clickedcol > col) && ((rol - clickedrol) == -(col - clickedcol)) && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == rol - clickedrol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (rol - clickedrol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((rol > clickedrol) &&(col > clickedcol) && ((rol - clickedrol) == (col - clickedcol)) && (Board[rol][col][5] == 1 || !Board[rol][col]))begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == rol - clickedrol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (rol - clickedrol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((clickedrol > rol) &&(col > clickedcol) && (-(rol - clickedrol) == (col - clickedcol)) && (Board[rol][col][5] == 1 || !Board[rol][col]))begin
                       for (i = 1; i < col - clickedcol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == col - clickedcol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (col - clickedcol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((clickedrol > rol) &&(clickedcol > col) && ((clickedrol- rol) == (clickedcol - col)) && (Board[rol][col][5] == 1 || !Board[rol][col]))begin
                       for (i = 1; i < clickedrol - rol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == clickedrol - rol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (clickedrol - rol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedcol > col) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedrol > rol) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                    end
                    if (movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wqx <= rol;
                            wqy <= col;
                            Board[rol][col] <= 15;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wqx <= rol;
                            wqy <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 15;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                else if (click == 2)
                    state <= wt;
            end
            wk: begin//wk1 and wk2 are the states for knights, wk without index refers to white king movement
                if (click == 1 && rol < 8 && col < 8 && !(clickedrol == rol && clickedcol == col)) begin
                    if (((clickedrol - rol) * (clickedrol - rol) == 1) || ((clickedcol - col) * (clickedcol - col) == 1)) begin
                        if ((Board[rol][col][5] == 1 || !Board[rol][col])) begin
                            if (!Board[rol][col]) begin
                                wkx <= rol;
                                wky <= col;
                                Board[rol][col] <= 16;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= bt;
                                wkmoved <= 1;
                            end
                            else if (Board[rol][col][5]) begin
                                wkx <= rol;
                                wky <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 16;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= bt;
                                wkmoved <= 1;
                            end
                        end
                    end
                    else if (!wkmoved && !wr1moved && (rol == 0 && col == 7) && !(Board[1][7] || Board[2][7] || Board[3][7])) begin
                         wkx <= 2;
                         wky <= 7;
                         wr1x <= 3;
                         wr1y <= 7;
                         Board[0][7] <= 0;
                         Board[1][7] <= 0;
                         Board[2][7] <= 16;
                         Board[3][7] <= 9;
                         Board[4][7] <= 0;
                         state <= bt;
                         wkmoved <= 1;
                         wr1moved <= 1;
                    end
                    else if (!wkmoved && !wr2moved && (rol == 7 && col == 7) && !(Board[5][7] || Board[6][7])) begin
                         wkx <= 6;
                         wky <= 7;
                         wr2x <= 5;
                         wr2y <= 7;
                         Board[7][7] <= 0;
                         Board[6][7] <= 16;
                         Board[5][7] <= 10;
                         Board[4][7] <= 0;
                         state <= bt;
                         wkmoved <= 1;
                         wr2moved <= 1;
                    end         
                end
                else if (click == 2)
                    state <= wt;
            end
            // Black Pieces
            bt: begin
                capturecode <= 0;
                clickedrol <= 0;
                clickedcol <= 0;
                movementvalid <=7'b0111111;
                if (click == 1) begin
                    if (Board[rol][col][5]) begin
                        state <= 2*blackpiece + 1;
                        clickedcol <= col;
                        clickedrol <= rol;
                    end
                end
            end
            bp1: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 1 && (col == 2 || col == 3)) begin
                        bp1x <= rol;
                        bp1y <= col;
                        Board[rol][col] <= 6'b100001;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                        else if (col == clickedcol + 1) begin
                        bp1x <= rol;
                        bp1y <= col;
                        Board[rol][col] <= 6'b100001;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                        if (col == clickedcol + 1) begin
                        bp1x <= rol;
                        bp1y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 6'b100001;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                end
                else if (click == 2)
                    state <= bt;
            end
            bp2: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 1 && (col == 2 || col == 3)) begin
                        bp2x <= rol;
                        bp2y <= col;
                        Board[rol][col] <= 6'b100010;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                        else if (col == clickedcol + 1) begin
                        bp2x <= rol;
                        bp2y <= col;
                        Board[rol][col] <= 6'b100010;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                        if (col == clickedcol + 1) begin
                        bp2x <= rol;
                        bp2y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 6'b100010;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                end
                else if (click == 2)
                    state <= bt;
            end
            bp3: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 1 && (col == 2 || col == 3)) begin
                        bp3x <= rol;
                        bp3y <= col;
                        Board[rol][col] <= 6'b100011;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                        else if (col == clickedcol + 1) begin
                        bp3x <= rol;
                        bp3y <= col;
                        Board[rol][col] <= 6'b100011;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                        if (col == clickedcol + 1) begin
                        bp3x <= rol;
                        bp3y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 6'b100011;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                end
                else if (click == 2)
                    state <= bt;
            end
            bp4: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 1 && (col == 2 || col == 3)) begin
                        bp4x <= rol;
                        bp4y <= col;
                        Board[rol][col] <= 6'b100100;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                        else if (col == clickedcol + 1) begin
                        bp4x <= rol;
                        bp4y <= col;
                        Board[rol][col] <= 6'b100100;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                        if (col == clickedcol + 1) begin
                        bp4x <= rol;
                        bp4y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 6'b100100;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                end
                else if (click == 2)
                    state <= bt;
            end
            bp5: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 1 && (col == 2 || col == 3)) begin
                        bp5x <= rol;
                        bp5y <= col;
                        Board[rol][col] <= 6'b100101;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                        else if (col == clickedcol + 1) begin
                        bp5x <= rol;
                        bp5y <= col;
                        Board[rol][col] <= 6'b100101;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                        if (col == clickedcol + 1) begin
                        bp5x <= rol;
                        bp5y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 6'b100101;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                end
                else if (click == 2)
                    state <= bt;
            end
            bp6: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 1 && (col == 2 || col == 3)) begin
                        bp6x <= rol;
                        bp6y <= col;
                        Board[rol][col] <= 6'b100110;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                        else if (col == clickedcol + 1) begin
                        bp6x <= rol;
                        bp6y <= col;
                        Board[rol][col] <= 6'b100110;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                        if (col == clickedcol + 1) begin
                        bp6x <= rol;
                        bp6y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 6'b100110;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                end
                else if (click == 2)
                    state <= bt;
            end
            bp7: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 1 && (col == 2 || col == 3)) begin
                        bp7x <= rol;
                        bp7y <= col;
                        Board[rol][col] <= 6'b100111;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                        else if (col == clickedcol + 1) begin
                        bp7x <= rol;
                        bp7y <= col;
                        Board[rol][col] <= 6'b100111;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                        if (col == clickedcol + 1) begin
                        bp7x <= rol;
                        bp7y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 6'b100111;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                end
                else if (click == 2)
                    state <= bt;
            end
            bp8: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                       if (clickedcol == 1 && (col == 2 || col == 3)) begin
                        bp8x <= rol;
                        bp8y <= col;
                        Board[rol][col] <= 6'b101000;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                        else if (col == clickedcol + 1) begin
                        bp8x <= rol;
                        bp8y <= col;
                        Board[rol][col] <= 6'b101000;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                        if (col == clickedcol + 1) begin
                        bp8x <= rol;
                        bp8y <= col;
                        capturecode <= Board[rol][col];
                        Board[rol][col] <= 6'b101000;
                        Board[clickedrol][clickedcol] <= 0;
                        state <= wt;
                        end
                    end
                end
                else if (click == 2)
                    state <= bt;
            end
            br1: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                        if (clickedcol < col) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedcol > col) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       if (movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               br1x <= rol;
                               br1y <= col;
                               Board[rol][col] <= 6'b101001;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= wt;
                               br1moved <= 1;
                           end
                           else if (!Board[rol][col][5]) begin
                               br1x <= rol;
                               br1y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 6'b101001;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= wt;
                               br1moved <= 1;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && Board[rol][col][5] == 0) begin
                        if (clickedrol < rol) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedrol > rol) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       if (movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               br1x <= rol;
                               br1y <= col;
                               Board[rol][col] <= 6'b101001;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= wt;
                               br1moved <= 1;
                           end
                           else if (!Board[rol][col][5]) begin
                               br1x <= rol;
                               br1y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 6'b101001;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= wt;
                               br1moved <= 1;
                           end
                        end
                    end
                    else if (!bkmoved && !br1moved && (rol == 4 && col == 0) && !(Board[1][0] || Board[2][0] || Board[3][0])) begin
                         bkx <= 2;
                         bky <= 0;
                         br1x <= 3;
                         br1y <= 0;
                         Board[0][0] <= 0;
                         Board[1][0] <= 0;
                         Board[2][0] <= 6'b110000;
                         Board[3][0] <= 6'b101001;
                         Board[4][0] <= 0;
                         state <= wt;
                         bkmoved <= 1;
                         br1moved <= 1;
                    end
                end
                else if (click == 2)
                    state <= bt;
            end
            br2: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                        if (clickedcol < col) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedcol > col) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       if (movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               br2x <= rol;
                               br2y <= col;
                               Board[rol][col] <= 6'b101010;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= wt;
                               br2moved <= 1;
                           end
                           else if (!Board[rol][col][5]) begin
                               br2x <= rol;
                               br2y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 6'b101010;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= wt;
                               br2moved <= 1;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && Board[rol][col][5] == 0) begin
                        if (clickedrol < rol) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedrol > rol) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       if (movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               br2x <= rol;
                               br2y <= col;
                               Board[rol][col] <= 6'b101010;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= wt;
                               br2moved <= 1;
                           end
                           else if (!Board[rol][col][5]) begin
                               br2x <= rol;
                               br2y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 6'b101010;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= wt;
                               br2moved <= 1;
                           end
                        end
                    end
                    else if (!bkmoved && !br2moved && (rol == 4 && col == 0) && !(Board[5][0] || Board[6][0])) begin
                         bkx <= 6;
                         bky <= 0;
                         br2x <= 5;
                         br2y <= 0;
                         Board[7][0] <= 0;
                         Board[6][0] <= 6'b110000;
                         Board[5][0] <= 6'b101010;
                         Board[4][0] <= 0;
                         state <= wt;
                         bkmoved <= 1;
                         br2moved <= 1;
                    end        
                end
                else if (click == 2)
                    state <= bt;
            end
            bb1: begin
                 if(click == 1 && rol < 8 && col < 8) begin
                    if ((rol > clickedrol) && (clickedcol > col) && ((rol - clickedrol) == -(col - clickedcol)) && (!Board[rol][col][5])) begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == rol - clickedrol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (rol - clickedrol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((rol > clickedrol) &&(col > clickedcol) && ((rol - clickedrol) == (col - clickedcol)) && (!Board[rol][col][5]))begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == rol - clickedrol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (rol - clickedrol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((clickedrol > rol) &&(col > clickedcol) && (-(rol - clickedrol) == (col - clickedcol)) && (!Board[rol][col][5]))begin
                       for (i = 1; i < col - clickedcol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == col - clickedcol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (col - clickedcol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((clickedrol > rol) &&(clickedcol > col) && ((clickedrol- rol) == (clickedcol - col)) && (!Board[rol][col][5]))begin
                       for (i = 1; i < clickedrol - rol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == clickedrol - rol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (clickedrol - rol == 1)
                            movementvalid[6] <= 1;
                   end
                   if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (Board[rol][col] == 0) begin
                            bb1x <= rol;
                            bb1y <= col;
                            Board[rol][col] <= 6'b101011;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                        end
                        else if (!Board[rol][col][5]) begin
                            bb1x <= rol;
                            bb1y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b101011;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                end
            else if (click == 2)
                state <= bt;
            end
            bb2: begin
                 if(click == 1 && rol < 8 && col < 8) begin
                    if ((rol > clickedrol) && (clickedcol > col) && ((rol - clickedrol) == -(col - clickedcol)) && (!Board[rol][col][5])) begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == rol - clickedrol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (rol - clickedrol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((rol > clickedrol) &&(col > clickedcol) && ((rol - clickedrol) == (col - clickedcol)) && (!Board[rol][col][5]))begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == rol - clickedrol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (rol - clickedrol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((clickedrol > rol) &&(col > clickedcol) && (-(rol - clickedrol) == (col - clickedcol)) && (!Board[rol][col][5]))begin
                       for (i = 1; i < col - clickedcol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == col - clickedcol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (col - clickedcol == 1)
                            movementvalid[6] <= 1;
                   end
                   else if ((clickedrol > rol) &&(clickedcol > col) && ((clickedrol- rol) == (clickedcol - col)) && (!Board[rol][col][5]))begin
                       for (i = 1; i < clickedrol - rol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                           if (i == clickedrol - rol - 1)
                                movementvalid[6] <= 1;
                       end
                       if (clickedrol - rol == 1)
                            movementvalid[6] <= 1;
                   end
                   if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (Board[rol][col] == 0) begin
                            bb2x <= rol;
                            bb2y <= col;
                            Board[rol][col] <= 6'b101100;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                        end
                        else if (!Board[rol][col][5]) begin
                            bb2x <= rol;
                            bb2y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b101100;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                end
            else if (click == 2)
                state <= bt;
            end
            bk1: begin
                 if(click == 1 && rol < 8 && col < 8 && !Board[rol][col][5]) begin
                   if (rol - clickedrol == 2 && col - clickedcol == 1)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 1 && col - clickedcol == 2)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 2 && clickedcol - col == 1)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 1 && clickedcol - col == 2)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 2 && col - clickedcol == 1)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 1 && col - clickedcol == 2)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 2 && clickedcol - col == 1)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 1 && clickedcol - col == 2)
                       movementvalid[6] <= 1;
                   if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            bk1x <= rol;
                            bk1y <= col;
                            Board[rol][col] <= 6'b101101;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                        end
                        else if (!Board[rol][col][5]) begin
                            bk1x <= rol;
                            bk1y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b101101;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                end
            else if (click == 2)
                state <= bt;
            end
            bk2: begin
                 if(click == 1 && rol < 8 && col < 8 && !Board[rol][col][5]) begin
                   if (rol - clickedrol == 2 && col - clickedcol == 1)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 1 && col - clickedcol == 2)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 2 && clickedcol - col == 1)
                       movementvalid[6] <= 1;
                   else if (rol - clickedrol == 1 && clickedcol - col == 2)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 2 && col - clickedcol == 1)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 1 && col - clickedcol == 2)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 2 && clickedcol - col == 1)
                       movementvalid[6] <= 1;
                   else if (clickedrol - rol == 1 && clickedcol - col == 2)
                       movementvalid[6] <= 1;
                   if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            bk2x <= rol;
                            bk2y <= col;
                            Board[rol][col] <= 6'b101110;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                        end
                        else if (!Board[rol][col][5]) begin
                            bk2x <= rol;
                            bk2y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b101110;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                end
            else if (click == 2)
                state <= bt;
            end
            bq: begin
                if(click == 1 && rol < 8 && col < 8) begin
                   if ((rol > clickedrol) && (clickedcol > col) && ((rol - clickedrol) == -(col - clickedcol)) && !Board[rol][col][5]) begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                       end
                   end
                   else if ((rol > clickedrol) &&(col > clickedcol) && ((rol - clickedrol) == (col - clickedcol)) && !Board[rol][col][5])begin
                       for (i = 1; i < rol - clickedrol; i = i + 1) begin
                           if (Board[i + clickedrol][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                       end
                   end
                   else if ((clickedrol > rol) &&(col > clickedcol) && (-(rol - clickedrol) == (col - clickedcol)) && !Board[rol][col][5])begin
                       for (i = 1; i < col - clickedcol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol + i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                       end
                   end
                   else if ((clickedrol > rol) &&(clickedcol > col) && ((clickedrol- rol) == (clickedcol - col)) && !Board[rol][col][5])begin
                       for (i = 1; i < clickedrol - rol; i = i + 1) begin
                           if (Board[clickedrol - i][clickedcol - i] != 0) begin
                                movementvalid[i-1] <= 0;
                           end
                       end
                   end
                   else if (clickedrol == rol && clickedcol != col && !Board[rol][col][5]) begin
                        if (clickedcol < col) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedcol > col) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && !Board[rol][col][5]) begin
                        if (clickedrol < rol) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                       else if (clickedrol > rol) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                            end
                       end
                    end
                    if (movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            bqx <= rol;
                            bqy <= col;
                            Board[rol][col] <= 6'b101111;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                        end
                        else if (!Board[rol][col][5]) begin
                            bqx <= rol;
                            bqy <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b101111;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                end
                else if (click == 2)
                    state <= bt;
            end
            bk: begin//wk1 and wk2 are the states for knights, wk without index refers to white king movement
                if (click == 1 && rol < 8 && col < 8 && !(clickedrol == rol && clickedcol == col)) begin
                    if (((clickedrol - rol) * (clickedrol - rol) == 1) || ((clickedcol - col) * (clickedcol - col) == 1)) begin
                        if ((Board[rol][col][5] == 1 || !Board[rol][col])) begin
                            if (!Board[rol][col]) begin
                                bkx <= rol;
                                bky <= col;
                                Board[rol][col] <= 6'b110000;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= bt;
                                bkmoved <= 1;
                            end
                            else if (!Board[rol][col][5]) begin
                                bkx <= rol;
                                bky <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b110000;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= bt;
                                bkmoved <= 1;
                            end
                        end
                    end
                    else if (!bkmoved && !br1moved && (rol == 0 && col == 0) && !(Board[1][0] || Board[2][0] || Board[3][0])) begin
                         bkx <= 2;
                         bky <= 0;
                         br1x <= 3;
                         br1y <= 0;
                         Board[0][0] <= 0;
                         Board[1][0] <= 0;
                         Board[2][0] <= 6'b110000;
                         Board[3][0] <= 6'b101001;
                         Board[4][0] <= 0;
                         state <= wt;
                         bkmoved <= 1;
                         br1moved <= 1;
                    end
                    else if (!bkmoved && !br2moved && (rol == 7 && col == 0) && !(Board[5][0] || Board[6][0])) begin
                         bkx <= 6;
                         bky <= 0;
                         br2x <= 5;
                         br2y <= 0;
                         Board[7][0] <= 0;
                         Board[6][0] <= 6'b110000;
                         Board[5][0] <= 6'b101010;
                         Board[4][0] <= 0;
                         state <= wt;
                         bkmoved <= 1;
                         br2moved <= 1;
                    end         
                end
                else if (click == 2)
                    state <= bt;
            end
            endcase
                    
    end
endmodule
