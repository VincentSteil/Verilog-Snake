module niceDivider(clk50Mhz,/* slowClk,*/kindaSlowClk);
  input clk50Mhz; 	//fast clock
//  output slowClk; 	//slow clock
  output kindaSlowClk;

  //reg[26:0] counter;
  reg[26:0] counter1;
  //reg slowClk;
  reg kindaSlowClk;
  

  
  always @ (posedge clk50Mhz)
  begin
  /*
   	counter <= counter + 1;		//increment the counter every 20ns (1/50 Mhz) cycle.
   	if(counter == 25000000)   // number here * 20ns * 2 = period
   	  begin
   	    counter <= 0;
   	    //slowClk <= ~slowClk;
 	    end
 	  else
 	    counter <= counter + 1;
*/	
	if(counter1 == 100000)   // number here * 20ns * 2 = period
   	 begin
   	    counter1 <= 0;
   	    kindaSlowClk <= ~kindaSlowClk;
 	    end
 	else
 	    counter1 <= counter1 + 1;
  end
  
endmodule