class sample_slave_driver extends uvm_driver #(sample_seq_item);

  virtual sample_if   vif;

  logic [7:0]   memory[bit [7:0]];


  `uvm_component_utils(sample_slave_driver)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    bit status;
    super.build_phase(phase);
    status = uvm_config_db#(virtual sample_if)::get(this, "", "vif", vif);
    if(status == 1'b0)
      uvm_report_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction

  task run_phase(uvm_phase phase);

    logic [7:0]   rdata;
    uvm_report_info("DRIVER", "Hi");
    vif.valid   <= 1'b0;
    @(posedge vif.RST);

    forever begin
      seq_item_port.get_next_item(req);
      @(posedge vif.CLK_50M);
      repeat(req.wait_cycle) @(posedge vif.CLK_50M);
      vif.ready   <= 1'b1;

      if(vif.write === 1'b1) begin
        mem_write(vif.addr, vif.wdata);
      end else if(vif.write === 1'b0) begin
        vif.rdata <= mem_read(vif.addr);
      end

      @(posedge vif.CLK_50M)
      vif.ready   <= 1'b0;
      seq_item_port.item_done(req);
    end
  endtask

  function void mem_write(bit [7:0] addr, logic [7:0] data);
    memory[addr] = data;
  endfunction

  function logic [7:0] mem_read(bit [7:0] addr);
    if(memory.exists(addr)) begin
      return memory[addr];
    end else
      return 8'hXX;
  endfunction

endclass

