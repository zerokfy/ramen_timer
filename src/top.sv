module timer_top (
    input   logic             CLK_10M
  , input   logic             RST_EXT_N

  , output  logic   [7:0]     HEX_7SEG  [5:0]
  , output  logic   [9:0]     LEDR
);

  logic               clk_10K;
  logic               locked;
  logic               rst_int;
  logic   [ 7:0]      hex_display   [5:0];
  logic               countup_rdy;
  logic   [13:0]      clk_counter;
  logic   [ 5:0]      carry_in;
  logic   [ 5:0]      carry_out;
  logic               timeup;
  logic   [ 7:0]      counter_1s;
    

  //  60���Ԉȏ㐔�������G���[�Ƃ���LED���_��������
  assign  LEDR[0]   = carry_out[5];
  assign  LEDR[9]   = timeup;
  assign  HEX_7SEG  = hex_display;


  ALTPLL	ALTPLL_inst (
	    .inclk0   ( CLK_10M     )
	  , .c0       ( clk_10K     )
	  , .locked   ( locked      )
	);

  //  reset controll
  assign  rst_int   = ~RST_EXT_N & locked;

  always_ff @(posedge clk_10K)
    if(rst_int)
      clk_counter <=  'd0;
    else if(countup_rdy)
      clk_counter <=  'd0;
    else
      clk_counter <=  clk_counter + 'd1;

  assign  countup_rdy = clk_counter == 'd9999;

  always_ff @(posedge clk_10K)
    if(rst_int)
      counter_1s  <=  'd0;
    else if(countup_rdy)
      counter_1s  <=  counter_1s + 'd1;

  assign  timeup = counter_1s == 'd180;

  //  �b��2���\���ɕϊ�
  assign  carry_in[0] = countup_rdy;
  generate
    genvar i;
    //  59:59:59 �܂ł̃J�E���^�ɂ���
    for(i=0; i<6; i++)  begin : disp_7seg
      if(i%2)
        digit_decoder #(
            .DIGIT_LIMIT    ( 5 )
        ) sec_digit_decoder (
            .clk            ( clk_10K )
          , .rst            ( rst_int )

          , .carry_in_rdy   ( carry_in[i] )
          , .hex_display    ( hex_display[i] )
          , .carry_out_rdy  ( carry_out[i] )
        );
      else
        digit_decoder #(
            .DIGIT_LIMIT    ( 9 )
        ) sec_digit_decoder (
            .clk            ( clk_10K )
          , .rst            ( rst_int )

          , .carry_in_rdy   ( carry_in[i] )
          , .hex_display    ( hex_display[i] )
          , .carry_out_rdy  ( carry_out[i] )
        );
    end
  endgenerate

endmodule

