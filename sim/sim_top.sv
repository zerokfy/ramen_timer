// C:\intelFPGA_lite\20.1\modelsim_ase\verilog_src\uvm-1.2\src
`include "uvm_pkg.sv"
`include "uvm_macros.svh"



module sim_top;

  import  uvm_pkg::*;
  import  pkg::*;

  bit     clk;


  timer_top dut (
    .*
  );

  initial begin
    uvm_config_db #(virtual )::set(null, "", "", );
    run_test();
  end

  initial forever #20 clk = ~clk;


endmodule
