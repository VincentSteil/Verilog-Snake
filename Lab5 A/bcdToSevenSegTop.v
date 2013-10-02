module bcdToSevenSegTop(data,kclk,Clk,dFourEn,dThreeEn,dTwoEn,dOneEn,C,led);//CA,CB,CC,CD,CE,CF,CG);
  

input Clk;
input data;
input kclk;
output dFourEn;
output dThreeEn;
output dTwoEn;
output dOneEn;
output led;
/*
output CA;
output CB;
output CC;
output CD;
output CE;
output CF;
output CG;
*/
output [6:0] C;
//wire Clk1HZ;
wire ClkF8MS;
wire [15:0] bcdIN;
wire [13:0] numInBinary;
wire [6:0] C2;

wire dFourEn1;
wire dThreeEn1;
wire dTwoEn1;
wire dOneEn1;

wire [15:0] lastSent;


assign C = ~C2;
assign dFourEn = ~dFourEn1;
assign dThreeEn = ~dThreeEn1;
assign dTwoEn = ~dTwoEn1;
assign dOneEn = ~dOneEn1;


niceDivider cd1(Clk,/*Clk1HZ,*/ClkF8MS);
kbctrl kctrl1 (kclk,data,led,lastSent);

bcdToSevenSeg bcd1(lastSent,numInBinary,/*Clk1HZ,*/ClkF8MS,dFourEn1,dThreeEn1,dTwoEn1,dOneEn1,C2);//CA,CB,CC,CD,CE,CF,CG);


endmodule
  
