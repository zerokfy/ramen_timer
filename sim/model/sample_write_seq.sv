class write_seq extends sample_base_seq;

  `uvm_object_utils(write_seq);

  function new(string name="write_seq");
    super.new(name);
  endfunction

  virtual task body();
    $display("Hello SEQ");

    `uvm_create(req)

    req.write <= 1'b1;
    req.addr  <= 8'h10;
    req.data  <= 8'h55;

    `uvm_send(req)

    #1000;

  endtask

endclass

