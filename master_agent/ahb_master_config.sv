`ifndef AHB_MASTER_CONFIG
`define AHB_MASTER_CONFIG

class ahb_master_config extends uvm_object;

    `uvm_object_utils(ahb_master_config)

    function new(string name = "ahb_master_config");
        super.new(name);
    endfunction

endclass : ahb_master_config

`endif