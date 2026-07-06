`ifndef AHB_SLAVE_AGENT
`define AHB_SLAVE_AGENT

class ahb_slave_agent extends uvm_agent;

    `uvm_component_utils(ahb_slave_agent)

    function new(string name = "ahb_slave_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

endclass : ahb_slave_agent

`endif