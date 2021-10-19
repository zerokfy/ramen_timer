module timer_top (
    input   logic             CLK_50M
  , input   logic   [1:0]     KEY

  , output  logic   [7:0]     HEX_7SEG  [5:0]
  , output  logic   [9:0]     LEDR
);

  parameter   CLK_FREQ_KHZ      = 50 * 1000;
  parameter   TIME_LIMIT_S      = 150;

  //  zero-origin
  localparam  SEC_COUNTER_LIMIT = CLK_FREQ_KHZ * 1000 - 1;

  logic               locked;
  logic               pon_rst;
  logic   [ 7:0]      hex_display   [5:0];
  logic               countup_rdy;
  logic   [ 5:0]      carry_in;
  logic   [ 5:0]      carry_out;
  logic               before_1s;
  logic               timeup;

  logic   [ $clog2(TIME_LIMIT_S)-1:0]       time_lim_cnt;
  logic   [ $clog2(SEC_COUNTER_LIMIT)-1:0]  counter_1s;
    

  assign  LEDR[0]   = carry_out[5];
  assign  LEDR[8:1] = 'h0;
  assign  LEDR[9]   = timeup;
  assign  HEX_7SEG  = hex_display;


  //  future use
  ATLPLL ALTPLL_inst (
      .inclk0   ( CLK_50M     )
    , .c0       (             )
    , .locked   ( locked      )
  );

  //  reset controll
  assign  pon_rst   = ~locked;

  //  0s to 1s counter each 20ns
  always_ff @(posedge CLK_50M)
    if(pon_rst)
      counter_1s  <=  'd0;
    else if(before_1s)
      counter_1s  <=  'd0;
    else
      counter_1s  <=  counter_1s + 'd1;

  assign  before_1s = counter_1s == SEC_COUNTER_LIMIT;

  //  measure time_lim_cnt
  always_ff @(posedge CLK_50M)
    if(pon_rst)
      time_lim_cnt  <=  'b0;
    else if(time_lim_cnt == TIME_LIMIT_S)
      time_lim_cnt  <=  time_lim_cnt;
    else if(before_1s)
      time_lim_cnt  <=  time_lim_cnt + 'b1;

  assign  timeup  = time_lim_cnt == TIME_LIMIT_S;


  //  7-segment decorder
  assign  carry_in[0] = 'b1;
  generate
    genvar i;
    //  until 59:59:59
    for(i=0; i<6; i++)  begin : disp_7seg
      if(i%2)
        digit_decoder #(
            .DIGIT_LIMIT    ( 5 )
        ) u_digit_decoder (
            .clk            ( CLK_50M )
          , .rst            ( pon_rst )

          , .countup_rdy    ( before_1s   )
          , .carry_in_rdy   ( carry_in[i] )
          , .carry_out_rdy  ( carry_out[i] )
          , .hex_display    ( hex_display[i] )
        );
      else
        digit_decoder #(
            .DIGIT_LIMIT    ( 9 )
        ) u_digit_decoder (
            .clk            ( CLK_50M )
          , .rst            ( pon_rst )

          , .countup_rdy    ( before_1s   )
          , .carry_in_rdy   ( carry_in[i] )
          , .carry_out_rdy  ( carry_out[i] )
          , .hex_display    ( hex_display[i] )
        );
    end
  endgenerate

endmodule

