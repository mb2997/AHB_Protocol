`ifndef AHB_SLAVE_SEQS
`define AHB_SLAVE_SEQS

class ahb_slave_seqs extends uvm_sequence #(ahb_slave_trans);

    `uvm_object_utils(ahb_slave_seqs)

    function new(string name = "ahb_slave_seqs");
        super.new(name);
    endfunction

endclass : ahb_slave_seqs

`endif