`ifndef AHB_COVERAGE
`define AHB_COVERAGE

class ahb_coverage extends uvm_subscriber #(ahb_master_trans);

    `uvm_component_utils(ahb_coverage)

    function new(string name = "ahb_coverage", uvm_component parent);
        super.new(name, parent);
    endfunction

endclass : ahb_coverage

`endif