class sample_test extends uvm_test;

  `uvm_component_utils(sample_test)

  tb_env     tb;

  function new (string name="sample_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(uvm_object_wrapper)::set(this,
      "tb.sample_model.master.sequencer.run_phase", "default_sequence",
      write_read_seq::type_id::get());
    uvm_config_db#(uvm_object_wrapper)::set(this,
      "tb.sample_model.slave.sequencer.run_phase", "default_sequence",
      normal_response_seq::type_id::get());
    tb  = tb_env::type_id::create("tb", this);
  endfunction

  task run_phase(uvm_phase phase);
    uvm_report_info("TEST", "Hello World");
    uvm_top.print_topology();
  endtask

endclass


class timer_test extends uvm_test;

  `uvm_component_utils(timer_test)

  sample_env env;
  timer_seq  seq_hd;
  sample_master_sequencer   seqer_hd;

  function new (string name="timer_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = sample_env::type_id::create("env", this);
  endfunction


  task run_phase(uvm_phase phase);

    uvm_report_info("TEST", "Hello World");
    seq_hd    = timer_seq::type_id::create("seq_hd");

    uvm_top.print_topology();

    phase.raise_objection(this);
    seq_hd.start(seqer_hd);
    phase.drop_objection(this);

  endtask

endclass

