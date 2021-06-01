module timer_top (
    input   logic             CLK_50M
  , input   logic   [1:0]     KEY

  , output  logic   [7:0]     HEX_7SEG  [5:0]
  , output  logic   [9:0]     LEDR
);

  logic               clk_10K;
  logic               rst_ext_n;
  logic               locked;
  logic               pon_rst;
  logic   [ 7:0]      hex_display   [5:0];
  logic               countup_rdy;
  logic   [13:0]      clk_counter;
  logic   [ 5:0]      carry_in;
  logic   [ 5:0]      carry_out;
  logic               timeup;
  logic   [ 7:0]      counter_1s;
    

  assign  LEDR[0]   = carry_out[5];
  assign  LEDR[8:1] = 'h0;
  assign  LEDR[9]   = timeup;
  assign  HEX_7SEG  = hex_display;


  ATLPLL	ALTPLL_inst (
	    .inclk0   ( CLK_50M     )
	  , .c0       ( clk_10K     )
	  , .locked   ( locked      )
	);

  //  reset controll
  assign  pon_rst   = ~locked;

  always_ff @(posedge clk_10K)
    if(pon_rst)
      clk_counter <=  'd0;
    else if(countup_rdy)
      clk_counter <=  'd0;
    else
      clk_counter <=  clk_counter + 'd1;

  assign  countup_rdy = clk_counter == 'd9999;

  always_ff @(posedge clk_10K)
    if(pon_rst)
      counter_1s  <=  'd0;
    else if(countup_rdy)
      counter_1s  <=  counter_1s + 'd1;

  assign  timeup = counter_1s == 'd180;

  assign  carry_in[0] = countup_rdy;
  generate
    genvar i;
    //  until 59:59:59
    for(i=0; i<6; i++)  begin : disp_7seg
      if(i%2)
        digit_decoder #(
            .DIGIT_LIMIT    ( 5 )
        ) u_digit_decoder (
            .clk            ( clk_10K )
          , .rst            ( pon_rst )

          , .carry_in_rdy   ( carry_in[i] )
          , .hex_display    ( hex_display[i] )
          , .carry_out_rdy  ( carry_out[i] )
        );
      else
        digit_decoder #(
            .DIGIT_LIMIT    ( 9 )
        ) u_digit_decoder (
            .clk            ( clk_10K )
          , .rst            ( pon_rst )

          , .carry_in_rdy   ( carry_in[i] )
          , .hex_display    ( hex_display[i] )
          , .carry_out_rdy  ( carry_out[i] )
        );
    end
  endgenerate

endmodule

