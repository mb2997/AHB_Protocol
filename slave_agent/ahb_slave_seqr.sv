`ifndef AHB_SLAVE_SEQR
`define AHB_SLAVE_SEQR

class ahb_slave_seqr extends uvm_sequencer #(ahb_slave_trans);

    //Factory registration
    `uvm_component_utils(ahb_slave_seqr)

    function new(string name = "ahb_slave_seqr", uvm_component parent);
        super.new(name,parent);
    endfunction

endclass : ahb_slave_seqr

`endif