module digit_decoder #(
    parameter           DIGIT_LIMIT = 9
) (
    input  logic             clk
  , input  logic             rst

  , input  logic             carry_in_rdy
  , output logic   [7:0]     hex_display
  , output logic             carry_out_rdy
);

  logic   [ 3:0]      digit;


  always_ff @(posedge clk)
    if(rst)
      digit <=  'd0;
    else if(carry_in_rdy)
      if(carry_out_rdy)
        digit <=  'd0;
      else
        digit <=  digit + 'd1;

  assign  carry_out_rdy  = digit == DIGIT_LIMIT;


  always_comb
    case(digit)
      'h0       : hex_display = 'b1111_1100;
      'h1       : hex_display = 'b0110_0000;
      'h2       : hex_display = 'b1101_1010;
      'h3       : hex_display = 'b1111_0010;
      'h4       : hex_display = 'b0110_0110;
      'h5       : hex_display = 'b1011_0110;
      'h6       : hex_display = 'b0011_1110;
      'h7       : hex_display = 'b1110_0100;
      'h8       : hex_display = 'b1111_1110;
      'h9       : hex_display = 'b1110_0110;
      'hA       : hex_display = 'b1110_1110;
      'hB       : hex_display = 'b0011_1110;
      'hC       : hex_display = 'b1001_1100;
      'hD       : hex_display = 'b0111_1010;
      'hE       : hex_display = 'b1001_1110;
      'hF       : hex_display = 'b1111_1110;
      default   : hex_display = 'b1111_1111;
    endcase
endmodule

