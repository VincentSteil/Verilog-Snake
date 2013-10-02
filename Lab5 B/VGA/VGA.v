module VGA (CLK25MHz, pixel_in, Hsync, Vsync, R, G, B, XCoord, YCoord);
  input CLK25MHz;
  input [7:0] pixel_in;
  
  output [2:0] R, G;
  output [1:0] B;
  output Hsync, Vsync;
  output [10:0] XCoord, YCoord;
  
  reg Hsync, Vsync;
  reg [10:0] HCount, VCount;
  
  initial
    begin
      Hsync <= 1;
      Vsync <= 1;
      HCount <= 0;
      VCount <= 0;
    end
  
  assign XCoord = HCount;
  assign YCoord = VCount;
  assign R = (HCount < 640 && VCount < 480) ? pixel_in[7:5] : 8'b00000000;  
  assign G = (HCount < 640 && VCount < 480) ? pixel_in[4:2] : 8'b00000000; 
  assign B = (HCount < 640 && VCount < 480) ? pixel_in[1:0] : 8'b00000000; 

  always @ (posedge CLK25MHz)
    begin
          if (HCount >= 799)                    // increment and reset HCount and increment VCount
            begin
              HCount <= 0;
              VCount <= VCount + 1;
            end
          else
            HCount <= HCount + 1;
       
          if (HCount < 659 || HCount > 755)     // Hsync control
            Hsync <= 1;
          else
            Hsync <= 0; 
              
          if (VCount < 493 || VCount > 494)     // Vsync control
            Vsync <= 1;
          else
            Vsync <= 0;
        
          if (VCount >= 524)                    // reset VCount
            VCount <= 0;
          else
            begin
            end    
    end
endmodule
  