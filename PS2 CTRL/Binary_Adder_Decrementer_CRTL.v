module Binary_Adder_Decrementer_CTRL (BTN0, BTN1, BTN2, BTN3, SWT0, SWT1, BCD, CLK, Count);
  input BTN0, BTN1, BTN2, BTN3, SWT0, SWT1, CLK;
  output [15:0] BCD;
  output [13:0] Count;
 
  reg [13:0] Count;
  reg [26:0] Counter1Hz;
  
  Binary_to_BCD_converter conv1(Count, BCD[15:12], BCD[11:8], BCD[7:4], BCD[3:0]);
  
  always @(posedge CLK)
    begin
		Counter1Hz <= Counter1Hz +1;
      if (BTN3 && (Count >= 9500))
        Count <= 9999;
      else if (BTN3)
        Count <= Count + 500;
      else if (BTN2 && Count >= 9800)
        Count <= 9999;
      else if (BTN2)
        Count <= Count + 200;
      else if (BTN1 && Count >= 9850)
        Count <= 9999;
      else if (BTN1)
        Count <= Count + 150;
      else if (BTN0 && Count >= 9950)
        Count <= 9999;
      else if (BTN0)
        Count <= Count + 50;
      else if (SWT1)
        Count <= 205;
      else if (SWT0)
        Count <= 10; 
      else if (Count != 0 && Counter1Hz == 50000000)
		  begin
			 Count <= Count -1;
			 Counter1Hz <= 0;
		  end
		else
			begin
			end		  
    end   
    
	
endmodule