`ifndef AHB_MASTER_DRV
`define AHB_MASTER_DRV

class ahb_master_drv extends uvm_driver #(ahb_master_trans);

    //Factory registration
    `uvm_component_utils(ahb_master_drv)

    //Required instance of class & interface
    virtual ahb_inf.MAS_DRV_MP vif;
    int hready_max_cycles;
    bit first_txn = 1;

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
            first_txn = 0;
            seq_item_port.item_done();

            // Driving HTRANS = IDLE before getting a next fresh transaction
            req.transfer_type = IDLE;
            $cast(vif.mas_drv_cb.HTRANS, req.transfer_type);
        end
    endtask

    task wait_for_hready();
        fork: HREADY_TIMEOUT_BLOCK
            begin
                wait(vif.mas_drv_cb.HREADY);
                `uvm_info(get_type_name(), $sformatf("HREADY is asserted from slave side, Driving a new transaction..."), UVM_MEDIUM)
            end
            begin
                repeat(hready_max_cycles)
                    @(vif.mas_drv_cb);
                `uvm_error(get_type_name(), $sformatf("HREADY didn't assert from Slave within configured %0d numbers of clock cycles", hready_max_cycles))
            end
        join_any
        disable HREADY_TIMEOUT_BLOCK;
    endtask

    task send_to_dut(ahb_master_trans req);

        int unsigned no_of_bytes;

        no_of_bytes = (1 << req.transfer_size);

        // Address Phase
        // wait_for_hready();
        if(first_txn)
            @(posedge vif.mas_drv_cb);
        $cast(vif.mas_drv_cb.HWRITE, req.HWRITE);
        $cast(vif.mas_drv_cb.HBURST, req.burst_type);
        $cast(vif.mas_drv_cb.HSIZE, req.transfer_size);
        req.transfer_type = NONSEQ;
        $cast(vif.mas_drv_cb.HTRANS, req.transfer_type);

        // Data Phase
        if(req.HWRITE)
        begin
            foreach(req.HWDATA[i])
            begin
                vif.mas_drv_cb.HADDR <= req.HADDR;

                if(req.burst_type inside {WRAP4, WRAP8, WRAP16})
                begin
                    if(req.HADDR >= req.wrap_upper_boundary)
                        req.HADDR = req.wrap_lower_boundary;
                    else
                        req.HADDR = req.HADDR + no_of_bytes;
                end
                else if(req.burst_type inside {INCR, INCR4, INCR8, INCR16})
                    req.HADDR = req.HADDR + no_of_bytes;
                    
                @(posedge vif.mas_drv_cb);
                vif.mas_drv_cb.HWDATA <= req.HWDATA[i];
                req.transfer_type = SEQ;
                $cast(vif.mas_drv_cb.HTRANS, req.transfer_type);
                // wait_for_hready();
            end
        end

    endtask

endclass : ahb_master_drv

`endif