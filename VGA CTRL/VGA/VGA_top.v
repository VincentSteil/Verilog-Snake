module VGA_top (CLK, SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, Hsync, Vsync, R, G, B);
  
  input CLK, SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7;
  
  output [2:0] R, G;
  output [1:0] B;
  output Hsync, Vsync;
  
  reg [7:0] pixel_in;
  reg CLK25MHz;
  
  wire [10:0] XCoord, YCoord;
  
  initial
    begin
      pixel_in = 8'b00000000;   //Black   
      CLK25MHz = 0;
    end 
         
  
  
  always @ (posedge CLK) begin
    CLK25MHz <= ~CLK25MHz;
  end
  
  always @ (SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7)
    begin
                                    // 8 bit colours 3 bit red : 3 bit green : 2 bit blue
      if(SW0)
        pixel_in <= 8'b00000000;    //Black   
      else if (SW1)
        pixel_in <= 8'b00000011;   //Blue    
      else if (SW2)
        pixel_in <= 8'b00011100;   //Green   
      else if (SW3)
        pixel_in <= 8'b10011111;   //Cyan    
      else if (SW4)
        pixel_in <= 8'b11100000;   //Red     
      else if (SW5) 
        pixel_in <= 8'b10100011;   //Magenta 0x8B008B
      else if (SW6)
        pixel_in <= 8'b11111100;   //Yellow  0xFFFF00
      else if (SW7)
        pixel_in <= 8'b11111111;   //White   0xFFFFFF
      else
        pixel_in <= 8'b00000000;   //Black   0x000000
    end
    
    
    VGA VGA_out1(CLK25MHz, pixel_in, Hsync, Vsync, R, G, B, XCoord, YCoord);
    
  endmodule