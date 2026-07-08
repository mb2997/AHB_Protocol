`ifndef AHB_SB
`define AHB_SB

class ahb_sb extends uvm_scoreboard;

    `uvm_component_utils(ahb_sb)

    function new(string name = "ahb_sb", uvm_component parent);
        super.new(name, parent);
    endfunction

endclass : ahb_sb

`endif