`ifndef AHB_MASTER_SEQR
`define AHB_MASTER_SEQR

class ahb_master_seqr extends uvm_sequencer #(ahb_master_trans);

    //Factory registration
    `uvm_component_utils(ahb_master_seqr)

    function new(string name = "ahb_master_seqr", uvm_component parent);
        super.new(name,parent);
    endfunction
    
endclass : ahb_master_seqr

`endif