`ifndef AHB_ENV
`define AHB_ENV

class ahb_env extends uvm_env;

    `uvm_component_utils(ahb_env)

    // Instantiating lower hierarchical components
    ahb_master_agent magent_h;
    ahb_slave_agent sagent_h;

    // Configuration class instance
    ahb_master_config mconfig_h;

    function new (string name = "ahb_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        magent_h = ahb_master_agent :: type_id :: create("magent_h", this);
        sagent_h = ahb_slave_agent :: type_id :: create("sagent_h", this);
        mconfig_h = ahb_master_config :: type_id :: create("mconfig_h");

        // setting config db for master agent configuration
        uvm_config_db #(ahb_master_config) :: set(this, "*magent_h", "ahb_master_config", mconfig_h);
    endfunction

    function void connect_phase (uvm_phase phase);

    endfunction



endclass : ahb_env

`endif