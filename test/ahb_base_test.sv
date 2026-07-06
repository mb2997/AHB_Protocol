`ifndef AHB_BASE_TEST
`define AHB_BASE_TEST

class ahb_base_test extends uvm_test;

    `uvm_component_utils(ahb_base_test)

    function new(string name = "ahb_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass : ahb_base_test

`endif