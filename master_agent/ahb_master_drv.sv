`ifndef AHB_MASTER_DRV
`define AHB_MASTER_DRV

class ahb_master_drv extends uvm_driver #(ahb_master_trans);

    //Factory registration
    `uvm_component_utils(ahb_master_drv)

    //Required instance of class & interface
    virtual ahb_inf vif;

    function new(string name = "ahb_master_drv", uvm_component parent);
        super.new(name, parent);
    endfunction

endclass : ahb_master_drv

`endif