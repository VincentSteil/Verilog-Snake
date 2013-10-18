module Snake_Controller (CLK, data, keyboard_CLK, Hsync, Vsync, R, G, B);
  
  input CLK, keyboard_CLK, data;
  
  output [2:0] R, G;
  output [1:0] B;
  output Hsync, Vsync;
  
  reg CLK25MHz;
  wire [7:0] keycode;
  wire led;
  
  
  wire [9:0] XCoord, YCoord;
  wire [7:0] pixel_out;
  
  

  

         
  
  
  always @ (posedge CLK)
	 begin
		CLK25MHz <= ~CLK25MHz;
    end

  VGA VGA_out1(CLK25MHz, pixel_out, Hsync, Vsync, R, G, B, XCoord, YCoord);
   
  Snake_VGA snakeVGA1(CLK25MHz, keycode, XCoord, YCoord, pixel_out);

  kbctrl kb1(keyboard_CLK,  data,  led, keycode);
  
endmodule