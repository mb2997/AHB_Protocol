`ifndef AHB_MASTER_AGENT
`define AHB_MASTER_AGENT

class ahb_master_agent extends uvm_agent;

    `uvm_component_utils(ahb_master_agent)

    // Instantiating lower hierarchical components
    ahb_master_seqr mseqr_h;
    ahb_master_drv mdrv_h;
    ahb_master_mon mmon_h;
    ahb_master_config mconfig_h;

    // Virtual interface instance
    virtual ahb_inf vif;

    function new(string name = "ahb_master_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(ahb_master_config) :: get(this, "", "ahb_master_config", mconfig_h))
            `uvm_fatal(get_type_name(), "Can't able to get ahb_master_config configuration at master agent")
        if(!uvm_config_db #(virtual ahb_inf) :: get(this, "", "ahb_inf", vif))
            `uvm_fatal(get_type_name(), "Can't able to get ahb_inf configuration at master agent")

        
        mmon_h = ahb_master_mon :: type_id :: create("mmon_h", this);

        if(mconfig_h.is_active == UVM_ACTIVE)
        begin
            mseqr_h = ahb_master_seqr :: type_id :: create("mseqr_h", this);
            mdrv_h = ahb_master_drv :: type_id :: create("mdrv_h", this);
        end

        // Passing configurations to driver component
        if(!$value$plusargs("HREADY_MAX_CYCLES=%0d", mdrv_h.hready_max_cycles))
            mdrv_h.hready_max_cycles = mconfig_h.hready_max_cycles;
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mmon_h.vif = vif;

        if(mconfig_h.is_active == UVM_ACTIVE)
        begin
            mdrv_h.vif = vif;
            mdrv_h.seq_item_port.connect(mseqr_h.seq_item_export);
        end
    endfunction

endclass : ahb_master_agent

`endif