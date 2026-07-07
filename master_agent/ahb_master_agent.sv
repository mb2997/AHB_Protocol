`ifndef AHB_MASTER_AGENT
`define AHB_MASTER_AGENT

class ahb_master_agent extends uvm_agent;

    `uvm_component_utils(ahb_master_agent)

    // Instantiating lower hierarchical components
    ahb_master_seqr mseqr_h;
    ahb_master_drv mdrv_h;
    ahb_master_mon mmon_h;

    function new(string name = "ahb_master_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        mseqr_h = ahb_master_seqr :: type_id :: create("mseqr_h", this);
        mdrv_h = ahb_master_drv :: type_id :: create("mdrv_h", this);
        mmon_h = ahb_master_mon :: type_id :: create("mmon_h", this);
    endfunction

endclass : ahb_master_agent

`endif