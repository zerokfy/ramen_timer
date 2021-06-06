`timescale  1ns/1ns

// C:\intelFPGA_lite\20.1\modelsim_ase\verilog_src\uvm-1.2\src
`include "uvm_pkg.sv"
`include "uvm_macros.svh"


module sim_top;

  import  uvm_pkg::*;

  `include "sample_model.svh"
  `include "sample_test.sv"

  logic             CLK_50M;
  logic   [1:0]     KEY;
  logic   [7:0]     HEX_7SEG  [5:0];
  logic   [9:0]     LEDR;


  timer_top dut (
    .*
  );

  initial begin
    run_test();
  end

  initial begin : gen_clk
    forever #20 CLK_50M = ~CLK_50M;
  end


endmodule

