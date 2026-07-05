`include "../top/ahb_defs.sv"

`ifndef AHB_INF
`define AHB_INF

interface apb_inf #(int HADDR_W = 32, 
                    int HDATA_W = 32, 
                    int HBURST_W = 3,
                    int HSIZE_W = 3,
                    int HTRANS_W = 2) (input logic HCLK, input logic HRESETn);

    // Signals originated from master
    logic [HADDR_W-1:0] HADDR;
    logic [HBURST_W-1:0] HBURST;
    logic HMASTLOCK;
    logic [HSIZE_W-1:0] HSIZE;
    logic [HTRANS_W-1:0] HTRANS;
    logic [HDATA_W-1:0] HWDATA;
    logic HWRITE;
    
    clocking mas_drv_cb@(posedge PCLK);
        default input #1 output #1;
        output PWRITE;
        output PSTRB;
        output PENABLE;
        output PSEL;
        output PWDATA;
        output PADDR;
        input  PREADY;
        input  PRDATA;
        input  PSLVERR;
    endclocking

    clocking mas_mon_cb@(posedge PCLK);
        default input #1 output #1;
        input PWRITE;
        input PRESETn;
        input PENABLE;
        input PSTRB;
        input PSEL;
        input PWDATA;
        input PADDR;
        input PREADY;
        input PRDATA;
        input PSLVERR;
    endclocking

    clocking slv_drv_cb@(posedge PCLK);
        default input #1 output #1;
        input PWRITE;
        input PRESETn;
        input PENABLE;
        input PSTRB;
        input PSEL;
        input PWDATA;
        input PADDR;
        output PREADY;
        output PRDATA;
        output PSLVERR;
    endclocking

    clocking slv_mon_cb@(posedge PCLK);
        default input #1 output #1;
        input PWRITE;
        input PRESETn;
        input PENABLE;
        input PSEL;
        input PWDATA;
        input PADDR;
        input PSTRB;
        input PREADY;
        input PRDATA;
    endclocking

    modport MAS_DRV_MP(clocking mas_drv_cb);
    modport MAS_MON_MP(clocking mas_mon_cb);
    modport SLV_DRV_MP(clocking slv_drv_cb);
    modport SLV_MON_MP(clocking slv_mon_cb);

endinterface : apb_inf

`endif