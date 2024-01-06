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
    input Clk, reset,undo,undo1,
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
    output reg [3:0] wp1p, wp2p, wp3p, wp4p, wp5p, wp6p, wp7p, wp8p,
    output reg [3:0] bp1p, bp2p, bp3p, bp4p, bp5p, bp6p, bp7p, bp8p,
    output reg [6:0] state,
    output reg [5:0] capturecode,
    output reg [5:0] storedcapture1,
    output reg [5:0] storedcapture2,
    output reg [1:0] capindex
//    output reg [3:0] wp1x, wp2x, wp3x, wp4x, wp5x, wp6x, wp7x, wp8x,
//    output reg [3:0] wp1y, wp2y, wp3y, wp4y, wp5y, wp6y, wp7y, wp8y
    );
    reg [5:0] Board [0:8][0:8];
    integer i;
    reg wr1moved, wr2moved, br1moved, br2moved, wkmoved, bkmoved;
    parameter wt = 7'd126;
    parameter bt = 7'd127;
    parameter wp1 = 7'd2;
    parameter bp1 = 7'd3;
    parameter wp2 = 7'd4;
    parameter bp2 = 7'd5;
    parameter wp3 = 7'd6;
    parameter bp3 = 7'd7;
    parameter wp4 = 7'd8;
    parameter bp4 = 7'd9;
    parameter wp5 = 7'd10;
    parameter bp5 = 7'd11;
    parameter wp6 = 7'd12;
    parameter bp6 = 7'd13;
    parameter wp7 = 7'd14;
    parameter bp7 = 7'd15;
    parameter wp8 = 7'd16;
    parameter bp8 = 7'd17;
    parameter wr1 = 7'd18;
    parameter br1 = 7'd19;
    parameter wr2 = 7'd20;
    parameter br2 = 7'd21;
    parameter wb1 = 7'd22;
    parameter bb1 = 7'd23;
    parameter wb2 = 7'd24;
    parameter bb2 = 7'd25;
    parameter wk1 = 7'd26;
    parameter bk1 = 7'd27;
    parameter wk2 = 7'd28;
    parameter bk2 = 7'd29;
    parameter wq = 7'd30;
    parameter bq = 7'd31;
    parameter wk = 7'd32;
    parameter bk = 7'd33;
    parameter wt2 = 7'd0;
    parameter bt2 = 7'd1;
    parameter wt3 = 7'd124;
    parameter bt3 = 7'd125;
    parameter wt4 = 7'd122;
    parameter bt4 = 7'd123;
    parameter wt5 = 7'd120;
    parameter bt5 = 7'd121;
    parameter promotion1 = 7'd34;
    parameter promotion1wait = 7'd36;
    parameter promotion1final = 7'd38;
    parameter promotion2 = 7'd40;
    parameter promotion2wait = 7'd42;
    parameter promotion2final = 7'd44;
    parameter promotion3 = 7'd46;
    parameter promotion3wait = 7'd48;
    parameter promotion3final = 7'd50;
    parameter promotion4 = 7'd52;
    parameter promotion4wait = 7'd54;
    parameter promotion4final = 7'd56;
    parameter promotion5 = 7'd58;
    parameter promotion5wait = 7'd60;
    parameter promotion5final = 7'd62;
    parameter promotion6 = 7'd64;
    parameter promotion6wait = 7'd66;
    parameter promotion6final = 7'd68;
    parameter promotion7 = 7'd70;
    parameter promotion7wait = 7'd72;
    parameter promotion7final = 7'd74;
    parameter promotion8 = 7'd76;
    parameter promotion8wait = 7'd78;
    parameter promotion8final = 7'd80;
    parameter promotion1b = 7'd35;
    parameter promotion1bwait = 7'd37;
    parameter promotion1bfinal = 7'd39;
    parameter promotion2b = 7'd41;
    parameter promotion2bwait = 7'd43;
    parameter promotion2bfinal = 7'd45;
    parameter promotion3b = 7'd47;
    parameter promotion3bwait = 7'd49;
    parameter promotion3bfinal = 7'd51;
    parameter promotion4b = 7'd53;
    parameter promotion4bwait = 7'd55;
    parameter promotion4bfinal = 7'd57;
    parameter promotion5b = 7'd59;
    parameter promotion5bwait = 7'd61;
    parameter promotion5bfinal = 7'd63;
    parameter promotion6b = 7'd65;
    parameter promotion6bwait = 7'd67;
    parameter promotion6bfinal = 7'd69;
    parameter promotion7b = 7'd71;
    parameter promotion7bwait = 7'd73;
    parameter promotion7bfinal = 7'd75;
    parameter promotion8b = 7'd77;
    parameter promotion8bwait = 7'd79;
    parameter promotion8bfinal = 7'd81;
    reg [3:0] rol, col;
    reg [3:0] undorol1, undocol1, undorol2, undocol2;
    reg [3:0] undorol3, undocol3, undorol4, undocol4;
    reg [3:0] clickedrol, clickedcol;
    wire[4:0] blackpiece;
    reg [6:0] movementvalid;
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
            state <= wt2;
            capindex <= 0;
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
            wp1p <= 0;
            wp2p <= 0;
            wp3p <= 0;
            wp4p <= 0;
            wp5p <= 0;
            wp6p <= 0;
            wp7p <= 0;
            wp8p <= 0;
            bp1p <= 0;
            bp2p <= 0;
            bp3p <= 0;
            bp4p <= 0;
            bp5p <= 0;
            bp6p <= 0;
            bp7p <= 0;
            bp8p <= 0;
        end
        else
            //White Pieces
            case (state)
            wt: begin
                state <= wt2;
                storedcapture1 <= capturecode;
                undorol1 <= rol;
                undocol1 <= col;
                undorol2 <= clickedrol;
                undocol2 <= clickedcol;
            end
            wt2: begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (Board[i][4] >= 17 && Board[i][4] <= 32) begin
                        Board[i][4] <= Board[i][4] - 16;
                    end
                    if (Board[i][6] >= 17 && Board[i][6] <= 32) begin
                        Board[i][6] <= Board[i][6] - 16;
                    end
                end
                capturecode <= 0;
                clickedrol <= 0;
                clickedcol <= 0;
                capindex <= 0;
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
                case(wp1p)
                0: begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                        if (clickedcol == 6 && col == 4 && !Board[rol][5]) begin
                        wp1x <= rol;
                        wp1y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 17;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp1x <= rol;
                        wp1y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 1;
                        if (col == 0) begin
                            state <= promotion1;
                            wp1p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
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
                        if (col == 0) begin
                            state <= promotion1;
                            wp1p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if (Board[rol][clickedcol] <= 63 && Board[rol][clickedcol] >= 49 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol - 1) begin
                        wp1x <= rol;
                        wp1y <= col;
                        capturecode <= Board[rol][clickedcol];
                        Board[rol][col] <= 1;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][clickedcol] <= 0;
                        state <= bt;
                    end
                end
                1:  begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wp1x <= rol;
                            wp1y <= col;
                            Board[rol][col] <= 1;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp1x <= rol;
                            wp1y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 1;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                2: begin
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
                            wp1x <= rol;
                            wp1y <= col;
                            Board[rol][col] <= 1;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp1x <= rol;
                            wp1y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 1;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                3: begin
                   if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               wp1x <= rol;
                               wp1y <= col;
                               Board[rol][col] <= 1;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp1x <= rol;
                               wp1y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 1;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               wp1x <= rol;
                               wp1y <= col;
                               Board[rol][col] <= 1;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp1x <= rol;
                               wp1y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 1;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                end
                4: begin
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
                            wp1x <= rol;
                            wp1y <= col;
                            Board[rol][col] <= 1;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp1x <= rol;
                            wp1y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 1;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                default: begin
                end
                endcase
                end
                else if (click == 2)
                    state <= wt;
            end
            promotion1: begin
                if (click == 1) begin
                    state <= promotion1wait;
                end
           end
            promotion1wait: begin
               if (click == 0) begin
                   state <= promotion1final;
               end
            end
            promotion1final: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            wp1p <= 1;
                            state <= bt;
                        end
                        else if (col == clickedcol + 1) begin
                            wp1p <= 2;
                            state <= bt;
                        end
                        else if (col == clickedcol + 2) begin
                            wp1p <= 3;
                            state <= bt;
                        end
                        else if (col == clickedcol + 3) begin
                            wp1p <= 4;
                            state <= bt;
                        end
                    end
                end
            end
            wp2: begin
                if(click == 1 && rol < 8 && col < 8) begin
                case(wp2p)
                0: begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                        if (clickedcol == 6 && col == 4 && !Board[rol][5]) begin
                        wp2x <= rol;
                        wp2y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 18;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp2x <= rol;
                        wp2y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 2;
                        if (col == 0) begin
                            state <= promotion2;
                            wp2p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp2x <= rol;
                        wp2y <= col;
                        capturecode <= Board[rol][col];
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 2;
                        if (col == 0) begin
                            state <= promotion2;
                            wp2p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if (Board[rol][clickedcol] <= 63 && Board[rol][clickedcol] >= 49 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol - 1) begin
                        wp2x <= rol;
                        wp2y <= col;
                        capturecode <= Board[rol][clickedcol];
                        Board[rol][col] <= 2;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][clickedcol] <= 0;
                        state <= bt;
                    end
                end
                1:  begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wp2x <= rol;
                            wp2y <= col;
                            Board[rol][col] <= 2;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp2x <= rol;
                            wp2y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 2;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                2: begin
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
                            wp2x <= rol;
                            wp2y <= col;
                            Board[rol][col] <= 2;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp2x <= rol;
                            wp2y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 2;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                3: begin
                   if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               wp2x <= rol;
                               wp2y <= col;
                               Board[rol][col] <= 2;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp2x <= rol;
                               wp2y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 2;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               wp2x <= rol;
                               wp2y <= col;
                               Board[rol][col] <= 2;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp2x <= rol;
                               wp2y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 2;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                end
                4: begin
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
                            wp2x <= rol;
                            wp2y <= col;
                            Board[rol][col] <= 2;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp2x <= rol;
                            wp2y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 2;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                default: begin
                end
                endcase
                end
                else if (click == 2)
                    state <= wt;
            end
            promotion2: begin
                if (click == 1) begin
                    state <= promotion2wait;
                end
           end
            promotion2wait: begin
               if (click == 0) begin
                   state <= promotion2final;
               end
            end
            promotion2final: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            wp2p <= 1;
                            state <= bt;
                        end
                        else if (col == clickedcol + 1) begin
                            wp2p <= 2;
                            state <= bt;
                        end
                        else if (col == clickedcol + 2) begin
                            wp2p <= 3;
                            state <= bt;
                        end
                        else if (col == clickedcol + 3) begin
                            wp2p <= 4;
                            state <= bt;
                        end
                    end
                end
            end
            wp3: begin
                if(click == 1 && rol < 8 && col < 8) begin
                case(wp3p)
                0: begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                        if (clickedcol == 6 && col == 4 && !Board[rol][5]) begin
                        wp3x <= rol;
                        wp3y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 19;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp3x <= rol;
                        wp3y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 3;
                        if (col == 0) begin
                            state <= promotion3;
                            wp3p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp3x <= rol;
                        wp3y <= col;
                        capturecode <= Board[rol][col];
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 3;
                        if (col == 0) begin
                            state <= promotion3;
                            wp3p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if (Board[rol][clickedcol] <= 63 && Board[rol][clickedcol] >= 49 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol - 1) begin
                        wp3x <= rol;
                        wp3y <= col;
                        capturecode <= Board[rol][clickedcol];
                        Board[rol][col] <= 3;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][clickedcol] <= 0;
                        state <= bt;
                    end
                end
                1:  begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wp3x <= rol;
                            wp3y <= col;
                            Board[rol][col] <= 3;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp3x <= rol;
                            wp3y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 3;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                2: begin
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
                            wp3x <= rol;
                            wp3y <= col;
                            Board[rol][col] <= 3;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp3x <= rol;
                            wp3y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 3;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                3: begin
                   if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               wp3x <= rol;
                               wp3y <= col;
                               Board[rol][col] <= 3;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp3x <= rol;
                               wp3y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 3;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               wp3x <= rol;
                               wp3y <= col;
                               Board[rol][col] <= 3;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp3x <= rol;
                               wp3y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 3;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                end
                4: begin
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
                            wp3x <= rol;
                            wp3y <= col;
                            Board[rol][col] <= 3;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp3x <= rol;
                            wp3y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 3;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                default: begin
                end
                endcase
                end
                else if (click == 2)
                    state <= wt;
            end
            promotion3: begin
                if (click == 1) begin
                    state <= promotion3wait;
                end
           end
            promotion3wait: begin
               if (click == 0) begin
                   state <= promotion3final;
               end
            end
            promotion3final: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            wp3p <= 1;
                            state <= bt;
                        end
                        else if (col == clickedcol + 1) begin
                            wp3p <= 2;
                            state <= bt;
                        end
                        else if (col == clickedcol + 2) begin
                            wp3p <= 3;
                            state <= bt;
                        end
                        else if (col == clickedcol + 3) begin
                            wp3p <= 4;
                            state <= bt;
                        end
                    end
                end
            end
                        wp4: begin
                if(click == 1 && rol < 8 && col < 8) begin
                case(wp4p)
                0: begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                        if (clickedcol == 6 && col == 4 && !Board[rol][5]) begin
                        wp4x <= rol;
                        wp4y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 20;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp4x <= rol;
                        wp4y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 4;
                        if (col == 0) begin
                            state <= promotion4;
                            wp4p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp4x <= rol;
                        wp4y <= col;
                        capturecode <= Board[rol][col];
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 4;
                        if (col == 0) begin
                            state <= promotion4;
                            wp4p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if (Board[rol][clickedcol] <= 63 && Board[rol][clickedcol] >= 49 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol - 1) begin
                        wp4x <= rol;
                        wp4y <= col;
                        capturecode <= Board[rol][clickedcol];
                        Board[rol][col] <= 4;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][clickedcol] <= 0;
                        state <= bt;
                    end
                end
                1:  begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wp4x <= rol;
                            wp4y <= col;
                            Board[rol][col] <= 4;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp4x <= rol;
                            wp4y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 4;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                2: begin
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
                            wp4x <= rol;
                            wp4y <= col;
                            Board[rol][col] <= 4;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp4x <= rol;
                            wp4y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 4;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                3: begin
                   if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               wp4x <= rol;
                               wp4y <= col;
                               Board[rol][col] <= 4;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp4x <= rol;
                               wp4y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 4;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               wp4x <= rol;
                               wp4y <= col;
                               Board[rol][col] <= 4;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp4x <= rol;
                               wp4y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 4;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                end
                4: begin
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
                            wp4x <= rol;
                            wp4y <= col;
                            Board[rol][col] <= 4;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp4x <= rol;
                            wp4y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 4;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                default: begin
                end
                endcase
                end
                else if (click == 2)
                    state <= wt;
            end
            promotion4: begin
                if (click == 1) begin
                    state <= promotion4wait;
                end
           end
            promotion4wait: begin
               if (click == 0) begin
                   state <= promotion4final;
               end
            end
            promotion4final: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            wp4p <= 1;
                            state <= bt;
                        end
                        else if (col == clickedcol + 1) begin
                            wp4p <= 2;
                            state <= bt;
                        end
                        else if (col == clickedcol + 2) begin
                            wp4p <= 3;
                            state <= bt;
                        end
                        else if (col == clickedcol + 3) begin
                            wp4p <= 4;
                            state <= bt;
                        end
                    end
                end
            end
            wp5: begin
                if(click == 1 && rol < 8 && col < 8) begin
                case(wp5p)
                0: begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                        if (clickedcol == 6 && col == 4 && !Board[rol][5]) begin
                        wp5x <= rol;
                        wp5y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 21;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp5x <= rol;
                        wp5y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 5;
                        if (col == 0) begin
                            state <= promotion5;
                            wp5p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp5x <= rol;
                        wp5y <= col;
                        capturecode <= Board[rol][col];
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 5;
                        if (col == 0) begin
                            state <= promotion5;
                            wp5p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if (Board[rol][clickedcol] <= 63 && Board[rol][clickedcol] >= 49 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol - 1) begin
                        wp5x <= rol;
                        wp5y <= col;
                        capturecode <= Board[rol][clickedcol];
                        Board[rol][col] <= 5;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][clickedcol] <= 0;
                        state <= bt;
                    end
                end
                1:  begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wp5x <= rol;
                            wp5y <= col;
                            Board[rol][col] <= 5;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp5x <= rol;
                            wp5y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 5;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                2: begin
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
                            wp5x <= rol;
                            wp5y <= col;
                            Board[rol][col] <= 5;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp5x <= rol;
                            wp5y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 5;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                3: begin
                   if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               wp5x <= rol;
                               wp5y <= col;
                               Board[rol][col] <= 5;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp5x <= rol;
                               wp5y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 5;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               wp5x <= rol;
                               wp5y <= col;
                               Board[rol][col] <= 5;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp5x <= rol;
                               wp5y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 5;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                end
                4: begin
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
                            wp5x <= rol;
                            wp5y <= col;
                            Board[rol][col] <= 5;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp5x <= rol;
                            wp5y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 5;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                default: begin
                end
                endcase
                end
                else if (click == 2)
                    state <= wt;
            end
            promotion5: begin
                if (click == 1) begin
                    state <= promotion5wait;
                end
           end
            promotion5wait: begin
               if (click == 0) begin
                   state <= promotion5final;
               end
            end
            promotion5final: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            wp5p <= 1;
                            state <= bt;
                        end
                        else if (col == clickedcol + 1) begin
                            wp5p <= 2;
                            state <= bt;
                        end
                        else if (col == clickedcol + 2) begin
                            wp5p <= 3;
                            state <= bt;
                        end
                        else if (col == clickedcol + 3) begin
                            wp5p <= 4;
                            state <= bt;
                        end
                    end
                end
            end
            wp6: begin
                if(click == 1 && rol < 8 && col < 8) begin
                case(wp6p)
                0: begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                        if (clickedcol == 6 && col == 4 && !Board[rol][5]) begin
                        wp6x <= rol;
                        wp6y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 22;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp6x <= rol;
                        wp6y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 6;
                        if (col == 0) begin
                            state <= promotion6;
                            wp6p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp6x <= rol;
                        wp6y <= col;
                        capturecode <= Board[rol][col];
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 6;
                        if (col == 0) begin
                            state <= promotion6;
                            wp6p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if (Board[rol][clickedcol] <= 63 && Board[rol][clickedcol] >= 49 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol - 1) begin
                        wp6x <= rol;
                        wp6y <= col;
                        capturecode <= Board[rol][clickedcol];
                        Board[rol][col] <= 6;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][clickedcol] <= 0;
                        state <= bt;
                    end
                end
                1:  begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wp6x <= rol;
                            wp6y <= col;
                            Board[rol][col] <= 6;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp6x <= rol;
                            wp6y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                2: begin
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
                            wp6x <= rol;
                            wp6y <= col;
                            Board[rol][col] <= 6;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp6x <= rol;
                            wp6y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                3: begin
                   if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               wp6x <= rol;
                               wp6y <= col;
                               Board[rol][col] <= 6;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp6x <= rol;
                               wp6y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 6;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               wp6x <= rol;
                               wp6y <= col;
                               Board[rol][col] <= 6;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp6x <= rol;
                               wp6y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 6;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                end
                4: begin
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
                            wp6x <= rol;
                            wp6y <= col;
                            Board[rol][col] <= 6;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp6x <= rol;
                            wp6y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                default: begin
                end
                endcase
                end
                else if (click == 2)
                    state <= wt;
            end
            promotion6: begin
                if (click == 1) begin
                    state <= promotion6wait;
                end
           end
            promotion6wait: begin
               if (click == 0) begin
                   state <= promotion6final;
               end
            end
            promotion6final: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            wp6p <= 1;
                            state <= bt;
                        end
                        else if (col == clickedcol + 1) begin
                            wp6p <= 2;
                            state <= bt;
                        end
                        else if (col == clickedcol + 2) begin
                            wp6p <= 3;
                            state <= bt;
                        end
                        else if (col == clickedcol + 3) begin
                            wp6p <= 4;
                            state <= bt;
                        end
                    end
                end
            end
            wp7: begin
                if(click == 1 && rol < 8 && col < 8) begin
                case(wp7p)
                0: begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                        if (clickedcol == 6 && col == 4 && !Board[rol][5]) begin
                        wp7x <= rol;
                        wp7y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 23;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp7x <= rol;
                        wp7y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 7;
                        if (col == 0) begin
                            state <= promotion7;
                            wp7p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp7x <= rol;
                        wp7y <= col;
                        capturecode <= Board[rol][col];
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 7;
                        if (col == 0) begin
                            state <= promotion7;
                            wp7p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if (Board[rol][clickedcol] <= 63 && Board[rol][clickedcol] >= 49 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol - 1) begin
                        wp7x <= rol;
                        wp7y <= col;
                        capturecode <= Board[rol][clickedcol];
                        Board[rol][col] <= 7;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][clickedcol] <= 0;
                        state <= bt;
                    end
                end
                1:  begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wp7x <= rol;
                            wp7y <= col;
                            Board[rol][col] <= 7;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp7x <= rol;
                            wp7y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 7;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                2: begin
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
                            wp7x <= rol;
                            wp7y <= col;
                            Board[rol][col] <= 7;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp7x <= rol;
                            wp7y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 7;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                3: begin
                   if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               wp7x <= rol;
                               wp7y <= col;
                               Board[rol][col] <= 7;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp7x <= rol;
                               wp7y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 7;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               wp7x <= rol;
                               wp7y <= col;
                               Board[rol][col] <= 7;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp7x <= rol;
                               wp7y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 7;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                end
                4: begin
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
                            wp7x <= rol;
                            wp7y <= col;
                            Board[rol][col] <= 7;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp7x <= rol;
                            wp7y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 7;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                default: begin
                end
                endcase
                end
                else if (click == 2)
                    state <= wt;
            end
            promotion7: begin
                if (click == 1) begin
                    state <= promotion7wait;
                end
           end
            promotion7wait: begin
               if (click == 0) begin
                   state <= promotion7final;
               end
            end
            promotion7final: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            wp7p <= 1;
                            state <= bt;
                        end
                        else if (col == clickedcol + 1) begin
                            wp7p <= 2;
                            state <= bt;
                        end
                        else if (col == clickedcol + 2) begin
                            wp7p <= 3;
                            state <= bt;
                        end
                        else if (col == clickedcol + 3) begin
                            wp7p <= 4;
                            state <= bt;
                        end
                    end
                end
            end
            wp8: begin
                if(click == 1 && rol < 8 && col < 8) begin
                case(wp8p)
                0: begin
                    if (clickedrol == rol && !Board[rol][col]) begin
                        if (clickedcol == 6 && col == 4 && !Board[rol][5]) begin
                        wp8x <= rol;
                        wp8y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 24;
                        state <= bt;
                        end
                        else if (col == clickedcol - 1) begin
                        wp8x <= rol;
                        wp8y <= col;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 8;
                        if (col == 0) begin
                            state <= promotion8;
                            wp8p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && Board[rol][col][5]) begin
                        if (col == clickedcol - 1) begin
                        wp8x <= rol;
                        wp8y <= col;
                        capturecode <= Board[rol][col];
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][col] <= 8;
                        if (col == 0) begin
                            state <= promotion8;
                            wp8p <= 5;
                            clickedrol <= rol;
                            clickedcol <= col;
                        end
                        else
                            state <= bt;
                        end
                    end
                    else if (Board[rol][clickedcol] <= 63 && Board[rol][clickedcol] >= 49 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol - 1) begin
                        wp8x <= rol;
                        wp8y <= col;
                        capturecode <= Board[rol][clickedcol];
                        Board[rol][col] <= 8;
                        Board[clickedrol][clickedcol] <= 0;
                        Board[rol][clickedcol] <= 0;
                        state <= bt;
                    end
                end
                1:  begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                        if (!Board[rol][col]) begin
                            wp8x <= rol;
                            wp8y <= col;
                            Board[rol][col] <= 8;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp8x <= rol;
                            wp8y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 8;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                2: begin
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
                            wp8x <= rol;
                            wp8y <= col;
                            Board[rol][col] <= 8;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp8x <= rol;
                            wp8y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 8;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                3: begin
                   if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                           if (!Board[rol][col]) begin
                               wp8x <= rol;
                               wp8y <= col;
                               Board[rol][col] <= 8;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp8x <= rol;
                               wp8y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 8;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                           if (!Board[rol][col]) begin
                               wp8x <= rol;
                               wp8y <= col;
                               Board[rol][col] <= 8;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                           else if (Board[rol][col][5]) begin
                               wp8x <= rol;
                               wp8y <= col;
                               capturecode <= Board[rol][col];
                               Board[rol][col] <= 8;
                               Board[clickedrol][clickedcol] <= 0;
                               state <= bt;
                           end
                        end
                    end
                end
                4: begin
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
                            wp8x <= rol;
                            wp8y <= col;
                            Board[rol][col] <= 8;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                        else if (Board[rol][col][5]) begin
                            wp8x <= rol;
                            wp8y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 8;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= bt;
                        end
                    end
                end
                default: begin
                end
                endcase
                end
                else if (click == 2)
                    state <= wt;
            end
            promotion8: begin
                if (click == 1) begin
                    state <= promotion8wait;
                end
           end
            promotion8wait: begin
               if (click == 0) begin
                   state <= promotion8final;
               end
            end
            promotion8final: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            wp8p <= 1;
                            state <= bt;
                        end
                        else if (col == clickedcol + 1) begin
                            wp8p <= 2;
                            state <= bt;
                        end
                        else if (col == clickedcol + 2) begin
                            wp8p <= 3;
                            state <= bt;
                        end
                        else if (col == clickedcol + 3) begin
                            wp8p <= 4;
                            state <= bt;
                        end
                    end
                end
            end
            wr1: begin
                if(click == 1 && rol < 8 && col < 8) begin
                    if (clickedrol == rol && clickedcol != col && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
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
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
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
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (Board[rol][col][5] == 1 || !Board[rol][col])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
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
                state <= bt2;
                storedcapture2 <= capturecode;
                undorol3 <= rol;
                undocol3 <= col;
                undorol4 <= clickedrol;
                undocol4 <= clickedcol;
            end
            bt2: begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (Board[i][3] >= 49 && Board[i][3] <= 63) begin
                        Board[i][3] <= Board[i][3] - 16;
                    end
                    if (Board[i][1] >= 49 && Board[i][1] <= 63) begin
                        Board[i][1] <= Board[i][1] - 16;
                    end
                end
                capturecode <= 0;
                clickedrol <= 0;
                clickedcol <= 0;
                capindex <= 0;
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
                    case(bp1p)
                    0: begin
                        if (clickedrol == rol && !Board[rol][col]) begin
                            if (clickedcol == 1 && col == 3 && !Board[rol][2]) begin
                            bp1x <= rol;
                            bp1y <= col;
                            Board[rol][col] <= 6'b110001;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                            end
                            else if (col == clickedcol + 1) begin
                            bp1x <= rol;
                            bp1y <= col;
                            Board[rol][col] <= 6'b100001;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion1b;
                                bp1p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                            if (col == clickedcol + 1) begin
                            bp1x <= rol;
                            bp1y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b100001;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion1b;
                                bp1p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if (Board[rol][clickedcol] <= 32 && Board[rol][clickedcol] >= 17 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol + 1) begin
                            bp1x <= rol;
                            bp1y <= col;
                            capturecode <= Board[rol][clickedcol];
                            Board[rol][col] <= 6'b100001;
                            Board[clickedrol][clickedcol] <= 0;
                            Board[rol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                    1: begin
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
                       else if (clickedrol == rol && clickedcol != col && (!Board[rol][col][5])) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        else if (clickedcol == col && clickedrol != rol && (!Board[rol][col][5])) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                            if (!Board[rol][col]) begin
                                bp1x <= rol;
                                bp1y <= col;
                                Board[rol][col] <= 6'b100001;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp1x <= rol;
                                bp1y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100001;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                   2: begin
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
                                bp1x <= rol;
                                bp1y <= col;
                                Board[rol][col] <= 6'b100001;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp1x <= rol;
                                bp1y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100001;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    3: begin
                        if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                        movementvalid[6] <= 1;
                           end
                           if (movementvalid[6] && movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                               if (!Board[rol][col]) begin
                                   bp1x <= rol;
                                   bp1y <= col;
                                   Board[rol][col] <= 6'b100001;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp1x <= rol;
                                   bp1y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100001;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                        else if (clickedcol == col && clickedrol != rol && Board[rol][col][5] == 0) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                           if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                               if (!Board[rol][col]) begin
                                   bp1x <= rol;
                                   bp1y <= col;
                                   Board[rol][col] <= 6'b100001;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp1x <= rol;
                                   bp1y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100001;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                    end
                    4: begin
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
                                bp1x <= rol;
                                bp1y <= col;
                                Board[rol][col] <= 6'b100001;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp1x <= rol;
                                bp1y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100001;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    default: begin
                    end
                    endcase
                end
                else if (click == 2)
                    state <= bt;
            end
            promotion1b: begin
                if (click == 1) begin
                    state <= promotion1bwait;
                end
            end
            promotion1bwait: begin
               if (click == 0) begin
                   state <= promotion1bfinal;
               end
            end
            promotion1bfinal: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            bp1p <= 1;
                            state <= wt;
                        end
                        else if (col == clickedcol - 1) begin
                            bp1p <= 2;
                            state <= wt;
                        end
                        else if (col == clickedcol - 2) begin
                            bp1p <= 3;
                            state <= wt;
                        end
                        else if (col == clickedcol - 3) begin
                            bp1p <= 4;
                            state <= wt;
                        end
                    end
                end
            end
            bp2: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    case(bp2p)
                    0: begin
                        if (clickedrol == rol && !Board[rol][col]) begin
                            if (clickedcol == 1 && col == 3 && !Board[rol][2]) begin
                            bp2x <= rol;
                            bp2y <= col;
                            Board[rol][col] <= 6'b110010;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                            end
                            else if (col == clickedcol + 1) begin
                            bp2x <= rol;
                            bp2y <= col;
                            Board[rol][col] <= 6'b100010;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion2b;
                                bp2p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                            if (col == clickedcol + 1) begin
                            bp2x <= rol;
                            bp2y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b100010;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion2b;
                                bp2p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if (Board[rol][clickedcol] <= 32 && Board[rol][clickedcol] >= 17 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol + 1) begin
                            bp2x <= rol;
                            bp2y <= col;
                            capturecode <= Board[rol][clickedcol];
                            Board[rol][col] <= 6'b100010;
                            Board[clickedrol][clickedcol] <= 0;
                            Board[rol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                    1: begin
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
                       else if (clickedrol == rol && clickedcol != col && (!Board[rol][col][5])) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        else if (clickedcol == col && clickedrol != rol && (!Board[rol][col][5])) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                            if (!Board[rol][col]) begin
                                bp2x <= rol;
                                bp2y <= col;
                                Board[rol][col] <= 6'b100010;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp2x <= rol;
                                bp2y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100010;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                   2: begin
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
                                bp2x <= rol;
                                bp2y <= col;
                                Board[rol][col] <= 6'b100010;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp2x <= rol;
                                bp2y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100010;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    3: begin
                        if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                        movementvalid[6] <= 1;
                           end
                           if (movementvalid[6] && movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                               if (!Board[rol][col]) begin
                                   bp2x <= rol;
                                   bp2y <= col;
                                   Board[rol][col] <= 6'b100010;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp2x <= rol;
                                   bp2y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100010;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                        else if (clickedcol == col && clickedrol != rol && Board[rol][col][5] == 0) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                           if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                               if (!Board[rol][col]) begin
                                   bp2x <= rol;
                                   bp2y <= col;
                                   Board[rol][col] <= 6'b100010;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp2x <= rol;
                                   bp2y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100010;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                    end
                    4: begin
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
                                bp2x <= rol;
                                bp2y <= col;
                                Board[rol][col] <= 6'b100010;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp2x <= rol;
                                bp2y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100010;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    default: begin
                    end
                    endcase
                end
                else if (click == 2)
                    state <= bt;
            end
            promotion2b: begin
                if (click == 1) begin
                    state <= promotion2bwait;
                end
            end
            promotion2bwait: begin
               if (click == 0) begin
                   state <= promotion2bfinal;
               end
            end
            promotion2bfinal: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            bp2p <= 1;
                            state <= wt;
                        end
                        else if (col == clickedcol - 1) begin
                            bp2p <= 2;
                            state <= wt;
                        end
                        else if (col == clickedcol - 2) begin
                            bp2p <= 3;
                            state <= wt;
                        end
                        else if (col == clickedcol - 3) begin
                            bp2p <= 4;
                            state <= wt;
                        end
                    end
                end
            end
            bp3: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    case(bp3p)
                    0: begin
                        if (clickedrol == rol && !Board[rol][col]) begin
                            if (clickedcol == 1 && col == 3 && !Board[rol][2]) begin
                            bp3x <= rol;
                            bp3y <= col;
                            Board[rol][col] <= 6'b110011;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                            end
                            else if (col == clickedcol + 1) begin
                            bp3x <= rol;
                            bp3y <= col;
                            Board[rol][col] <= 6'b100011;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion3b;
                                bp3p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                            if (col == clickedcol + 1) begin
                            bp3x <= rol;
                            bp3y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b100011;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion3b;
                                bp3p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if (Board[rol][clickedcol] <= 32 && Board[rol][clickedcol] >= 17 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol + 1) begin
                            bp3x <= rol;
                            bp3y <= col;
                            capturecode <= Board[rol][clickedcol];
                            Board[rol][col] <= 6'b100011;
                            Board[clickedrol][clickedcol] <= 0;
                            Board[rol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                    1: begin
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
                       else if (clickedrol == rol && clickedcol != col && (!Board[rol][col][5])) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        else if (clickedcol == col && clickedrol != rol && (!Board[rol][col][5])) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                            if (!Board[rol][col]) begin
                                bp3x <= rol;
                                bp3y <= col;
                                Board[rol][col] <= 6'b100011;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp3x <= rol;
                                bp3y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100011;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                   2: begin
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
                                bp3x <= rol;
                                bp3y <= col;
                                Board[rol][col] <= 6'b100011;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp3x <= rol;
                                bp3y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100011;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    3: begin
                        if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                        movementvalid[6] <= 1;
                           end
                           if (movementvalid[6] && movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                               if (!Board[rol][col]) begin
                                   bp3x <= rol;
                                   bp3y <= col;
                                   Board[rol][col] <= 6'b100011;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp3x <= rol;
                                   bp3y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100011;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                        else if (clickedcol == col && clickedrol != rol && Board[rol][col][5] == 0) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                           if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                               if (!Board[rol][col]) begin
                                   bp3x <= rol;
                                   bp3y <= col;
                                   Board[rol][col] <= 6'b100011;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp3x <= rol;
                                   bp3y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100011;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                    end
                    4: begin
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
                                bp3x <= rol;
                                bp3y <= col;
                                Board[rol][col] <= 6'b100011;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp3x <= rol;
                                bp3y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100011;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    default: begin
                    end
                    endcase
                end
                else if (click == 2)
                    state <= bt;
            end
            promotion3b: begin
                if (click == 1) begin
                    state <= promotion3bwait;
                end
            end
            promotion3bwait: begin
               if (click == 0) begin
                   state <= promotion3bfinal;
               end
            end
            promotion3bfinal: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            bp3p <= 1;
                            state <= wt;
                        end
                        else if (col == clickedcol - 1) begin
                            bp3p <= 2;
                            state <= wt;
                        end
                        else if (col == clickedcol - 2) begin
                            bp3p <= 3;
                            state <= wt;
                        end
                        else if (col == clickedcol - 3) begin
                            bp3p <= 4;
                            state <= wt;
                        end
                    end
                end
            end
            bp4: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    case(bp4p)
                    0: begin
                        if (clickedrol == rol && !Board[rol][col]) begin
                            if (clickedcol == 1 && col == 3 && !Board[rol][2]) begin
                            bp4x <= rol;
                            bp4y <= col;
                            Board[rol][col] <= 6'b110100;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                            end
                            else if (col == clickedcol + 1) begin
                            bp4x <= rol;
                            bp4y <= col;
                            Board[rol][col] <= 6'b100100;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion4b;
                                bp4p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                            if (col == clickedcol + 1) begin
                            bp4x <= rol;
                            bp4y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b100100;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion4b;
                                bp4p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if (Board[rol][clickedcol] <= 32 && Board[rol][clickedcol] >= 17 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol + 1) begin
                            bp4x <= rol;
                            bp4y <= col;
                            capturecode <= Board[rol][clickedcol];
                            Board[rol][col] <= 6'b100100;
                            Board[clickedrol][clickedcol] <= 0;
                            Board[rol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                    1: begin
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
                       else if (clickedrol == rol && clickedcol != col && (!Board[rol][col][5])) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        else if (clickedcol == col && clickedrol != rol && (!Board[rol][col][5])) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                            if (!Board[rol][col]) begin
                                bp4x <= rol;
                                bp4y <= col;
                                Board[rol][col] <= 6'b100100;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp4x <= rol;
                                bp4y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100100;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                   2: begin
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
                                bp4x <= rol;
                                bp4y <= col;
                                Board[rol][col] <= 6'b100100;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp4x <= rol;
                                bp4y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100100;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    3: begin
                        if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                        movementvalid[6] <= 1;
                           end
                           if (movementvalid[6] && movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                               if (!Board[rol][col]) begin
                                   bp4x <= rol;
                                   bp4y <= col;
                                   Board[rol][col] <= 6'b100100;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp4x <= rol;
                                   bp4y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100100;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                        else if (clickedcol == col && clickedrol != rol && Board[rol][col][5] == 0) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                           if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                               if (!Board[rol][col]) begin
                                   bp4x <= rol;
                                   bp4y <= col;
                                   Board[rol][col] <= 6'b100100;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp4x <= rol;
                                   bp4y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100100;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                    end
                    4: begin
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
                                bp4x <= rol;
                                bp4y <= col;
                                Board[rol][col] <= 6'b100100;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp4x <= rol;
                                bp4y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100100;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    default: begin
                    end
                    endcase
                end
                else if (click == 2)
                    state <= bt;
            end
            promotion4b: begin
                if (click == 1) begin
                    state <= promotion4bwait;
                end
            end
            promotion4bwait: begin
               if (click == 0) begin
                   state <= promotion4bfinal;
               end
            end
            promotion4bfinal: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            bp4p <= 1;
                            state <= wt;
                        end
                        else if (col == clickedcol - 1) begin
                            bp4p <= 2;
                            state <= wt;
                        end
                        else if (col == clickedcol - 2) begin
                            bp4p <= 3;
                            state <= wt;
                        end
                        else if (col == clickedcol - 3) begin
                            bp4p <= 4;
                            state <= wt;
                        end
                    end
                end
            end
            bp5: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    case(bp5p)
                    0: begin
                        if (clickedrol == rol && !Board[rol][col]) begin
                            if (clickedcol == 1 && col == 3 && !Board[rol][2]) begin
                            bp5x <= rol;
                            bp5y <= col;
                            Board[rol][col] <= 6'b110101;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                            end
                            else if (col == clickedcol + 1) begin
                            bp5x <= rol;
                            bp5y <= col;
                            Board[rol][col] <= 6'b100101;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion5b;
                                bp5p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                            if (col == clickedcol + 1) begin
                            bp5x <= rol;
                            bp5y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b100101;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion5b;
                                bp5p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if (Board[rol][clickedcol] <= 32 && Board[rol][clickedcol] >= 17 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol + 1) begin
                            bp5x <= rol;
                            bp5y <= col;
                            capturecode <= Board[rol][clickedcol];
                            Board[rol][col] <= 6'b100101;
                            Board[clickedrol][clickedcol] <= 0;
                            Board[rol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                    1: begin
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
                       else if (clickedrol == rol && clickedcol != col && (!Board[rol][col][5])) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        else if (clickedcol == col && clickedrol != rol && (!Board[rol][col][5])) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                            if (!Board[rol][col]) begin
                                bp5x <= rol;
                                bp5y <= col;
                                Board[rol][col] <= 6'b100101;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp5x <= rol;
                                bp5y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100101;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                   2: begin
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
                                bp5x <= rol;
                                bp5y <= col;
                                Board[rol][col] <= 6'b100101;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp5x <= rol;
                                bp5y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100101;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    3: begin
                        if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                        movementvalid[6] <= 1;
                           end
                           if (movementvalid[6] && movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                               if (!Board[rol][col]) begin
                                   bp5x <= rol;
                                   bp5y <= col;
                                   Board[rol][col] <= 6'b100101;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp5x <= rol;
                                   bp5y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100101;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                        else if (clickedcol == col && clickedrol != rol && Board[rol][col][5] == 0) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                           if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                               if (!Board[rol][col]) begin
                                   bp5x <= rol;
                                   bp5y <= col;
                                   Board[rol][col] <= 6'b100101;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp5x <= rol;
                                   bp5y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100101;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                    end
                    4: begin
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
                                bp5x <= rol;
                                bp5y <= col;
                                Board[rol][col] <= 6'b100101;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp5x <= rol;
                                bp5y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100101;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    default: begin
                    end
                    endcase
                end
                else if (click == 2)
                    state <= bt;
            end
            promotion5b: begin
                if (click == 1) begin
                    state <= promotion5bwait;
                end
            end
            promotion5bwait: begin
               if (click == 0) begin
                   state <= promotion5bfinal;
               end
            end
            promotion5bfinal: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            bp5p <= 1;
                            state <= wt;
                        end
                        else if (col == clickedcol - 1) begin
                            bp5p <= 2;
                            state <= wt;
                        end
                        else if (col == clickedcol - 2) begin
                            bp5p <= 3;
                            state <= wt;
                        end
                        else if (col == clickedcol - 3) begin
                            bp5p <= 4;
                            state <= wt;
                        end
                    end
                end
            end
            bp6: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    case(bp6p)
                    0: begin
                        if (clickedrol == rol && !Board[rol][col]) begin
                            if (clickedcol == 1 && col == 3 && !Board[rol][2]) begin
                            bp6x <= rol;
                            bp6y <= col;
                            Board[rol][col] <= 6'b110110;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                            end
                            else if (col == clickedcol + 1) begin
                            bp6x <= rol;
                            bp6y <= col;
                            Board[rol][col] <= 6'b100110;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion6b;
                                bp6p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                            if (col == clickedcol + 1) begin
                            bp6x <= rol;
                            bp6y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b100110;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion6b;
                                bp6p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if (Board[rol][clickedcol] <= 32 && Board[rol][clickedcol] >= 17 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol + 1) begin
                            bp6x <= rol;
                            bp6y <= col;
                            capturecode <= Board[rol][clickedcol];
                            Board[rol][col] <= 6'b100110;
                            Board[clickedrol][clickedcol] <= 0;
                            Board[rol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                    1: begin
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
                       else if (clickedrol == rol && clickedcol != col && (!Board[rol][col][5])) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        else if (clickedcol == col && clickedrol != rol && (!Board[rol][col][5])) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                            if (!Board[rol][col]) begin
                                bp6x <= rol;
                                bp6y <= col;
                                Board[rol][col] <= 6'b100110;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp6x <= rol;
                                bp6y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100110;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                   2: begin
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
                                bp6x <= rol;
                                bp6y <= col;
                                Board[rol][col] <= 6'b100110;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp6x <= rol;
                                bp6y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100110;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    3: begin
                        if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                        movementvalid[6] <= 1;
                           end
                           if (movementvalid[6] && movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                               if (!Board[rol][col]) begin
                                   bp6x <= rol;
                                   bp6y <= col;
                                   Board[rol][col] <= 6'b100110;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp6x <= rol;
                                   bp6y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100110;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                        else if (clickedcol == col && clickedrol != rol && Board[rol][col][5] == 0) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                           if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                               if (!Board[rol][col]) begin
                                   bp6x <= rol;
                                   bp6y <= col;
                                   Board[rol][col] <= 6'b100110;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp6x <= rol;
                                   bp6y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100110;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                    end
                    4: begin
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
                                bp6x <= rol;
                                bp6y <= col;
                                Board[rol][col] <= 6'b100110;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp6x <= rol;
                                bp6y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100110;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    default: begin
                    end
                    endcase
                end
                else if (click == 2)
                    state <= bt;
            end
            promotion6b: begin
                if (click == 1) begin
                    state <= promotion6bwait;
                end
            end
            promotion6bwait: begin
               if (click == 0) begin
                   state <= promotion6bfinal;
               end
            end
            promotion6bfinal: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            bp6p <= 1;
                            state <= wt;
                        end
                        else if (col == clickedcol - 1) begin
                            bp6p <= 2;
                            state <= wt;
                        end
                        else if (col == clickedcol - 2) begin
                            bp6p <= 3;
                            state <= wt;
                        end
                        else if (col == clickedcol - 3) begin
                            bp6p <= 4;
                            state <= wt;
                        end
                    end
                end
            end
            bp7: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    case(bp7p)
                    0: begin
                        if (clickedrol == rol && !Board[rol][col]) begin
                            if (clickedcol == 1 && col == 3 && !Board[rol][2]) begin
                            bp7x <= rol;
                            bp7y <= col;
                            Board[rol][col] <= 6'b110111;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                            end
                            else if (col == clickedcol + 1) begin
                            bp7x <= rol;
                            bp7y <= col;
                            Board[rol][col] <= 6'b100111;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion7b;
                                bp7p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                            if (col == clickedcol + 1) begin
                            bp7x <= rol;
                            bp7y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b100111;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion7b;
                                bp7p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if (Board[rol][clickedcol] <= 32 && Board[rol][clickedcol] >= 17 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol + 1) begin
                            bp7x <= rol;
                            bp7y <= col;
                            capturecode <= Board[rol][clickedcol];
                            Board[rol][col] <= 6'b100111;
                            Board[clickedrol][clickedcol] <= 0;
                            Board[rol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                    1: begin
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
                       else if (clickedrol == rol && clickedcol != col && (!Board[rol][col][5])) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        else if (clickedcol == col && clickedrol != rol && (!Board[rol][col][5])) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                            if (!Board[rol][col]) begin
                                bp7x <= rol;
                                bp7y <= col;
                                Board[rol][col] <= 6'b100111;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp7x <= rol;
                                bp7y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100111;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                   2: begin
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
                                bp7x <= rol;
                                bp7y <= col;
                                Board[rol][col] <= 6'b100111;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp7x <= rol;
                                bp7y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100111;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    3: begin
                        if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                        movementvalid[6] <= 1;
                           end
                           if (movementvalid[6] && movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                               if (!Board[rol][col]) begin
                                   bp7x <= rol;
                                   bp7y <= col;
                                   Board[rol][col] <= 6'b100111;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp7x <= rol;
                                   bp7y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100111;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                        else if (clickedcol == col && clickedrol != rol && Board[rol][col][5] == 0) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                           if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                               if (!Board[rol][col]) begin
                                   bp7x <= rol;
                                   bp7y <= col;
                                   Board[rol][col] <= 6'b100111;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp7x <= rol;
                                   bp7y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b100111;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                    end
                    4: begin
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
                                bp7x <= rol;
                                bp7y <= col;
                                Board[rol][col] <= 6'b100111;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp7x <= rol;
                                bp7y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b100111;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    default: begin
                    end
                    endcase
                end
                else if (click == 2)
                    state <= bt;
            end
            promotion7b: begin
                if (click == 1) begin
                    state <= promotion7bwait;
                end
            end
            promotion7bwait: begin
               if (click == 0) begin
                   state <= promotion7bfinal;
               end
            end
            promotion7bfinal: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            bp7p <= 1;
                            state <= wt;
                        end
                        else if (col == clickedcol - 1) begin
                            bp7p <= 2;
                            state <= wt;
                        end
                        else if (col == clickedcol - 2) begin
                            bp7p <= 3;
                            state <= wt;
                        end
                        else if (col == clickedcol - 3) begin
                            bp7p <= 4;
                            state <= wt;
                        end
                    end
                end
            end
            bp8: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    case(bp8p)
                    0: begin
                        if (clickedrol == rol && !Board[rol][col]) begin
                            if (clickedcol == 1 && col == 3 && !Board[rol][2]) begin
                            bp8x <= rol;
                            bp8y <= col;
                            Board[rol][col] <= 6'b111000;
                            Board[clickedrol][clickedcol] <= 0;
                            state <= wt;
                            end
                            else if (col == clickedcol + 1) begin
                            bp8x <= rol;
                            bp8y <= col;
                            Board[rol][col] <= 6'b101000;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion8b;
                                bp8p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if ((clickedrol == rol + 1 || clickedrol == rol - 1) && (Board[rol][col][5] == 0 && Board[rol][col] != 0)) begin
                            if (col == clickedcol + 1) begin
                            bp8x <= rol;
                            bp8y <= col;
                            capturecode <= Board[rol][col];
                            Board[rol][col] <= 6'b101000;
                            Board[clickedrol][clickedcol] <= 0;
                            if (col == 7) begin
                                state <= promotion8b;
                                bp8p <= 5;
                                clickedrol <= rol;
                                clickedcol <= col;
                            end
                            else begin
                                state <= wt;
                            end
                            end
                        end
                        else if (Board[rol][clickedcol] <= 32 && Board[rol][clickedcol] >= 17 && (clickedrol == rol + 1 || clickedrol == rol - 1) && col == clickedcol + 1) begin
                            bp8x <= rol;
                            bp8y <= col;
                            capturecode <= Board[rol][clickedcol];
                            Board[rol][col] <= 6'b101000;
                            Board[clickedrol][clickedcol] <= 0;
                            Board[rol][clickedcol] <= 0;
                            state <= wt;
                        end
                    end
                    1: begin
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
                       else if (clickedrol == rol && clickedcol != col && (!Board[rol][col][5])) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        else if (clickedcol == col && clickedrol != rol && (!Board[rol][col][5])) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                        end
                        if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                            if (!Board[rol][col]) begin
                                bp8x <= rol;
                                bp8y <= col;
                                Board[rol][col] <= 6'b101000;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp8x <= rol;
                                bp8y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b101000;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                   2: begin
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
                                bp8x <= rol;
                                bp8y <= col;
                                Board[rol][col] <= 6'b101000;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp8x <= rol;
                                bp8y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b101000;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    3: begin
                        if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                            if (clickedcol < col - 1 && col >= 1) begin
                                for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                    if (Board[rol][i + clickedcol] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == col - clickedcol - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol > col + 1) begin
                                for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                    if (Board[rol][i + col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedcol - col - 1)
                                        movementvalid[6] <= 1;
                                end
                           end
                           else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                        movementvalid[6] <= 1;
                           end
                           if (movementvalid[6] && movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
                               if (!Board[rol][col]) begin
                                   bp8x <= rol;
                                   bp8y <= col;
                                   Board[rol][col] <= 6'b101000;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp8x <= rol;
                                   bp8y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b101000;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                        else if (clickedcol == col && clickedrol != rol && Board[rol][col][5] == 0) begin
                            if (clickedrol < rol - 1 && rol >= 1) begin
                                for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                    if (Board[i + clickedrol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == rol - clickedrol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol > rol + 1) begin
                                for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                    if (Board[i + rol][col] != 0) begin
                                        movementvalid[i-1] <= 0;
                                    end
                                    if (i == clickedrol - rol - 1) begin
                                        movementvalid[6] <= 1;
                                    end
                                end
                           end
                           else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                                movementvalid[6] <= 1;
                           end
                           if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
                               if (!Board[rol][col]) begin
                                   bp8x <= rol;
                                   bp8y <= col;
                                   Board[rol][col] <= 6'b101000;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                               else if (!Board[rol][col][5]) begin
                                   bp8x <= rol;
                                   bp8y <= col;
                                   capturecode <= Board[rol][col];
                                   Board[rol][col] <= 6'b101000;
                                   Board[clickedrol][clickedcol] <= 0;
                                   state <= wt;
                               end
                            end
                        end
                    end
                    4: begin
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
                                bp8x <= rol;
                                bp8y <= col;
                                Board[rol][col] <= 6'b101000;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                            else if (!Board[rol][col][5]) begin
                                bp8x <= rol;
                                bp8y <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b101000;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                            end
                        end
                    end
                    default: begin
                    end
                    endcase
                end
                else if (click == 2)
                    state <= bt;
            end
            promotion8b: begin
                if (click == 1) begin
                    state <= promotion8bwait;
                end
            end
            promotion8bwait: begin
               if (click == 0) begin
                   state <= promotion8bfinal;
               end
            end
            promotion8bfinal: begin
                if (click == 1) begin
                    if (clickedrol == rol) begin
                        if (col == clickedcol) begin
                            bp8p <= 1;
                            state <= wt;
                        end
                        else if (col == clickedcol - 1) begin
                            bp8p <= 2;
                            state <= wt;
                        end
                        else if (col == clickedcol - 2) begin
                            bp8p <= 3;
                            state <= wt;
                        end
                        else if (col == clickedcol - 3) begin
                            bp8p <= 4;
                            state <= wt;
                        end
                    end
                end
            end
            br1: begin
                if(click == 1&& rol < 8 && col < 8) begin
                    if (clickedrol == rol && clickedcol != col && Board[rol][col][5] == 0) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1)
                                    movementvalid[6] <= 1;
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1)
                                    movementvalid[6] <= 1;
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                    movementvalid[6] <= 1;
                       end
                       if (movementvalid[6] && movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
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
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
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
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1)
                                    movementvalid[6] <= 1;
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1)
                                    movementvalid[6] <= 1;
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                                    movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
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
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                       if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0])begin
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
                   else if (clickedrol == rol && clickedcol != col && (!Board[rol][col][5])) begin
                        if (clickedcol < col - 1 && col >= 1) begin
                            for (i = 1; i < (col - clickedcol); i = i + 1) begin
                                if (Board[rol][i + clickedcol] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == col - clickedcol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol > col + 1) begin
                            for (i = 1; i < (clickedcol - col); i = i + 1) begin
                                if (Board[rol][i + col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedcol - col - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedcol == col - 1 || clickedcol == col + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    else if (clickedcol == col && clickedrol != rol && (!Board[rol][col][5])) begin
                        if (clickedrol < rol - 1 && rol >= 1) begin
                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
                                if (Board[i + clickedrol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == rol - clickedrol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
//                       else if (clickedrol >= 2 && rol == 0) begin
//                            for (i = 1; i < (rol - clickedrol); i = i + 1) begin
//                                if (Board[i + clickedrol][col] != 0) begin
//                                    movementvalid[i-1] <= 0;
//                                end
//                                if (i == rol - clickedrol - 1) begin
//                                    movementvalid[6] <= 1;
//                                end
//                            end
//                       end
                       else if (clickedrol > rol + 1) begin
                            for (i = 1; i < (clickedrol - rol); i = i + 1) begin
                                if (Board[i + rol][col] != 0) begin
                                    movementvalid[i-1] <= 0;
                                end
                                if (i == clickedrol - rol - 1) begin
                                    movementvalid[6] <= 1;
                                end
                            end
                       end
                       else if (clickedrol == rol - 1 || clickedrol == rol + 1) begin
                            movementvalid[6] <= 1;
                       end
                    end
                    if (movementvalid[6]&&movementvalid[5]&&movementvalid[4]&&movementvalid[3]&&movementvalid[2]&&movementvalid[1]&&movementvalid[0]) begin
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
                        if (Board[rol][col][5] == 0) begin
                            if (!Board[rol][col]) begin
                                bkx <= rol;
                                bky <= col;
                                Board[rol][col] <= 6'b110000;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
                                bkmoved <= 1;
                            end
                            else if (!Board[rol][col][5]) begin
                                bkx <= rol;
                                bky <= col;
                                capturecode <= Board[rol][col];
                                Board[rol][col] <= 6'b110000;
                                Board[clickedrol][clickedcol] <= 0;
                                state <= wt;
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
            wt3: begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (Board[i][4] >= 17 && Board[i][4] <= 32) begin
                        Board[i][4] <= Board[i][4] - 16;
                    end
                    if (Board[i][6] >= 17 && Board[i][6] <= 32) begin
                        Board[i][6] <= Board[i][6] - 16;
                    end
                end
                if (click == 1) begin
                    state <= wt2;
                end
                if (undo1) begin
                    state <= wt4;
                end
            end
            bt3: begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (Board[i][3] >= 49 && Board[i][3] <= 63) begin
                        Board[i][3] <= Board[i][3] - 16;
                    end
                    if (Board[i][1] >= 49 && Board[i][1] <= 63) begin
                        Board[i][1] <= Board[i][1] - 16;
                    end
                end
                if (click == 1) begin
                    state <= bt2;
                end
                if (undo1) begin
                    state <= bt4;
                end
            end
            wt5: begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (Board[i][4] >= 17 && Board[i][4] <= 32) begin
                        Board[i][4] <= Board[i][4] - 16;
                    end
                    if (Board[i][6] >= 17 && Board[i][6] <= 32) begin
                        Board[i][6] <= Board[i][6] - 16;
                    end
                end
                if (click) begin
                state <= wt2;
                end
            end
            bt5: begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (Board[i][3] >= 49 && Board[i][3] <= 63) begin
                        Board[i][3] <= Board[i][3] - 16;
                    end
                    if (Board[i][1] >= 49 && Board[i][1] <= 63) begin
                        Board[i][1] <= Board[i][1] - 16;
                    end
                end
                if (click) begin
                    state <= bt2;
                end
            end
            endcase          
            if ((undo && state != wt3 && state != bt3 && !state%2) || state == wt4) begin
                case (Board[undorol1][undocol1])
                    33,49: begin
                        bp1x <= undorol2;
                        bp1y <= undocol2;
                    end
                    34,50: begin
                        bp2x <= undorol2;
                        bp2y <= undocol2;
                    end
                    35,51: begin
                        bp3x <= undorol2;
                        bp3y <= undocol2;
                    end
                    36,52: begin
                        bp4x <= undorol2;
                        bp4y <= undocol2;
                    end
                    37,53: begin
                        bp5x <= undorol2;
                        bp5y <= undocol2;
                    end
                    38,54: begin
                        bp6x <= undorol2;
                        bp6y <= undocol2;
                    end
                    39,55: begin
                        bp7x <= undorol2;
                        bp7y <= undocol2;
                    end
                    40,56: begin
                        bp8x <= undorol2;
                        bp8y <= undocol2;
                    end
                    41: begin
                        br1x <= undorol2;
                        br1y <= undocol2;
                    end
                    42: begin
                        br2x <= undorol2;
                        br2y <= undocol2;
                    end
                    43: begin
                        bb1x <= undorol2;
                        bb1y <= undocol2;
                    end
                    44: begin
                        bb2x <= undorol2;
                        bb2y <= undocol2;
                    end
                    45: begin
                        bk1x <= undorol2;
                        bk1y <= undocol2;
                    end
                    46: begin
                        bk2x <= undorol2;
                        bk2y <= undocol2;
                    end
                    47: begin
                        bqx <= undorol2;
                        bqy <= undocol2;
                    end
                    48: begin
                        bkx <= undorol2;
                        bky <= undocol2;
                    end
                default: begin
                end
                endcase
                Board[undorol2][undocol2] <= Board[undorol1][undocol1];
                Board[undorol1][undocol1] <= storedcapture1;
                capindex <= 1;
                if (state != wt4)
                state <= bt3;
                else 
                state <= bt5;
                end
            else if ((undo && state != wt3 && state != bt3 && state%2) || state == bt4) begin
                case (Board[undorol3][undocol3])
                    1,17: begin
                        wp1x <= undorol4;
                        wp1y <= undocol4;
                    end
                    2,18: begin
                        wp2x <= undorol4;
                        wp2y <= undocol4;
                    end
                    3,19: begin
                        wp3x <= undorol4;
                        wp3y <= undocol4;
                    end
                    4,20: begin
                        wp4x <= undorol4;
                        wp4y <= undocol4;
                    end
                    5,21: begin
                        wp5x <= undorol4;
                        wp5y <= undocol4;
                    end
                    6,22: begin
                        wp6x <= undorol4;
                        wp6y <= undocol4;
                    end
                    7,23: begin
                        wp7x <= undorol4;
                        wp7y <= undocol4;
                    end
                    8,24: begin
                        wp8x <= undorol4;
                        wp8y <= undocol4;
                    end
                    9: begin
                        wr1x <= undorol4;
                        wr1y <= undocol4;
                    end
                    10: begin
                        wr2x <= undorol4;
                        wr2y <= undocol4;
                    end
                    11: begin
                        wb1x <= undorol4;
                        wb1y <= undocol4;
                    end
                    12: begin
                        wb2x <= undorol4;
                        wb2y <= undocol4;
                    end
                    13: begin
                        wk1x <= undorol4;
                        wk1y <= undocol4;
                    end
                    14: begin
                        wk2x <= undorol4;
                        wk2y <= undocol4;
                    end
                    15: begin
                        wqx <= undorol4;
                        wqy <= undocol4;
                    end
                    16: begin
                        wkx <= undorol4;
                        wky <= undocol4;
                    end
                default: begin
                end
                endcase
                Board[undorol4][undocol4] <= Board[undorol3][undocol3];
                Board[undorol3][undocol3] <= storedcapture2;
                capindex <= 2;
                if (state != bt4)
                state <= wt3;
                else
                state <= wt5;
            end
       end
endmodule
