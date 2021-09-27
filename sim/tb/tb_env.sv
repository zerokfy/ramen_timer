class tb_env extends uvm_env;

  sample_env sample_model;

  gp_scoreboard#(sample_scrbd_item) sample_scrbd;
  `uvm_component_utils(tb_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    sample_model = sample_env::type_id::create("sample_model", this);
    sample_scrbd = gp_scoreboard#(sample_scrbd_item)::type_id::create("sample_scrbd", this);

    //sample_master_monitor::type_id::set_type_override(sample_master_chg_monitor::get_type());
    //sample_master_monitor::type_id::set_inst_override(sample_master_chg_monitor::get_type(),
    //  "uvm_test_top.tb.sample_model.master.monitor");
  endfunction

  function void connect_phase(uvm_phase phase);
    sample_model.master.monitor.ap_write.connect(sample_scrbd.ap_exp);
    sample_model.master.monitor.ap_read.connect(sample_scrbd.ap_obs);
  endfunction

  task run_phase(uvm_phase phase);
    uvm_report_info("TB", "Hello TB");
  endtask

endclass

