`ifndef AHB_TEST_CONFIG
`define AHB_TEST_CONFIG

class ahb_test_config extends uvm_object;

    //Factory registration
    `uvm_object_utils(ahb_test_config)

    function new(string name = "ahb_test_config");
        super.new(name);
    endfunction

endclass : ahb_test_config

`endif