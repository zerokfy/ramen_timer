virtual class sample_master_base_seq extends uvm_sequence #(sample_seq_item);

  function new(string name="sample_master_base_seq");
    super.new(name);
    do_not_randomize = 1;
  endfunction

  virtual task pre_body();
    if(starting_phase != null) begin
      `uvm_info(get_type_name(),
                $sformatf("%s pre_body() raising %s objection",
                         get_sequence_path(),
                         starting_phase.get_name()), UVM_MEDIUM);
      starting_phase.raise_objection(this);
    end
  endtask

  virtual task post_body();
    if(starting_phase != null) begin
      `uvm_info(get_type_name(),
                $sformatf("%s post_body() dropping %s objection",
                          get_sequence_path(),
                          starting_phase.get_name()), UVM_MEDIUM);
      starting_phase.drop_objection(this);
    end
  endtask
endclass


class write_seq extends sample_master_base_seq;

  `uvm_object_utils(write_seq)

  function new(string name="write seq");
    super.new(name);
  endfunction

  virtual task body();

    `uvm_create(req)
    req.write <=  1'b1;
    req.addr  <=  8'h10;
    req.wdata <=  8'h55;
    `uvm_send(req)

    `uvm_create(req)
    req.write <=  1'b0;
    req.addr  <=  8'h10;
    `uvm_send(req)

    uvm_report_info("SEQ", $sformatf("read data is %02xh", req.rdata));
    #1000;
  endtask

endclass

