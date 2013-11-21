module Debounce_Single_Pulser (D, SP, CLK);
input CLK, D;
output SP;

reg Q1, Q2, Q3;
reg [16:0] count2ms;

// doesn't actually debounce...

assign SP = ~Q3 && Q2;

always @(posedge CLK)
  begin	 
	 if (count2ms == 100000)
		begin
			count2ms <= 0;
			Q1 <= D;
			Q2 <= Q1;
			Q3 <= Q2;
		end
	 else
		begin
			count2ms <= count2ms+1; 
			Q3 <= Q2;
		end
  end

endmodule
    