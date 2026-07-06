`include "../env/ahb_inf.sv"

package ahb_pkg;

    int no_of_trans = 10;

    `include "../top/ahb_defs.sv"

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    typedef class ahb_env_config;

    `include "../master_agent/ahb_master_config.sv"
    `include "../slave_agent/ahb_slave_config.sv"
    `include "ahb_test_config.sv"
    `include "../env/ahb_env_config.sv"

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
    
    function void get_vif_in_pkg();
        if(!uvm_config_db #(virtual ahb_inf) :: get(null," ","ahb_inf",vif))
            `uvm_fatal("ahb_PKG :",$sformatf("Can't able to get ahb_inf... Have you set it ??"))
    endfunction : get_vif_in_pkg

    task wait_for_pready();
        wait(vif.PREADY == 1);
    endtask

    task wait_for_posedge_clock(int no_of_clocks = 1);
        repeat(no_of_clocks)
            @(posedge vif.PCLK);
    endtask : wait_for_posedge_clock

    task wait_for_reset(int max_wait_clocks = 10);
        fork
            begin : reset_wait
                wait(vif.PRESETn == 1'b1);
            end
            begin : reset_timeout
                repeat(max_wait_clocks)
                    @(vif.slv_drv_cb);
                `uvm_error("RESET_TIMEOUT", $sformatf("PRESETn not deasserted after %0d cycles", max_wait_clocks))
            end
        join_any
        disable fork;
    endtask
    
endpackage : ahb_pkg