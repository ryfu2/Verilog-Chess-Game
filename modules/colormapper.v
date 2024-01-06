`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2023 06:52:27 PM
// Design Name: 
// Module Name: colormapper
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


module colormapper(
    input blank, Clk, Reset, vsync, undo, undo1,
    input [3:0] click,
    input [9:0] DrawX, DrawY, mousex, mousey,
    output reg [3:0] Red, Blue, Green,
    output [6:0] stateo
    );
    wire boardon;
    wire [3:0] cbR, cbB, cbG;
    chessboard_example chessboard(
    .vga_clk(Clk),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .red(cbR),
    .green(cbG),
    .blue(cbB),
    .boardon(boardon)
    );
    
    //State Machine Instantiation
    wire [3:0] wp1x, wp2x, wp3x, wp4x, wp5x, wp6x, wp7x, wp8x;
    wire [3:0] wp1y, wp2y, wp3y, wp4y, wp5y, wp6y, wp7y, wp8y;
    wire [3:0] bp1x, bp2x, bp3x, bp4x, bp5x, bp6x, bp7x, bp8x;
    wire [3:0] bp1y, bp2y, bp3y, bp4y, bp5y, bp6y, bp7y, bp8y;
    wire [3:0] wr1x, wr1y, wr2x, wr2y, br1x, br1y, br2x, br2y;
    wire [3:0] wb1x, wb1y, wb2x, wb2y, bb1x, bb1y, bb2x, bb2y;
    wire [3:0] wk1x, wk1y, wk2x, wk2y, bk1x, bk1y, bk2x, bk2y;
    wire [3:0] wqx, wqy, bqx, bqy;
    wire [3:0] wkx, wky, bkx, bky;
    wire [3:0] wp1p, wp2p, wp3p, wp4p, wp5p, wp6p, wp7p, wp8p;
    wire [3:0] bp1p, bp2p, bp3p, bp4p, bp5p, bp6p, bp7p, bp8p;
    wire [6:0] state;
    wire [5:0] capturecode, storedcapture1, storedcapture2;
    wire [1:0] capindex;
    assign stateo = state;
    moving_states fsm (
    .Clk(vsync),
    .click(click),
    .reset(Reset),
    .undo(undo),
    .undo1(undo1),
    .mousex(mousex),
    .mousey(mousey),
    .wp1x(wp1x),
    .wp1y(wp1y),
    .wp2x(wp2x),
    .wp2y(wp2y),
    .wp3x(wp3x),
    .wp3y(wp3y),
    .wp4x(wp4x),
    .wp4y(wp4y),
    .wp5x(wp5x),
    .wp5y(wp5y),
    .wp6x(wp6x),
    .wp6y(wp6y),
    .wp7x(wp7x),
    .wp7y(wp7y),
    .wp8x(wp8x),
    .wp8y(wp8y),
    .bp1x(bp1x),
    .bp1y(bp1y),
    .bp2x(bp2x),
    .bp2y(bp2y),
    .bp3x(bp3x),
    .bp3y(bp3y),
    .bp4x(bp4x),
    .bp4y(bp4y),
    .bp5x(bp5x),
    .bp5y(bp5y),
    .bp6x(bp6x),
    .bp6y(bp6y),
    .bp7x(bp7x),
    .bp7y(bp7y),
    .bp8x(bp8x),
    .bp8y(bp8y),
    .wr1x(wr1x),
    .wr1y(wr1y),
    .wr2x(wr2x),
    .wr2y(wr2y),
    .br1x(br1x),
    .br1y(br1y),
    .br2x(br2x),
    .br2y(br2y),
    .wb1x(wb1x),
    .wb1y(wb1y),
    .wb2x(wb2x),
    .wb2y(wb2y),
    .bb1x(bb1x),
    .bb1y(bb1y),
    .bb2x(bb2x),
    .bb2y(bb2y),
    .wk1x(wk1x),
    .wk1y(wk1y),
    .wk2x(wk2x),
    .wk2y(wk2y),
    .bk1x(bk1x),
    .bk1y(bk1y),
    .bk2x(bk2x),
    .bk2y(bk2y),
    .wqx(wqx),
    .wqy(wqy),
    .bqx(bqx),
    .bqy(bqy),
    .wkx(wkx),
    .wky(wky),
    .bkx(bkx),
    .bky(bky),
    .wp1p(wp1p),
    .wp2p(wp2p),
    .wp3p(wp3p),
    .wp4p(wp4p),
    .wp5p(wp5p),
    .wp6p(wp6p),
    .wp7p(wp7p),
    .wp8p(wp8p),
    .bp1p(bp1p),
    .bp2p(bp2p),
    .bp3p(bp3p),
    .bp4p(bp4p),
    .bp5p(bp5p),
    .bp6p(bp6p),
    .bp7p(bp7p),
    .bp8p(bp8p),
    .state(state),
    .capindex(capindex),
    .capturecode(capturecode),
    .storedcapture1(storedcapture1),
    .storedcapture2(storedcapture2)
    );
    
    reg[31:0] disablesig;
    
    always @(posedge Clk) begin
        if (Reset) begin
            disablesig <= 0;
        end
        if (capturecode[5]) begin
            if (capturecode[4]) begin
                disablesig[(capturecode[3:0] + 15)] <= 1;
            end
            else begin
                disablesig[(capturecode[4:0] + 15)] <= 1;
            end
        end
        else begin
            if (capturecode != 0) begin
                if (capturecode <= 32 && capturecode >= 17) begin
                disablesig[(capturecode[4:0] - 17)] <= 1;
                end
                else begin
                disablesig[(capturecode[4:0] - 1)] <= 1;
                end
            end
        end
        if (undo || undo1) begin
            if (capindex == 2) begin
                disablesig[(storedcapture2[4:0] + 15)] <= 0;
            end
            else if (storedcapture1 != 0 && capindex == 1) begin
                disablesig[(storedcapture1[4:0] - 1)] <= 0;
            end
        end
    end
    //White Pieces
    //Pawns (8 pawns in total)
    wire [3:0]p1R, p1G, p1B;
    wire p1on;
    wire[9:0] a2offsetx, a2offsety;
    assign a2offsetx = 55*wp1x + 102;
    assign a2offsety = 55*wp1y + 20;
    wpawn_example a2 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(a2offsetx),
        .offsetY(a2offsety),
        .promotion(wp1p),
        .red(p1R),
        .green(p1G),
        .blue(p1B),
        .pawn_on(p1on)
    );
    
    wire [3:0]p2R, p2G, p2B;
    wire p2on;
    wire[9:0] b2offsetx, b2offsety;
    assign b2offsetx = 55*wp2x + 102;
    assign b2offsety = 55*wp2y + 20;
    
    wpawn_example b2 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(b2offsetx),
        .offsetY(b2offsety),
        .promotion(wp2p),
        .red(p2R),
        .green(p2G),
        .blue(p2B),
        .pawn_on(p2on)
    );
    
    wire [3:0]p3R, p3G, p3B;
    wire p3on;
    wire[9:0] c2offsetx, c2offsety;
    assign c2offsetx = 55*wp3x + 102;
    assign c2offsety = 55*wp3y + 20;
    
    wpawn_example c2 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(c2offsetx),
        .offsetY(c2offsety),
        .promotion(wp3p),
        .red(p3R),
        .green(p3G),
        .blue(p3B),
        .pawn_on(p3on)
    );
    
    wire [3:0]p4R, p4G, p4B;
    wire p4on;
    wire[9:0] d2offsetx, d2offsety;
    assign d2offsetx = 55*wp4x + 102;
    assign d2offsety = 55*wp4y + 20;
    
    wpawn_example d2 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(d2offsetx ),
        .offsetY(d2offsety),
        .promotion(wp4p),
        .red(p4R),
        .green(p4G),
        .blue(p4B),
        .pawn_on(p4on)
    );
    
    wire [3:0]p5R, p5G, p5B;
    wire p5on;
    wire[9:0] e2offsetx, e2offsety;
    assign e2offsetx = 55*wp5x + 102;
    assign e2offsety = 55*wp5y + 20;
    
    wpawn_example e2 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(e2offsetx),
        .offsetY(e2offsety),
        .promotion(wp5p),
        .red(p5R),
        .green(p5G),
        .blue(p5B),
        .pawn_on(p5on)
    );
    
    wire [3:0]p6R, p6G, p6B;
    wire p6on;
    wire[9:0] f2offsetx, f2offsety;
    assign f2offsetx = 55*wp6x + 102;
    assign f2offsety = 55*wp6y + 20;
    
    wpawn_example f2 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(f2offsetx),
        .offsetY(f2offsety),
        .promotion(wp6p),
        .red(p6R),
        .green(p6G),
        .blue(p6B),
        .pawn_on(p6on)
    );
    
    wire [3:0]p7R, p7G, p7B;
    wire p7on;
    wire[9:0] g2offsetx, g2offsety;
    assign g2offsetx = 55*wp7x + 102;
    assign g2offsety = 55*wp7y + 20;
    
    wpawn_example g2 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(g2offsetx),
        .offsetY(g2offsety),
        .promotion(wp7p),
        .red(p7R),
        .green(p7G),
        .blue(p7B),
        .pawn_on(p7on)
    );
    
    wire [3:0]p8R, p8G, p8B;
    wire p8on;
    wire[9:0] h2offsetx, h2offsety;
    assign h2offsetx = 55*wp8x + 102;
    assign h2offsety = 55*wp8y + 20;
    
    wpawn_example h2 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(h2offsetx),
        .offsetY(h2offsety),
        .promotion(wp8p),
        .red(p8R),
        .green(p8G),
        .blue(p8B),
        .pawn_on(p8on)
    );
    
    //Sacrifice the Roooooooooooooooooook
    wire [3:0]raR, raG, raB;
    wire raon;
    wire[9:0] a1offsetx, a1offsety;
    assign a1offsetx = 55*wr1x + 102;
    assign a1offsety = 55*wr1y + 20;
    wrock_example a1 (  //I mispelled rook and it's already too late
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(a1offsetx),
        .offsetY(a1offsety),
        .red(raR),
        .green(raG),
        .blue(raB),
        .pawn_on(raon)
    );
    
    wire [3:0]rhR, rhG, rhB;
    wire rhon;
    wire[9:0] h1offsetx, h1offsety;
    assign h1offsetx = 55*wr2x + 102;
    assign h1offsety = 55*wr2y + 20;
    wrock_example h1 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(h1offsetx),
        .offsetY(h1offsety),
        .red(rhR),
        .green(rhG),
        .blue(rhB),
        .pawn_on(rhon)
    );
    
    //Bishop
    wire [3:0]bcR, bcG, bcB;
    wire bcon;
    wire[9:0] c1offsetx, c1offsety;
    assign c1offsetx = 55*wb1x + 102;
    assign c1offsety = 55*wb1y + 20;
    wbishop_example c1 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(c1offsetx),
        .offsetY(c1offsety),
        .red(bcR),
        .green(bcG),
        .blue(bcB),
        .pawn_on(bcon)
    );
    
    wire [3:0]bfR, bfG, bfB;
    wire bfon;
    wire[9:0] f1offsetx, f1offsety;
    assign f1offsetx = 55*wb2x + 102;
    assign f1offsety = 55*wb2y + 20;
    wbishop_example f1 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(f1offsetx),
        .offsetY(f1offsety),
        .red(bfR),
        .green(bfG),
        .blue(bfB),
        .pawn_on(bfon)
    );
    
    //Knight
    wire [3:0]kbR, kbG, kbB;
    wire kbon;
    wire[9:0] b1offsetx, b1offsety;
    assign b1offsetx = 55*wk1x + 102;
    assign b1offsety = 55*wk1y + 20;
    wknight_example b1 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(b1offsetx),
        .offsetY(b1offsety),
        .red(kbR),
        .green(kbG),
        .blue(kbB),
        .pawn_on(kbon)
    );
    
    wire [3:0]kgR, kgG, kgB;
    wire kgon;
    wire[9:0] g1offsetx, g1offsety;
    assign g1offsetx = 55*wk2x + 102;
    assign g1offsety = 55*wk2y + 20;
    wknight_example g1 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(g1offsetx),
        .offsetY(g1offsety),
        .red(kgR),
        .green(kgG),
        .blue(kgB),
        .pawn_on(kgon)
    );
    
    //Queen
    wire [3:0]qdR, qdG, qdB;
    wire qdon;
    wire[9:0] d1offsetx, d1offsety;
    assign d1offsetx = 55*wqx + 102;
    assign d1offsety = 55*wqy + 20;
    wqueen_example d1 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(d1offsetx),
        .offsetY(d1offsety),
        .red(qdR),
        .green(qdG),
        .blue(qdB),
        .pawn_on(qdon)
    );
    
    //King
    wire [3:0]keR, keG, keB;
    wire keon;
    wire[9:0] e1offsetx, e1offsety;
    assign e1offsetx = 55*wkx + 102;
    assign e1offsety = 55*wky + 20;
    wking_example e1 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(e1offsetx),
        .offsetY(e1offsety),
        .red(keR),
        .green(keG),
        .blue(keB),
        .pawn_on(keon)
    );
    
    
    //Black Pieces
    //Pawns
    wire [3:0]b1R, b1G, b1B;
    wire b1on;
    wire[9:0] a7offsetx, a7offsety;
    assign a7offsetx = 55*bp1x + 102;
    assign a7offsety = 55*bp1y + 20;
    bpawn_example a7 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(a7offsetx),
        .offsetY(a7offsety),
        .promotion(bp1p),
        .red(b1R),
        .green(b1G),
        .blue(b1B),
        .pawn_on(b1on)
    );
    
    wire [3:0]b2R, b2G, b2B;
    wire b2on;
    wire[9:0] b7offsetx, b7offsety;
    assign b7offsetx = 55*bp2x + 102;
    assign b7offsety = 55*bp2y + 20;
    bpawn_example b7 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(b7offsetx),
        .offsetY(b7offsety),
        .promotion(bp2p),
        .red(b2R),
        .green(b2G),
        .blue(b2B),
        .pawn_on(b2on)
    );
    
    wire [3:0]b3R, b3G, b3B;
    wire b3on;
    wire[9:0] c7offsetx, c7offsety;
    assign c7offsetx = 55*bp3x + 102;
    assign c7offsety = 55*bp3y + 20;
    
    bpawn_example c7 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(c7offsetx),
        .offsetY(c7offsety),
        .promotion(bp3p),
        .red(b3R),
        .green(b3G),
        .blue(b3B),
        .pawn_on(b3on)
    );
    
    wire [3:0]b4R, b4G, b4B;
    wire b4on;
    wire[9:0] d7offsetx, d7offsety;
    assign d7offsetx = 55*bp4x + 102;
    assign d7offsety = 55*bp4y + 20;
    
    bpawn_example d7 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(d7offsetx),
        .offsetY(d7offsety),
        .promotion(bp4p),
        .red(b4R),
        .green(b4G),
        .blue(b4B),
        .pawn_on(b4on)
    );
    
    wire [3:0]b5R, b5G, b5B;
    wire b5on;
    wire[9:0] e7offsetx, e7offsety;
    assign e7offsetx = 55*bp5x + 102;
    assign e7offsety = 55*bp5y + 20;
    
    bpawn_example e7 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(e7offsetx),
        .offsetY(e7offsety),
        .promotion(bp5p),
        .red(b5R),
        .green(b5G),
        .blue(b5B),
        .pawn_on(b5on)
    );
    
    wire [3:0]b6R, b6G, b6B;
    wire b6on;
    wire[9:0] f7offsetx, f7offsety;
    assign f7offsetx = 55*bp6x + 102;
    assign f7offsety = 55*bp6y + 20;
    
    bpawn_example f7 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(f7offsetx),
        .offsetY(f7offsety),
        .promotion(bp6p),
        .red(b6R),
        .green(b6G),
        .blue(b6B),
        .pawn_on(b6on)
    );
    
    wire [3:0]b7R, b7G, b7B;
    wire b7on;
    wire[9:0] g7offsetx, g7offsety;
    assign g7offsetx = 55*bp7x + 102;
    assign g7offsety = 55*bp7y + 20;
    
    bpawn_example g7 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(g7offsetx),
        .offsetY(g7offsety),
        .promotion(bp7p),
        .red(b7R),
        .green(b7G),
        .blue(b7B),
        .pawn_on(b7on)
    );
    
    wire [3:0]b8R, b8G, b8B;
    wire b8on;
    wire[9:0] h7offsetx, h7offsety;
    assign h7offsetx = 55*bp8x + 102;
    assign h7offsety = 55*bp8y + 20;
    
    bpawn_example h7 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(h7offsetx),
        .offsetY(h7offsety),
        .promotion(bp8p),
        .red(b8R),
        .green(b8G),
        .blue(b8B),
        .pawn_on(b8on)
    );
    
    //Rook
    wire [3:0]braR, braG, braB;
    wire braon;
    wire[9:0] a8offsetx, a8offsety;
    assign a8offsetx = 55*br1x + 102;
    assign a8offsety = 55*br1y + 20;
    brock_example a8 (  //I mispelled rook and it's already too late
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(a8offsetx),
        .offsetY(a8offsety),
        .red(braR),
        .green(braG),
        .blue(braB),
        .pawn_on(braon)
    );
    
    wire [3:0]brhR, brhG, brhB;
    wire brhon;
    wire[9:0] h8offsetx, h8offsety;
    assign h8offsetx = 55*br2x + 102;
    assign h8offsety = 55*br2y + 20;
    brock_example h8 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(h8offsetx),
        .offsetY(h8offsety),
        .red(brhR),
        .green(brhG),
        .blue(brhB),
        .pawn_on(brhon)
    );
    
        //Knight
    wire [3:0]bkbR, bkbG, bkbB;
    wire bkbon;
    wire[9:0] b8offsetx, b8offsety;
    assign b8offsetx = 55*bk1x + 102;
    assign b8offsety = 55*bk1y + 20;
    bknight_example b8 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(b8offsetx),
        .offsetY(b8offsety),
        .red(bkbR),
        .green(bkbG),
        .blue(bkbB),
        .pawn_on(bkbon)
    );
    
    wire [3:0]bkgR, bkgG, bkgB;
    wire bkgon;
    wire[9:0] g8offsetx, g8offsety;
    assign g8offsetx = 55*bk2x + 102;
    assign g8offsety = 55*bk2y + 20;
    bknight_example g8 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(g8offsetx),
        .offsetY(g8offsety),
        .red(bkgR),
        .green(bkgG),
        .blue(bkgB),
        .pawn_on(bkgon)
    );
    
        //Bishop
    wire [3:0]bbcR, bbcG, bbcB;
    wire bbcon;
    wire[9:0] c8offsetx, c8offsety;
    assign c8offsetx = 55*bb1x + 102;
    assign c8offsety = 55*bb1y + 20;
    bbishop_example c8 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(c8offsetx),
        .offsetY(c8offsety),
        .red(bbcR),
        .green(bbcG),
        .blue(bbcB),
        .pawn_on(bbcon)
    );
    
    wire [3:0]bbfR, bbfG, bbfB;
    wire bbfon;
    wire[9:0] f8offsetx, f8offsety;
    assign f8offsetx = 55*bb2x + 102;
    assign f8offsety = 55*bb2y + 20;
    bbishop_example f8 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(f8offsetx),
        .offsetY(f8offsety),
        .red(bbfR),
        .green(bbfG),
        .blue(bbfB),
        .pawn_on(bbfon)
    );
    
        //Queen
    wire [3:0]bqdR, bqdG, bqdB;
    wire bqdon;
    wire[9:0] d8offsetx, d8offsety;
    assign d8offsetx = 55*bqx + 102;
    assign d8offsety = 55*bqy + 20;
    bqueen_example d8 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(d8offsetx),
        .offsetY(d8offsety),
        .red(bqdR),
        .green(bqdG),
        .blue(bqdB),
        .pawn_on(bqdon)
    );
    
    //King
    wire [3:0]bkeR, bkeG, bkeB;
    wire bkeon;
    wire[9:0] e8offsetx, e8offsety;
    assign e8offsetx = 55*bkx + 102;
    assign e8offsety = 55*bky + 20;
    bking_example e8 (
        .vga_clk(Clk),
        .DrawX(DrawX),
        .DrawY(DrawY),
        .offsetX(e8offsetx),
        .offsetY(e8offsety),
        .red(bkeR),
        .green(bkeG),
        .blue(bkeB),
        .pawn_on(bkeon)
    );
    
    wire[3:0] rom_promotion;
    wire [3:0] propalette_red, propalette_green, propalette_blue;
    wire negedge_vga_clk;
    assign negedge_vga_clk = ~Clk;
    reg[13:0] prorom_addr;
    promotion_rom wpromotion_rom (
	.clka   (negedge_vga_clk),
	.addra  (prorom_addr),
	.douta  (rom_promotion)
    );
    promotion_palette wpromotion_palette (
	.index (rom_promotion),
	.red   (propalette_red),
	.green (propalette_green),
	.blue  (propalette_blue)
    );
    
    wire[3:0] rom_bpromotion;
    wire [3:0] bpropalette_red, bpropalette_green, bpropalette_blue;
    reg[13:0] bprorom_addr;
    bpromotion_rom bpromotion_rom (
	.clka   (negedge_vga_clk),
	.addra  (bprorom_addr),
	.douta  (rom_bpromotion)
    );
    bpromotion_palette bpromotion_palette (
	.index (rom_bpromotion),
	.red   (bpropalette_red),
	.green (bpropalette_green),
	.blue  (bpropalette_blue)
    );
    
    reg bpro_on;
    always @(*) begin
        if (bp2p == 5) begin
            if ((DrawX - b7offsetx) <= 54 && (DrawX - b7offsetx) >= 0 && DrawY <= 459 && DrawY >= 240 )
            begin
                bprorom_addr = (DrawX - b7offsetx) + (DrawY - 240) * 55;
                bpro_on = 1;
            end
            else
            begin
                bprorom_addr = 0;
                bpro_on = 0;
            end
        end
        else if (bp1p == 5) begin
            if ((DrawX - a7offsetx) <= 54 && (DrawX - a7offsetx) >= 0 && DrawY <= 459 && DrawY >= 240 )
            begin
                bprorom_addr = (DrawX - a7offsetx) + (DrawY - 240) * 55;
                bpro_on = 1;
            end
            else
            begin
                bprorom_addr = 0;
                bpro_on = 0;
            end
        end
        else if (bp3p == 5) begin
            if ((DrawX - c7offsetx) <= 54 && (DrawX - c7offsetx) >= 0 && DrawY <= 459 && DrawY >= 240 )
            begin
                bprorom_addr = (DrawX - c7offsetx) + (DrawY - 240) * 55;
                bpro_on = 1;
            end
            else
            begin
                bprorom_addr = 0;
                bpro_on = 0;
            end
        end
        else if (bp4p == 5) begin
            if ((DrawX - d7offsetx) <= 54 && (DrawX - d7offsetx) >= 0 && DrawY <= 459 && DrawY >= 240 )
            begin
                bprorom_addr = (DrawX - d7offsetx) + (DrawY - 240) * 55;
                bpro_on = 1;
            end
            else
            begin
                bprorom_addr = 0;
                bpro_on = 0;
            end
        end
        else if (bp5p == 5) begin
            if ((DrawX - e7offsetx) <= 54 && (DrawX - e7offsetx) >= 0 && DrawY <= 459 && DrawY >= 240 )
            begin
                bprorom_addr = (DrawX - e7offsetx) + (DrawY - 240) * 55;
                bpro_on = 1;
            end
            else
            begin
                bprorom_addr = 0;
                bpro_on = 0;
            end
        end
        else if (bp6p == 5) begin
            if ((DrawX - f7offsetx) <= 54 && (DrawX - f7offsetx) >= 0 && DrawY <= 459 && DrawY >= 240 )
            begin
                bprorom_addr = (DrawX - f7offsetx) + (DrawY - 240) * 55;
                bpro_on = 1;
            end
            else
            begin
                bprorom_addr = 0;
                bpro_on = 0;
            end
        end
        else if (bp7p == 5) begin
            if ((DrawX - g7offsetx) <= 54 && (DrawX - g7offsetx) >= 0 && DrawY <= 459 && DrawY >= 240 )
            begin
                bprorom_addr = (DrawX - g7offsetx) + (DrawY - 240) * 55;
                bpro_on = 1;
            end
            else
            begin
                bprorom_addr = 0;
                bpro_on = 0;
            end
        end
        else if (bp8p == 5) begin
            if ((DrawX - h7offsetx) <= 54 && (DrawX - h7offsetx) >= 0 && DrawY <= 459 && DrawY >= 240 )
            begin
                bprorom_addr = (DrawX - h7offsetx) + (DrawY - 240) * 55;
                bpro_on = 1;
            end
            else
            begin
                bprorom_addr = 0;
                bpro_on = 0;
            end
        end
        else begin
            bprorom_addr = 0;
            bpro_on = 0;
        end
    end
    
    
    reg wpro_on;
    always @(*) begin
        if (wp1p == 5) begin
            if ((DrawX - a2offsetx) <= 54 && (DrawX - a2offsetx) >= 0 && (DrawY - a2offsety) <= 219 && (DrawY - a2offsety) >= 0)
            begin
                prorom_addr = (DrawX - a2offsetx) + (DrawY - a2offsety) * 55;
                wpro_on = 1;
            end
            else
            begin
                prorom_addr = 0;
                wpro_on = 0;
            end
        end
        else if (wp2p == 5) begin
            if ((DrawX - b2offsetx) <= 54 && (DrawX - b2offsetx) >= 0 && (DrawY - b2offsety) <= 219 && (DrawY - b2offsety) >= 0)
            begin
                prorom_addr = (DrawX - b2offsetx) + (DrawY - b2offsety) * 55;
                wpro_on = 1;
            end
            else
            begin
                prorom_addr = 0;
                wpro_on = 0;
            end
        end
        else if (wp3p == 5) begin
            if ((DrawX - c2offsetx) <= 54 && (DrawX - c2offsetx) >= 0 && (DrawY - c2offsety) <= 219 && (DrawY - b2offsety) >= 0)
            begin
                prorom_addr = (DrawX - c2offsetx) + (DrawY - c2offsety) * 55;
                wpro_on = 1;
            end
            else
            begin
                prorom_addr = 0;
                wpro_on = 0;
            end
        end
        else if (wp4p == 5) begin
            if ((DrawX - d2offsetx) <= 54 && (DrawX - d2offsetx) >= 0 && (DrawY - d2offsety) <= 219 && (DrawY - d2offsety) >= 0)
            begin
                prorom_addr = (DrawX - d2offsetx) + (DrawY - d2offsety) * 55;
                wpro_on = 1;
            end
            else
            begin
                prorom_addr = 0;
                wpro_on = 0;
            end
        end
        else if (wp5p == 5) begin
            if ((DrawX - e2offsetx) <= 54 && (DrawX - e2offsetx) >= 0 && (DrawY - e2offsety) <= 219 && (DrawY - e2offsety) >= 0)
            begin
                prorom_addr = (DrawX - e2offsetx) + (DrawY - e2offsety) * 55;
                wpro_on = 1;
            end
            else
            begin
                prorom_addr = 0;
                wpro_on = 0;
            end
        end
        else if (wp6p == 5) begin
            if ((DrawX - f2offsetx) <= 54 && (DrawX - f2offsetx) >= 0 && (DrawY - f2offsety) <= 219 && (DrawY - f2offsety) >= 0)
            begin
                prorom_addr = (DrawX - f2offsetx) + (DrawY - f2offsety) * 55;
                wpro_on = 1;
            end
            else
            begin
                prorom_addr = 0;
                wpro_on = 0;
            end
        end
        else if (wp7p == 5) begin
            if ((DrawX - g2offsetx) <= 54 && (DrawX - g2offsetx) >= 0 && (DrawY - g2offsety) <= 219 && (DrawY - g2offsety) >= 0)
            begin
                prorom_addr = (DrawX - g2offsetx) + (DrawY - g2offsety) * 55;
                wpro_on = 1;
            end
            else
            begin
                prorom_addr = 0;
                wpro_on = 0;
            end
        end
        else if (wp8p == 5) begin
            if ((DrawX - h2offsetx) <= 54 && (DrawX - h2offsetx) >= 0 && (DrawY - h2offsety) <= 219 && (DrawY - h2offsety) >= 0)
            begin
                prorom_addr = (DrawX - h2offsetx) + (DrawY - h2offsety) * 55;
                wpro_on = 1;
            end
            else
            begin
                prorom_addr = 0;
                wpro_on = 0;
            end
        end
        else begin
            prorom_addr = 0;
            wpro_on = 0;
        end
    end
    
    always @ (posedge Clk) begin
        if (~blank) begin
            Red <= 4'hf;
            Green <= 4'hf;
            Blue <= 4'hf;
        end
        else begin
            Red <= 0;
            Green <= 0;
            Blue <= 0;
            if (boardon) begin
                Red <= cbR;
                Green <= cbG;
                Blue <= cbB;
            end
            if (p1on && ~disablesig[0]) begin
                if (p1R != 4'hD) begin
                    Red <= p1R;
                    Green <= p1G;
                    Blue <= p1B;
                end
            end
            else if (p2on && ~disablesig[1]) begin
                if (p2R != 4'hD) begin
                    Red <= p2R;
                    Green <= p2G;
                    Blue <= p2B;
                end
            end
            else if (p3on && ~disablesig[2]) begin
                if (p3R != 4'hD) begin
                    Red <= p3R;
                    Green <= p3G;
                    Blue <= p3B;
                end
            end
            else if (p4on && ~disablesig[3]) begin
                if (p4R != 4'hD) begin
                    Red <= p4R;
                    Green <= p4G;
                    Blue <= p4B;
                end
            end
            else if (p5on && ~disablesig[4]) begin
                if (p5R != 4'hD) begin
                    Red <= p5R;
                    Green <= p5G;
                    Blue <= p5B;
                end
            end
            else if (p6on && ~disablesig[5]) begin
                if (p6R != 4'hD) begin
                    Red <= p6R;
                    Green <= p6G;
                    Blue <= p6B;
                end
            end
            else if (p7on && ~disablesig[6]) begin
                if (p7R != 4'hD) begin
                    Red <= p7R;
                    Green <= p7G;
                    Blue <= p7B;
                end
            end
            else if (p8on && ~disablesig[7]) begin
                if (p8R != 4'hD) begin
                    Red <= p8R;
                    Green <= p8G;
                    Blue <= p8B;
                end
            end
            else if (raon && ~disablesig[8]) begin
                if (raR != 4'hD) begin
                    Red <= raR;
                    Green <= raG;
                    Blue <= raB;
                end
            end
            else if (rhon && ~disablesig[9]) begin
                if (rhR != 4'hD) begin
                    Red <= rhR;
                    Green <= rhG;
                    Blue <= rhB;
                end
            end
            else if (keon && ~disablesig[15]) begin
                if (keR != 4'hD) begin
                    Red <= keR;
                    Green <= keG;
                    Blue <= keB;
                end
            end
            else if (qdon && ~disablesig[14]) begin
                if (qdR != 4'hD) begin
                    Red <= qdR;
                    Green <= qdG;
                    Blue <= qdB;
                end
            end
            else if (kbon && ~disablesig[12]) begin
                if (kbR != 4'hD) begin
                    Red <= kbR;
                    Green <= kbG;
                    Blue <= kbB;
                end
            end
            else if (kgon && ~disablesig[13]) begin
                if (kgR != 4'hD) begin
                    Red <= kgR;
                    Green <= kgG;
                    Blue <= kgB;
                end
            end
            else if (bcon && ~disablesig[10]) begin
                if (bcR != 4'hD) begin
                    Red <= bcR;
                    Green <= bcG;
                    Blue <= bcB;
                end
            end
            else if (bfon && ~disablesig[11]) begin
                if (bfR != 4'hD) begin
                    Red <= bfR;
                    Green <= bfG;
                    Blue <= bfB;
                end
            end
            else if (b1on && ~disablesig[16]) begin
                if (b1R != 4'hD) begin
                    Red <= b1R;
                    Green <= b1G;
                    Blue <= b1B;
                end
            end
            else if (b2on && ~disablesig[17]) begin
                if (b2R != 4'hD) begin
                    Red <= b2R;
                    Green <= b2G;
                    Blue <= b2B;
                end
            end
            else if (b3on && ~disablesig[18]) begin
                if (b3R != 4'hD) begin
                    Red <= b3R;
                    Green <= b3G;
                    Blue <= b3B;
                end
            end
            else if (b4on && ~disablesig[19]) begin
                if (b4R != 4'hD) begin
                    Red <= b4R;
                    Green <= b4G;
                    Blue <= b4B;
                end
            end
            else if (b5on && ~disablesig[20]) begin
                if (b5R != 4'hD) begin
                    Red <= b5R;
                    Green <= b5G;
                    Blue <= b5B;
                end
            end
            else if (b6on && ~disablesig[21]) begin
                if (b6R != 4'hD) begin
                    Red <= b6R;
                    Green <= b6G;
                    Blue <= b6B;
                end
            end
            else if (b7on && ~disablesig[22]) begin
                if (b7R != 4'hD) begin
                    Red <= b7R;
                    Green <= b7G;
                    Blue <= b7B;
                end
            end
            else if (b8on && ~disablesig[23]) begin
                if (b8R != 4'hD) begin
                    Red <= b8R;
                    Green <= b8G;
                    Blue <= b8B;
                end
            end
            else if (braon && ~disablesig[24]) begin
                if (braR != 4'hD && braR != 4'h8) begin
                    Red <= braR;
                    Green <= braG;
                    Blue <= braB;
                end
            end
            else if (brhon && ~disablesig[25]) begin
                if (brhR != 4'hD && brhR != 4'h8) begin
                    Red <= brhR;
                    Green <= brhG;
                    Blue <= brhB;
                end
            end
            else if (bkeon && ~disablesig[31]) begin
                if (bkeR != 4'hD) begin
                    Red <= bkeR;
                    Green <= bkeG;
                    Blue <= bkeB;
                end
            end
            else if (bqdon && ~disablesig[30]) begin
                if (bqdR != 4'hD) begin
                    Red <= bqdR;
                    Green <= bqdG;
                    Blue <= bqdB;
                end
            end
            else if (bkbon && ~disablesig[28]) begin
                if (bkbR != 4'hD) begin
                    Red <= bkbR;
                    Green <= bkbG;
                    Blue <= bkbB;
                end
            end
            else if (bkgon && ~disablesig[29]) begin
                if (bkgR != 4'hD) begin
                    Red <= bkgR;
                    Green <= bkgG;
                    Blue <=  bkgB;
                end
            end
            else if (bbcon && ~disablesig[26]) begin
                if (bbcR != 4'hD && bbcR != 4'hA) begin
                    Red <= bbcR;
                    Green <= bbcG;
                    Blue <= bbcB;
                end
            end
            else if (bbfon && ~disablesig[27]) begin
                if (bbfR != 4'hD && bbfR != 4'hA) begin
                    Red <= bbfR;
                    Green <= bbfG;
                    Blue <= bbfB;
                end
            end
            if (wpro_on) begin
                Red <= propalette_red;
                Green <= propalette_green;
                Blue <= propalette_blue;
            end
            else if (bpro_on) begin
                Red <= bpropalette_red;
                Green <= bpropalette_green;
                Blue <= bpropalette_blue;
            end
        end
    end
endmodule
