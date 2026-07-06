`ifndef AHB_MASTER_SEQS
`define AHB_MASTER_SEQS

class ahb_master_seqs extends uvm_sequence #(ahb_master_trans);

    `uvm_object_utils(ahb_master_seqs)

    function new(string name = "ahb_master_seqs");
        super.new(name);
    endfunction

endclass : ahb_master_seqs

`endif