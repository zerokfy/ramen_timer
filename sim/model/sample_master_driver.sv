class sample_master_driver extends uvm_driver #(sample_seq_item);

  virtual system_if   sys_if;
  virtual timer_if    tif;

  `uvm_component_utils(sample_master_driver)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    bit status;
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    uvm_report_info("DRIVER", "Hi");
    vif.valid   <= 1'b0;
    @(negedge sys_if.RST);

    forever begin
      seq_item_port.get_next_item(req);
      @(posedge sys_if.CLK_50M);
      vif.valid   <= 1'b1;
      vif.write   <= req.write;
      vif.addr    <= req.addr;

      if(req.write == 1'b1)
        vif.wdata   <= req.wdata;

      @(posedge vif.ready);

      if(req.write == 1'b0)
        req.rdata   <= vif.rdata;

      @(posedge sys_if.CLK_50M);

      vif.valid   <=  1'b0;
      seq_item_port.item_done(req);
    end

  endtask

endclass

