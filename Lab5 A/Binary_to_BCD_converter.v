module Binary_to_BCD_converter(binary, Thousands, Hundreds, Tens, Ones);
  input [13:0] binary;
  output [3:0] Thousands, Hundreds, Tens, Ones;
  
  reg [3:0] Thousands, Hundreds, Tens, Ones;
  
  integer i;
  
  always @(binary)
    begin
      Thousands = 4'b0000;
      Hundreds = 4'b0000;
      Tens = 4'b0000;
      Ones = 4'b0000;
      
      for (i = 13; i >= 0; i = i -1)
        begin
          if(Thousands >= 5)
            Thousands = Thousands +3;
          else
            begin
            end
          if(Hundreds >= 5)
            Hundreds = Hundreds +3;
          else
            begin
            end
          if(Tens >= 5)
            Tens = Tens +3;
          else
            begin
            end
          if(Ones >= 5)
            Ones = Ones +3;
          else
            begin
            end
            
          Thousands = Thousands << 1;
          Thousands[0] = Hundreds[3];  
          Hundreds = Hundreds << 1;
          Hundreds[0] = Tens[3];
          Tens = Tens << 1;
          Tens[0] = Ones[3];
          Ones = Ones << 1;
          Ones[0] = binary[i];
        end
    end
    
endmodule