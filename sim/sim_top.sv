`timescale  1ns/1ns

// C:\intelFPGA_lite\20.1\modelsim_ase\verilog_src\uvm-1.2\src
`include "uvm_pkg.sv"
`include "uvm_macros.svh"

`include "model/sample_if.sv"

module sim_top;

  import  uvm_pkg::*;

  `include "model/sample_model.svh"
  `include "model/sample_test.sv"


  system_if         sys_if();
  sample_if         vif();
  timer_if          tif();


  initial begin : gen_clk
    sys_if.CLK_50M <= 1'b1;
    #100;
    forever #20 sys_if.CLK_50M = ~sys_if.CLK_50M;
  end

  initial begin
    sys_if.RST <= 1'b1;
    #80
    sys_if.RST <= 1'b0;
  end

  initial begin
    run_test();
  end

  timer_top dut (
      .CLK_50M    ( sys_if.CLK_50M  )
    , .KEY        ( tif.KEY         )
    , .HEX_7SEG   ( tif.HEX_7SEG    )
    , .LEDR       ( tif.LEDR        )
  );

endmodule

