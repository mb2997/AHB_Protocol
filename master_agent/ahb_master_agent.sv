`ifndef AHB_MASTER_AGENT
`define AHB_MASTER_AGENT

class ahb_master_agent extends uvm_agent;

    `uvm_component_utils(ahb_master_agent)

    function new(string name = "ahb_master_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

endclass : ahb_master_agent

`endif