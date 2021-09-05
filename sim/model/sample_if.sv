interface sample_if(input logic CLK_50M, RST);
  logic             write;
  logic             valid, ready;
  logic   [7:0]     addr, wdata, rdata;
endinterface

