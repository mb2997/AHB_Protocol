`ifndef AHB_SLAVE_TRANS
`define AHB_SLAVE_TRANS

class ahb_slave_trans extends uvm_sequence_item;

    // random variables
    bit [`HADDR_W-1:0] HADDR;
    bit [`HDATA_W-1:0] HWDATA [];
    rd_wr_et HWRITE;
    burst_type_et burst_type;
    transfer_size_et transfer_size;
    transfer_type_et transfer_type;
    int unsigned burst_len;

    bit HMASTLOCK;

    // Wrap boundary variables
    bit [`HADDR_W-1:0] wrap_lower_boundary;
    bit [`HADDR_W-1:0] wrap_upper_boundary;

    // Factory registration and field macros
    `uvm_object_utils_begin(ahb_master_trans)
        `uvm_field_enum(rd_wr_et, HWRITE, UVM_ALL_ON)
        `uvm_field_int(HADDR, UVM_ALL_ON | UVM_DEC)
        `uvm_field_array_int(HWDATA, UVM_ALL_ON | UVM_DEC)
        `uvm_field_enum(burst_type_et, burst_type, UVM_ALL_ON)
        `uvm_field_enum(transfer_type_et, transfer_type, UVM_ALL_ON)
        `uvm_field_enum(transfer_size_et, transfer_size, UVM_ALL_ON)
        `uvm_field_int(burst_len, UVM_ALL_ON | UVM_DEC)
    `uvm_object_utils_end

    function new(string name = "ahb_master_trans");
        super.new(name);
    endfunction

endclass : ahb_slave_trans

`endif