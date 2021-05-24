module timer_top (
    input   logic             CLK_10M
  , input   logic             RST_EXT_N

  , output  logic   [7:0]     HEX_7SEG  [5:0]
  , output  logic   [9:0]     LEDR
);

  logic               clk_10K;
  logic               locked;
  logic   [ 7:0]      hex_display   [5:0];
  logic               rap_around_rdy;
  logic   [ 5:0]      carry_in;
  logic   [ 5:0]      carry_out;
    

  //  60時間以上数えたらエラーとしてLEDを点灯させる
  assign  LEDR[0]   = carry_out[5];
  assign  HEX_7SEG  = hex_display;


  ATLPLL	ATLPLL_inst (
	    .inclk0   ( CLK_10M     )
	  , .c0       ( clk_10K     )
	  , .locked   ( locked      )
	);

  //  reset controll
  assign  rst_int   = ~RST_EXT_N & locked;

  //  0.1ms単位で1sを刻む
  always_ff @(posedge clk_10K)
    if(rst_int)
      clk_counter <=  'd0;
    else if(rap_around)
      clk_counter <=  'd0;
    else
      clk_counter <=  clk_counter + 'd1;

  assign  rap_around_rdy = clk_counter == 'd9999;


  //  秒を2桁表示に変換
  assign  carrry_in[0] = rap_around_rdy;
  generate
    genvar i;
    //  59:59:59 までのカウンタにする
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

