`timescale  1ns/1ns

// C:\intelFPGA_lite\20.1\modelsim_ase\verilog_src\uvm-1.2\src
`include "uvm_pkg.sv"
`include "uvm_macros.svh"


module sim_top;

  import  uvm_pkg::*;

  `include "model/sample_if.sv"
  `include "model/sample_model.svh"
  `include "model/sample_test.sv"

  logic             CLK_50M;
  logic             RST;
  logic   [1:0]     KEY;
  logic   [7:0]     HEX_7SEG  [5:0];
  logic   [9:0]     LEDR;

  sample_if         vif(CLK_50M, RST);


  initial begin : gen_clk
    CLK_50M <= 1'b1;
    #100;
    forever #20 CLK_50M = ~CLK_50M;
  end

  initial begin
    RST <= 1'b0;
    #80
    RST <= 1'b1;
  end

  initial begin
    uvm_config_db #(virtual sample_if)::set(
        uvm_root::get()
      , "*"
      , "vif"
      , vif);
    run_test();
  end

  //timer_top dut (
  //  .*
  //);

endmodule

