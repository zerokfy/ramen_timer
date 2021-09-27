interface system_if();
  logic             CLK_50M;
  logic             RST;
endinterface

interface sample_if();
  logic             write;
  logic             valid, ready;
  logic   [7:0]     addr, wdata, rdata;
endinterface

interface timer_if();
  logic   [1:0]     KEY;
  logic   [7:0]     HEX_7SEG  [5:0];
  logic   [9:0]     LEDR;
endinterface

