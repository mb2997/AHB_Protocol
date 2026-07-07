import ahb_pkg::*;

module ahb_top();

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Local variables
    logic clk = 0;
    logic rstn = 1;
    real CYCLE;

    ahb_inf inf(clk, rstn);
    ahb_base_test test_hm;

    // Initial reset for all
    initial begin
        rstn = 0;
        @(negedge clk);
        @(negedge clk);
        rstn = 1;
    end

    initial
    begin
        if(!$value$plusargs("CYCLE=%f", CYCLE))
        begin
            CYCLE = 20.00;
            `uvm_info("DEFAULT CLOCK PERIOD", $sformatf("Clock period is set to %.2f", CYCLE), UVM_MEDIUM)
        end
        else
            `uvm_info("PLUSARG CLOCK PERIOD", $sformatf("Clock period is set to %.2f", CYCLE), UVM_MEDIUM)
        forever
        begin
            #(CYCLE/2) clk = ~clk;
        end
    end

    initial
    begin
        uvm_config_db #(virtual ahb_inf) :: set(null,"*","ahb_inf",inf);
        run_test("ahb_base_test");
    end

endmodule : ahb_top