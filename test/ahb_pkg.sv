`include "../env/ahb_inf.sv"

package ahb_pkg;

    int no_of_trans = 3;

    `include "../top/ahb_defs.sv"

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "../master_agent/ahb_master_config.sv"
    `include "../slave_agent/ahb_slave_config.sv"
    `include "../env/ahb_env_config.sv"
    `include "ahb_test_config.sv"

    `include "../master_agent/ahb_master_trans.sv"
    `include "../slave_agent/ahb_slave_trans.sv"
    
    `include "../master_agent/ahb_master_seqs.sv"
    `include "../slave_agent/ahb_slave_seqs.sv"

    `include "../master_agent/ahb_master_seqr.sv"
    `include "../slave_agent/ahb_slave_seqr.sv"

    `include "../master_agent/ahb_master_drv.sv"
    `include "../slave_agent/ahb_slave_drv.sv"
    
    `include "../master_agent/ahb_master_mon.sv"
    `include "../slave_agent/ahb_slave_mon.sv"
    
    `include "../master_agent/ahb_master_agent.sv"
    `include "../slave_agent/ahb_slave_agent.sv"
    
    `include "../env/ahb_coverage.sv"
    `include "../env/ahb_sb.sv"
    `include "../env/ahb_env.sv"
    
    `include "ahb_base_test.sv"
    
endpackage : ahb_pkg