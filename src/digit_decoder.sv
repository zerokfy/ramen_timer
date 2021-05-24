//  carry_in_rdy の次のサイクルで内部カウンタを更新し7segに表示する
module digit_decoder #(
    parameter           DIGIT_LIMIT = 9
) (
    input  logic             clk
  , input  logic             rst

  , input  logic             carry_in_rdy
  , output logic   [7:0]     hex_display
  , output logic             carry_out_rdy
);

  logic   [13:0]      clk_counter;
  logic   [ 3:0]      digit;


  always_ff @(posedge clk_10K)
    if(rst_int)
      digit <=  'd0;
    else if(carry_in_rdy)
      if(carry_out_rdy)
        digit <=  'd0;
      else
        digit <=  digit + 'd1;

  assign  carry_out_rdy  = digit[0] == DIGIT_LIMIT;


  //  7seg表示にデコード
  always_comb
    case(digit)
      'd0       : hex_display[i] = 'b0000_0000;
      'd1       : hex_display[i] = 'b0110_0000;
      'd2       : hex_display[i] = 'b1101_1010;
      'd3       : hex_display[i] = 'b1111_0010;
      'd4       : hex_display[i] = 'b0110_0110;
      'd5       : hex_display[i] = 'b1011_0110;
      'd6       : hex_display[i] = 'b0011_1110;
      'd7       : hex_display[i] = 'b1110_0100;
      'd8       : hex_display[i] = 'b1111_1110;
      'd9       : hex_display[i] = 'b1110_0110;
      'd10      :
      'd11      :
      'd12      :
      'd13      :
      'd14      :
      'd15      : hex_display[i] = 'b1111_1110;
      default   : hex_display[i] = 'b1111_1111;
    endcase
endmodule

