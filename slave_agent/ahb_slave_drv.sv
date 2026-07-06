`ifndef AHB_SLAVE_DRV
`define AHB_SLAVE_DRV

class ahb_slave_drv extends uvm_driver #(ahb_slave_trans);

    `uvm_component_utils(ahb_slave_drv)

    function new(string name = "ahb_slave_drv", uvm_component parent);
        super.new(name, parent);
    endfunction

endclass : ahb_slave_drv

`endif