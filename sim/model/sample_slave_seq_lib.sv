virtual class sample_slave_base_seq extends uvm_sequence #(sample_seq_item);

  function new(string name="sample_slave_base_seq");
    super.new(name);
    do_not_randomize = 1;
  endfunction

endclass


class normal_response_seq extends sample_slave_base_seq;

  `uvm_object_utils(normal_response_seq)

  function new(string name="normal_response_seq");
    super.new(name);
  endfunction

  virtual task body();
    forever begin
      `uvm_create(req)
      req.wait_cycle <= 1'b1;
      `uvm_send(req)
      get_response(rsp);
    end
  endtask

endclass

class random_response_seq extends sample_slave_base_seq;

  `uvm_object_utils(random_response_seq)

  function new(string name="random_response_seq");
    super.new(name);
  endfunction

  virtual task body();
    forever begin
      `uvm_create(req)
      req.wait_cycle  <= $urandom_range(8, 0);
      //req.wait_cycle  <= 'h2;
      `uvm_send(req)
      get_response(rsp);
    end
  endtask

endclass

