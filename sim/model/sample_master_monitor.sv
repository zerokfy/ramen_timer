class sample_master_monitor extends uvm_monitor;

  virtual sample_if vif;
  uvm_analysis_port#(sample_scrbd_item) ap_write;
  uvm_analysis_port#(sample_scrbd_item) ap_read;
  event   scrbd_e;

  `uvm_component_utils(sample_master_monitor)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    ap_write = new("ap_write", this);
    ap_read  = new("ap_read",  this);
  endfunction

  function void build_phase(uvm_phase phase);
    bit status;
    super.build_phase(phase);
    status = uvm_config_db#(virtual sample_if)::get(this, "", "vif", vif);
    if(status == 1'b0)
      uvm_report_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction

  task run_phase(uvm_phase phase);
    string s_trans_kind;
    uvm_report_info("MONITOR", "Hi");

    fork scrbd_write; join_none

    forever begin
      @(posedge vif.valid);
      wait(vif.ready === 1'b1);
      -> scrbd_e;

      if(vif.write === 1'b1)
        uvm_report_info("MON", $sformatf("write addr=%02xh wdata=%02xh", vif.addr, vif.wdata));
      else if(vif.write === 1'b0)
        uvm_report_info("MON", $sformatf("read  addr=%02xh rdata=%02xh", vif.addr, vif.rdata));
      else
        uvm_report_info("MON", $sformatf("signal write is unknown..."));
    end
  endtask

  task scrbd_write;
    sample_scrbd_item item;

    forever begin
      @scrbd_e;
      item = new();
      item.addr = vif.addr;

      if(vif.write === 1'b1) begin
        item.data = vif.wdata;
        ap_write.write(item);
      end else if(vif.write === 1'b0) begin
        item.data = vif.rdata;
        ap_read.write(item);
      end
    end
  endtask

endclass

