

module kbctrl(kclk,  data,  led, dataOut);
  input kclk;
  input data;
  output led;
  output [7:0] dataOut;
  
  reg [21:0] shift;

  reg enable;

  reg led;
  reg [3:0] left, right;

 
  wire [3:0] leftmsb, leftlsb;
  wire [7:0] dataOut;

  assign leftmsb[3:0] = left;
  assign leftlsb[3:0] = right;
  assign dataOut = {leftmsb[3:0],leftlsb[3:0]};
  
  initial
    begin
      shift = 22'd0;
      enable = 0;
		left = 0;
		right = 0;
      led = 0;
    end
  
  always @(negedge kclk)
    begin
      shift <= {data, shift[21:1]};
	 
	 
	
	
	 end
	 
	 

	

    
  always @(shift)
    begin
  
    if(shift[8:1] == 8'hF0)
      begin
        enable <= 1;
		  left[3:0] <= shift[19:16];
		  right[3:0] <= shift[15:12];
		  led<=0;
      end
    else
      begin
        enable <= 0;
		  left[3:0] <= 0;
		  right[3:0] <= 0;
		  led<=1;
      end
  end
  



  
endmodule


