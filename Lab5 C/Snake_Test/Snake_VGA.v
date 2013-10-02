module Snake_VGA (CLK25MHz, keycode, XCoord, YCoord, pixel_out);
  input CLK25MHz; 
  input [9:0] XCoord, YCoord;
  input [7:0] keycode;
  
  output [7:0] pixel_out;
  
  // use the keyboard marked with Tommy<3Shirley in the lab
  
  reg [7:0] pixel_out;
  reg [9:0] snake_left_column, snake_right_column, snake_top_row, snake_bottom_row;    // refers to the coordinate in the middle of the snake
  reg [2:0] snake_movement_direction;       // 0 == right 1 == left, 2 == up, 3 == down, 4 == reset, 5 == game lost
  reg [18:0] Counter_50Hz;
  reg ESC;
  reg pause;
  reg [7:0] keycode_buffer;
  reg newKeycode;
  
  always @ (posedge CLK25MHz)
    begin
	 
      if(Counter_50Hz == 500000)
        Counter_50Hz <= 0;
      else
        Counter_50Hz <= Counter_50Hz + 1;  
      
		if (keycode != keycode_buffer)
			begin
				keycode_buffer <= keycode;
				newKeycode <= 1;
			end
		else
			newKeycode <= 0;
			

		if(newKeycode)
			begin
				if(keycode == 8'h76)               // ESC
				  ESC <= 1;
				else if (keycode == 8'h1B)         // restart game == S
				  begin
					 ESC <= 0;
					 pause <= 0;
					 snake_movement_direction <= 4;
				  end
				else if (keycode == 8'h4D)         // pause == P
				  pause <= 1;
				else if (keycode == 8'h2D)         // resume == R
				  pause <= 0;
				else
					begin
					end
				 
				if(pause == 0)
					begin
						if (keycode == 8'h75)        // UP Arrow
						  begin
							 case (snake_movement_direction)
								1:                             // left
								  begin						 
									 if(snake_top_row <= 29)
										begin
										  snake_top_row <= 0;
										  snake_right_column <= snake_left_column + 9;
										  snake_movement_direction <= 5;
										end
									 else
										begin
										  snake_top_row <= snake_bottom_row -39;
										  snake_right_column <= snake_left_column + 9;
										  snake_movement_direction <= 2;
										end                
								  end  
								0:                              // right
								  begin
									 
									 if(snake_top_row <= 29)
										begin
										  snake_top_row <= 0;
										  snake_left_column <= snake_right_column - 9;
										  snake_movement_direction <= 5;
										end
									 else
										begin
										  snake_top_row <= snake_bottom_row -39;
										  snake_left_column <= snake_right_column - 9;
										  snake_movement_direction <= 2;
										end                
								  end
								default:
								  begin
								  end
							 endcase
						  end
						else if (keycode == 8'h72)        // DOWN Arrow
						  begin
							 case (snake_movement_direction)
								1:                          // left
								  begin
																			 
									 if(snake_bottom_row >= 449)
										begin
										  snake_bottom_row <= 479;
										  snake_right_column <= snake_left_column + 9;
										  snake_movement_direction <= 5;
										end
									 else
										begin
										  snake_bottom_row <= snake_top_row + 39;
										  snake_right_column <= snake_left_column + 9;
										  snake_movement_direction <= 3;
										end
								  end
								0:                           // right
								  begin
																	  
									 if(snake_bottom_row >= 449)
										begin
										  snake_bottom_row <= 479;
										  snake_left_column <= snake_right_column - 9;
										  snake_movement_direction <= 5;
										end
									 else
										begin
										  snake_bottom_row <= snake_top_row + 39;
										  snake_left_column <= snake_right_column -9;
										  snake_movement_direction <= 3;	
										end
								  end
								default:
								  begin
								  end
							 endcase       
						  end
						else if(keycode == 8'h6B)         // LEFT Arrow
						  begin
							 case (snake_movement_direction)
								2:                          // up
								  begin
									 
									 if(snake_left_column <= 29)
										begin
										  snake_left_column <= 0;
										  snake_bottom_row <= snake_top_row + 9;
										  snake_movement_direction <= 5;
										end
									 else
										begin
										  snake_left_column <= snake_right_column - 39;
										  snake_bottom_row <= snake_top_row + 9;
										  snake_movement_direction <= 1;
										end
								  end
								3:                          // down
								  begin
									 
									 if(snake_left_column <= 29)
										begin
										  snake_left_column <= 0;
										  snake_top_row <= snake_bottom_row - 9;
										  snake_movement_direction <= 5;
										end
									 else
										begin
										  snake_left_column <= snake_right_column - 39;
										  snake_top_row <= snake_bottom_row - 9;
										  snake_movement_direction <= 1;
										end
								  end
								default
									begin
									end
							 endcase
						  end
						else if(keycode == 8'h74)           // RIGHT Arrow
						  begin
							 case (snake_movement_direction)
								2:                            // up
								  begin
									 
									 if(snake_right_column >= 611)
										begin
										  snake_right_column <= 640;
										  snake_bottom_row <= snake_top_row + 9;
										  snake_movement_direction <= 5;
										end
									 else
										begin
										  snake_right_column <= snake_left_column + 39;
										  snake_bottom_row <= snake_top_row + 9;
										  snake_movement_direction <= 0;
										end
								  end
								3:                            // down
									begin
									 if(snake_right_column >= 611)
										begin
										  snake_right_column <= 640;
										  snake_top_row <= snake_bottom_row - 9;
										  snake_movement_direction <= 5;
										end
									 else
										begin
										  snake_right_column <= snake_left_column + 39;
										  snake_top_row <= snake_bottom_row - 9;
										  snake_movement_direction <= 0;
										end
								  end
								default:
								  begin
								  end
							 endcase
						 end
					  else
						 begin
						 end
					end
				end
		 else
			begin
			end

		
      if (ESC == 0)
        begin
		  
         if(XCoord <= snake_right_column && XCoord >= snake_left_column && YCoord >= snake_top_row && YCoord <= snake_bottom_row)
            pixel_out <= 8'b00000011;    // blue
         else
            pixel_out <= 8'b11111111;    // white
          
          if(Counter_50Hz == 500000 && pause == 0 && snake_movement_direction != 5)
            begin
              case (snake_movement_direction)
				    0:        // right
                  begin
                    if(snake_right_column >= 640)
                      begin
								 snake_right_column <= 639;
								 snake_left_column <= 600;
                         snake_movement_direction <= 5;
                      end
                    else
                      begin
                        snake_right_column <= snake_right_column + 1;
                        snake_left_column <= snake_right_column - 40;
                      end
                  end  
                1:        // left
                  begin
                    if (snake_left_column >= 640)
                      begin
								 snake_left_column <= 0;
								 snake_right_column <= 39;
                         snake_movement_direction <= 5;
                      end
                    else
                      begin
                        snake_left_column <= snake_left_column - 1;
                        snake_right_column <= snake_left_column + 40;
                      end
                  end						
               2:        // up
                  begin
                    if(snake_top_row >= 480)
                      begin
								snake_top_row <= 0;
								snake_bottom_row <= 39;
                        snake_movement_direction <= 5;
                      end
                    else
                      begin
                        snake_top_row <= snake_top_row - 1;
                        snake_bottom_row <= snake_top_row + 40;
                      end
                  end
                3:        // down
                  begin
                    if (snake_bottom_row >= 480)
                      begin
								 snake_bottom_row <= 479; 
								 snake_top_row <= 440;
                         snake_movement_direction <= 5;
                      end
                    else
                      begin
                        snake_top_row <= snake_top_row + 1;
                        snake_bottom_row <= snake_top_row + 40;
                      end           
                  end
					 4:
                  begin
                    snake_top_row <= 0;
                    snake_bottom_row <= 9;
                    snake_left_column <= 0;
                    snake_right_column <= 39;
						  snake_movement_direction <= 0;
                  end            
                default:
                  begin
                    snake_top_row <= 0;
                    snake_bottom_row <= 9;
                    snake_left_column <= 0;
                    snake_right_column <= 39;
						  snake_movement_direction <= 0;
                  end
              endcase
            end
          else
            begin
            end
        end
      else if (ESC == 1)
        pixel_out <= 8'b00000000;
    end
    
 
endmodule  
  
