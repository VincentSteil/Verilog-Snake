module bcdToSevenSeg(bcdIN,numInBinary,/*Clk1HZ,*/ClkF8MS,dFourEn,dThreeEn,dTwoEn,dOneEn, C);//CA,CB,CC,CD,CE,CF,CG);
	input [15:0] bcdIN;
	input [13:0] numInBinary;
	//input Clk1HZ;
	input ClkF8MS;
	output dFourEn;
	output dThreeEn;
	output dTwoEn;
	output dOneEn;
	output [6:0] C;


	wire [6:0] d1;
	wire [6:0] d2;
	wire [6:0] d3;
	wire [6:0] d4; 

//	reg allOnOrOff;
//	reg oneSecCounter;

	reg dFourEn;
	reg dThreeEn;
	reg dTwoEn;
	reg dOneEn;
	reg [6:0] C;

	seven_seg_converter sev_seg_conv1(bcdIN[15:12], d4);
	seven_seg_converter sev_seg_conv2(bcdIN[11:8], d3);
	seven_seg_converter sev_seg_conv3(bcdIN[7:4], d2);
	seven_seg_converter sev_seg_conv4(bcdIN[3:0], d1);

	reg [1:0] sev_seg_ctrl;
	reg [6:0] flash_counter_500ms;
	reg flash_bool_1s;
	reg all_on_or_off;
		
	always@(posedge ClkF8MS)
		begin
			flash_counter_500ms <= flash_counter_500ms +1;
			sev_seg_ctrl <= sev_seg_ctrl +1;
			if (all_on_or_off == 0)
				begin
					dFourEn <= 0;
					dThreeEn <= 0;
					dTwoEn <= 0;
					dOneEn <= 0;
				end
			else
				begin
							if(sev_seg_ctrl == 3)
								begin
									C <= d4;
									dFourEn<=0;
									dThreeEn<=0;
									dTwoEn<=0;
									dOneEn<=0;
								end 
							else if(sev_seg_ctrl == 2)
								begin
									C <= d3;
									dFourEn<=0;
									dThreeEn<=0;
									dTwoEn<=0;
									dOneEn<=0;
								end 
							else if(sev_seg_ctrl == 1)
								begin
							
									C <= d2;
									dFourEn<=0;
									dThreeEn<=1;
									dTwoEn<=0;
									dOneEn<=0;
								end 
							else if(sev_seg_ctrl == 0)
								begin

									C <= d1;
									dFourEn<=1;
									dThreeEn<=0;
									dTwoEn<=0;
									dOneEn<=0;	
								end 
							else
								begin
									dFourEn<=0;
									dThreeEn<=0;
									dTwoEn<=0;
									dOneEn<=0;
								end
				end
			if (flash_counter_500ms == 125)
				begin
					flash_counter_500ms <= 0;
					flash_bool_1s <= ~flash_bool_1s;
					if(numInBinary > 199)
					  begin
						 all_on_or_off <= 1; 
					  end
					else if(numInBinary < 200 && numInBinary != 0 && flash_bool_1s)
					  begin
						 all_on_or_off <= all_on_or_off;
					  end
					else if(numInBinary == 0)
						begin
						  all_on_or_off <= all_on_or_off;
						end
					else
							begin
							end
				end	
		end

	
endmodule 