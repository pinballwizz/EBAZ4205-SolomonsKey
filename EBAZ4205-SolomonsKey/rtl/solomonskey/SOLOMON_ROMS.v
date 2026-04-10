//	Copyright (c) 2014,19 MiSTer-X

module MAINROM
(
	input			CL,
	input  [15:0]	AD,
	output  [7:0]	DT,
	output			DV //,

//	input			DLCL,
//	input  [19:0]	DLAD,
//	input	  [7:0]	DLDT,
//	input			DLEN
);
/*
	34000-37FFF   MAINCPU0
	38000-3FFFF   MAINCPU1 (4000h swaped)
	40000-40FFF   MAINCPU2
*/
wire [7:0] dt0, dt1, dt2, dt3;
//DLROM #(14,8) r0( CL, AD[13:0], dt0, DLCL,DLAD,DLDT,DLEN & (DLAD[19:14]==6'b0011_01) ); 6.3
//DLROM #(14,8) r1( CL, AD[13:0], dt1, DLCL,DLAD,DLDT,DLEN & (DLAD[19:14]==6'b0011_11) ); 7.3b
//DLROM #(14,8) r2( CL, AD[13:0], dt2, DLCL,DLAD,DLDT,DLEN & (DLAD[19:14]==6'b0011_10) ); 7.3a
//DLROM #(12,8) r3( CL, AD[11:0], dt3, DLCL,DLAD,DLDT,DLEN & (DLAD[19:12]==8'b0100_0000) ); 8.3

CPUROM_0 r0(
.clk(CL),
.addr(AD[13:0]),
.data(dt0)
);

CPUROM_1 r1( // 7.3b
.clk(CL),
.addr(AD[13:0]),
.data(dt1)
);

CPUROM_2 r2( // 7.3a
.clk(CL),
.addr(AD[13:0]),
.data(dt2)
);

CPUROM_3 r3( // 8.3jk_edit
.clk(CL),
.addr(AD[11:0]),
.data(dt3)
);

wire  dv0 = (AD[15:14]==2'b00); // 6.3 0000 - 3fff
wire  dv4 = (AD[15:14]==2'b01); // 7.3b 4000 - 7fff
wire  dv8 = (AD[15:14]==2'b10); // 7.3a 8000 - bfff
wire  dvF = (AD[15:12]==4'b1111); // 8.3 f000 - ffff

assign DT = dvF ? dt3 :
				dv8 ? dt2 :
				dv4 ? dt1 :
				dv0 ? dt0 : 8'h0;
				
assign DV = dvF|dv8|dv4|dv0;				

endmodule


module FGROM //gfx1
(
	input 			CL,
	input  [15:0] 	AD,
	output  [7:0]	DT //,
	
//	input			DLCL,
//	input  [19:0]	DLAD,
//	input	  [7:0]	DLDT,
//	input			DLEN
);
/*
	10000-17FFF   FGCHIP0
	18000-1FFFF   FGCHIP1
*/
//DLROM #(16,8) r(CL,AD,DT, DLCL,DLAD,DLDT,DLEN & (DLAD[19:16]==4'd1) );

FG_ROM gfx1( 
.clk(CL),
.addr(AD),
.data(DT)
);

endmodule


module BGROM //gfx2
(
	input 			CL,
	input  [15:0] 	AD,
	output  [7:0]	DT //,

//	input			DLCL,
//	input  [19:0]	DLAD,
//	input	  [7:0]	DLDT,
//	input			DLEN
);
/*
	20000-27FFF   BGCHIP0
	28000-2FFFF   BGCHIP1
*/
//DLROM #(16,8) r(CL,AD,DT, DLCL,DLAD,DLDT,DLEN & (DLAD[19:16]==4'd2) );

BG_ROM gfx2( 
.clk(CL),
.addr(AD),
.data(DT)
);


endmodule


module SPROM
(
	input			CL,
	input	 [13:0]	AD,
	output [31:0]	DT //,

//	input			DLCL,
//	input  [19:0]	DLAD,
//	input	  [7:0]	DLDT,
//	input			DLEN
);
/*
	00000-03FFF   SPCHIP0
	04000-07FFF   SPCHIP1
	08000-0BFFF   SPCHIP2
	0C000-0FFFF   SPCHIP3
*/
wire [7:0] dt0,dt1,dt2,dt3;
//DLROM #(14,8) r0( CL, AD, dt0, DLCL,DLAD,DLDT,DLEN & (DLAD[19:14]==6'b0000_00) );
//DLROM #(14,8) r1( CL, AD, dt1, DLCL,DLAD,DLDT,DLEN & (DLAD[19:14]==6'b0000_01) );
//DLROM #(14,8) r2( CL, AD, dt2, DLCL,DLAD,DLDT,DLEN & (DLAD[19:14]==6'b0000_10) );
//DLROM #(14,8) r3( CL, AD, dt3, DLCL,DLAD,DLDT,DLEN & (DLAD[19:14]==6'b0000_11) );

SPRITE_ROM_0 spr0( 
.clk(CL),
.addr(AD),
.data(dt0)
);

SPRITE_ROM_1 spr1( 
.clk(CL),
.addr(AD),
.data(dt1)
);

SPRITE_ROM_2 spr2( 
.clk(CL),
.addr(AD),
.data(dt2)
);

SPRITE_ROM_3 spr3( 
.clk(CL),
.addr(AD),
.data(dt3)
);

assign DT = {dt3,dt2,dt1,dt0};

endmodule


module SNDROM
(
	input			CL,
	input	 [13:0]	AD,
	output  [7:0]	DT //,

//	input			DLCL,
//	input  [19:0]	DLAD,
//	input	  [7:0]	DLDT,
//	input			DLEN
);
// 30000-33FFF   SNDCPU
//DLROM #(14,8) r(CL,AD,DT, DLCL,DLAD,DLDT,DLEN & (DLAD[19:14]==6'b0011_00));

SNDCPU_ROM sndcpu( 
.clk(CL),
.addr(AD[13:0]),
.data(DT)
);

endmodule

/*

module DLROM #(parameter AW,parameter DW)
(
	input							CL0,
	input [(AW-1):0]			AD0,
	output reg [(DW-1):0]	DO0,

	input							CL1,
	input [(AW-1):0]			AD1,
	input	[(DW-1):0]			DI1,
	input							WE1
);

reg [(DW-1):0] core[0:((2**AW)-1)];

always @(posedge CL0) DO0 <= core[AD0];
always @(posedge CL1) if (WE1) core[AD1] <= DI1;

endmodule

*/
