`ifndef AHB_SLAVE_MON
`define AHB_SLAVE_MON

class ahb_slave_mon extends uvm_monitor;

    `uvm_component_utils(ahb_slave_mon)

    function new(string name = "ahb_slave_mon", uvm_component parent);
        super.new(name, parent);
    endfunction

endclass : ahb_slave_mon

`endif