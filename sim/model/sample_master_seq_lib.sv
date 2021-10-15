virtual class sample_master_base_seq extends uvm_sequence #(sample_seq_item);

  function new(string name="sample_master_base_seq");
    super.new(name);
    do_not_randomize = 1;
  endfunction

  virtual task pre_body();
    uvm_report_info("SEQ_LIB", "PreBody Start");
  endtask

  virtual task post_body();
    uvm_report_info("SEQ_LIB", "PostBody Start");
  endtask
endclass


class write_seq extends sample_master_base_seq;

  bit   [7:0]   addr, data;

  `uvm_object_utils(write_seq)

  function new(string name="write seq");
    super.new(name);
  endfunction

  virtual task body();

    uvm_report_info("SEQ_LIB", "Body Start");

    `uvm_create(req)
    req.write <=  1'b1;
    req.addr  <=  addr;
    req.wdata <=  data;
    `uvm_send(req)
  endtask

endclass

class read_seq extends sample_master_base_seq;

  bit   [7:0]   addr, rdata;

  `uvm_object_utils(read_seq)

  function new(string name="read_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_create(req)
    req.write = 1'b0;
    req.addr  = addr;
    `uvm_send(req)

    this.rdata = req.rdata;
  endtask

endclass

class write_read_seq extends sample_master_base_seq;

  write_seq   _write;
  read_seq    _read;

  `uvm_object_utils(write_read_seq)

  function new(string name="write_read_seq");
    super.new(name);
  endfunction

  virtual task body();
    bit [7:0]   addr, data;

    addr = 8'h10;
    data = 8'h5A;

    `uvm_create(_write)
    _write.addr = addr;
    _write.data = data;
    `uvm_send(_write)

    `uvm_create(_read)
    _read.addr  = addr;
    `uvm_send(_read)
  endtask

endclass

class timer_seq extends sample_master_base_seq;

  virtual system_if   sys_if;
  virtual timer_if    tif;

  `uvm_object_utils(timer_seq)

  function new(string name="timer_seq");
    super.new(name);
  endfunction

  virtual task body();
    repeat(2)
      @(posedge sys_if.CLK_50M);
    tif.KEY <= 'h1;

    repeat(10)
      @(posedge sys_if.CLK_50M);
  endtask

endclass
