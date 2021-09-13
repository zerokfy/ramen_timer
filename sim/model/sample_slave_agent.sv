class sample_slave_agent extends uvm_agent;

  `uvm_component_utils(sample_slave_agent)

  sample_slave_driver       driver;
  //sample_slave_monitor      monitor;
  sample_slave_sequencer    sequencer;

  uvm_active_passive_enum is_active = UVM_ACTIVE;

  virtual function uvm_active_passive_enum get_is_active();
    return is_active;
  endfunction

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver      = sample_slave_driver::type_id::create("driver", this);
    //monitor     = sample_slave_monitor::type_id::create("monitor", this);
    sequencer   = sample_slave_sequencer::type_id::create("sequencer", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction

  task run_phase(uvm_phase phase);
    uvm_report_info("AGENT", "Hi");
  endtask

endclass

