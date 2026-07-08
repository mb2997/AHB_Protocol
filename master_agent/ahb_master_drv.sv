`ifndef AHB_MASTER_DRV
`define AHB_MASTER_DRV

class ahb_master_drv extends uvm_driver #(ahb_master_trans);

    //Factory registration
    `uvm_component_utils(ahb_master_drv)

    //Required instance of class & interface
    virtual ahb_inf.MAS_DRV_MP vif;
    int hready_max_cycles;

    function new(string name = "ahb_master_drv", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        req = ahb_master_trans :: type_id :: create("req");
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            seq_item_port.item_done();
        end
    endtask

    task send_to_dut(ahb_master_trans req);

        fork: HREADY_TIMEOUT_BLOCK
            begin
                wait(vif.mas_drv_cb.HREADY);
                `uvm_info(get_type_name(), $sformatf("HREADY is asserted from slave side, Driving a new transaction..."), UVM_MEDIUM)
            end

            begin
                repeat(hready_max_cycles)
                    @(vif.mas_drv_cb);
                `uvm_error(get_type_name(), $sformatf("HREADY TIMEOUT", $sformatf("HREADY didn't assert from Slave within configured %0d numbers of clock cycles", hready_max_cycles)))
            end
        join_any

        disable HREADY_TIMEOUT_BLOCK;

        @(posedge vif.mas_drv_cb);
        vif.mas_drv_cb.HWRITE <= req.HWRITE;
        vif.mas_drv_cb.HADDR <= req.HADDR;

    endtask

endclass : ahb_master_drv

`endif