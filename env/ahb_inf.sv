`include "../top/ahb_defs.sv"

`ifndef AHB_INF
`define AHB_INF

interface ahb_inf #(int HADDR_W = 32, 
                    int HDATA_W = 32, 
                    int HBURST_W = 3,
                    int HSIZE_W = 3,
                    int HTRANS_W = 2) (input logic HCLK, input logic HRESETn);

    ////////////////////////////////////////////////
    //
    // MASTER <-----> INTERCONNECT <-----> SLAVE
    //
    ////////////////////////////////////////////////

    // Master VIP Outputs
    logic [HADDR_W-1:0] HADDR;
    logic [HBURST_W-1:0] HBURST;
    logic [HSIZE_W-1:0] HSIZE;
    logic [HTRANS_W-1:0] HTRANS;
    logic [HDATA_W-1:0] HWDATA;
    logic HWRITE;
    logic HMASTLOCK;

    // Master VIP Inputs from Interconnect Outputs
    logic [HDATA_W-1:0] HRDATA;
    logic HREADY;
    logic HRESP;

    // Interconnect Outputs to Slave Inputs
    logic HSEL_S;

    // Slave VIP Outputs to Interconnect Inputs
    logic HREADYOUT_S;
    logic HRESP_S;
    logic [HDATA_W-1:0] HRDATA_S;
    
    clocking mas_drv_cb @(posedge HCLK);
        default input #2 output #2;
        output HADDR, HBURST, HSIZE, HTRANS, HWDATA, HWRITE, HMASTLOCK;
        input HRDATA, HREADY, HRESP;
    endclocking

    clocking mas_mon_cb @(posedge HCLK);
        default input #2 output #2;
        input HADDR, HBURST, HSIZE, HTRANS, HWDATA, HWRITE, HMASTLOCK;
        input HRDATA, HREADY, HRESP;
    endclocking
    
    clocking intr_cb @(posedge HCLK);
        default input #2 output #2;
        input HADDR;                            // Inputs from master
        input HREADYOUT_S, HRESP_S, HRDATA_S;   // Inputs from slave
        output HRDATA, HRESP, HREADY;           // Outputs to master
        output HSEL_S;                          // Outputs to slave
    endclocking

    clocking slv_drv_cb @(posedge HCLK);
        default input #2 output #2;
        output HREADYOUT_S, HRESP_S, HRDATA_S;
        input HSEL_S, HADDR, HWRITE, HSIZE, HBURST, HTRANS, HMASTLOCK, HREADY, HWDATA; 
    endclocking

    clocking slv_mon_cb @(posedge HCLK);
        default input #2 output #2;
        input HREADYOUT_S, HRESP_S, HRDATA_S;
        input HSEL_S, HADDR, HWRITE, HSIZE, HBURST, HTRANS, HMASTLOCK, HREADY, HWDATA; 
    endclocking

    modport MAS_DRV_MP(clocking mas_drv_cb);
    modport MAS_MON_MP(clocking mas_mon_cb);
    modport INTR_MP(clocking intr_cb);
    modport SLV_DRV_MP(clocking slv_drv_cb);
    modport SLV_MON_MP(clocking slv_mon_cb);

endinterface : ahb_inf

`endif