class timer_test extends uvm_test;

  `uvm_component_utils(timer_test)

  sample_env env;
  timer_seq  seq_hd;
  sample_master_sequencer   seqer_hd;

  virtual system_if         sys_if;
  virtual sample_if         vif;
  virtual timer_if          tif;

  function new (string name="timer_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = sample_env::type_id::create("env", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
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

