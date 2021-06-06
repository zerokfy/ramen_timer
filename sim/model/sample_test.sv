class sample_test extends uvm_test;

  `uvm_component_utils(sample_test)

  sample_env env;

  function new (string name="sample_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = sample_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    uvm_report_info("TEST", "Hello World");
  endtask

endclass

