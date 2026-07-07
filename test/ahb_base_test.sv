`ifndef AHB_BASE_TEST
`define AHB_BASE_TEST

class ahb_base_test extends uvm_test;

    `uvm_component_utils(ahb_base_test)

    ahb_master_seqs mseqs_h;

    // Instantiating lower hierarchical components
    ahb_env env_h;

    function new(string name = "ahb_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        mseqs_h = ahb_master_seqs :: type_id :: create("mseqs_h");
        env_h = ahb_env :: type_id :: create("env_h", this);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            mseqs_h.start(env_h.magent_h.mseqr_h);
        phase.drop_objection(this);
    endtask

endclass : ahb_base_test

`endif