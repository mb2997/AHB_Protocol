`ifndef AHB_MASTER_MON
`define AHB_MASTER_MON

class ahb_master_mon extends uvm_monitor;

    //Factory registration
    `uvm_component_utils(ahb_master_mon)

    function new(string name = "ahb_master_mon", uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass : ahb_master_mon

`endif