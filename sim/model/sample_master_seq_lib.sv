virtual class sample_master_base_seq extends uvm_sequence #(sample_seq_item);

  function new(string name="sample_master_base_seq");
    super.new(name);
    do_not_randomize = 1;
  endfunction

  virtual task pre_body();

    uvm_phase starting_phase = get_starting_phase();

    uvm_report_info("SEQ_LIB", "PreBody Start");

    if(starting_phase != null) begin
      `uvm_info(get_type_name(),
                $sformatf("%s pre_body() raising %s objection",
                         get_sequence_path(),
                         starting_phase.get_name()), UVM_MEDIUM);

      starting_phase.raise_objection(this, get_type_name());
    end
  endtask

  virtual task post_body();

    uvm_phase starting_phase = get_starting_phase();

    uvm_report_info("SEQ_LIB", "PostBody Start");
    if(starting_phase != null) begin
      `uvm_info(get_type_name(),
                $sformatf("%s post_body() dropping %s objection",
                          get_sequence_path(),
                          starting_phase.get_name()), UVM_MEDIUM);
      starting_phase.drop_objection(this, get_type_name());
    end
  endtask
endclass


class write_seq extends sample_master_base_seq;

  `uvm_object_utils(write_seq)

  function new(string name="write seq");
    super.new(name);
  endfunction

  virtual task body();

    uvm_report_info("SEQ_LIB", "Body Start");

    `uvm_create(req)
    uvm_report_info("SEQ_LIB", "Created REQ");
    req.write <=  1'b1;
    req.addr  <=  8'h10;
    req.wdata <=  8'h55;
    #1;
    uvm_report_info("SEQ_LIB", "Send Data");
    `uvm_send(req)

    #100;

    `uvm_create(req)
    uvm_report_info("SEQ_LIB", "Created REQ");
    req.write <=  1'b0;
    req.addr  <=  8'h10;
    `uvm_send(req)

    uvm_report_info("SEQ", $sformatf("read data is %02xh", req.rdata));
    #100;
  endtask

endclass

