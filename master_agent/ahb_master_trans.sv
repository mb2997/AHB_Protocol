`ifndef AHB_MASTER_TRANS
`define AHB_MASTER_TRANS

class ahb_master_trans extends uvm_sequence_item;

    // random variables
    rand bit [`HADDR_W-1:0] HADDR;
    rand bit [`HDATA_W-1:0] HWDATA [];
    rand bit HWRITE;
    rand burst_type_et burst_type;
    rand transfer_size_et transfer_size;
    rand transfer_type_et transfer_type;
    rand int unsigned burst_len;

    bit HMASTLOCK;

    // Wrap boundary variables
    bit [`HADDR_W-1:0] wrap_lower_boundary;
    bit [`HADDR_W-1:0] wrap_upper_boundary;

    // Constraint for randomization
    constraint c1_transfer_size {!(transfer_size inside {RESERVED1, RESERVED2});}
    constraint c2_transfer_size {2**transfer_size <= `HDATA_W/8;}
    constraint c_write_read {HWRITE dist {1:=80, 0:=20};}
    constraint c_write_data_size {HWDATA.size() == burst_len; solve burst_len before HWDATA;}
    constraint c_burst_len {(burst_type == SINGLE) -> burst_len == 1;
                            (burst_type inside {INCR4, WRAP4}) -> burst_len == 4;
                            (burst_type inside {INCR8, WRAP8}) -> burst_len == 8;
                            (burst_type inside {INCR16, WRAP16}) -> burst_len == 16;
                            (burst_type == INCR) -> burst_len inside {[2:32]}; solve burst_type before burst_len;}
    constraint c_addr_alignment {HADDR % (1 << transfer_size) == 0; HADDR < 50;}

    // Factory registration and field macros
    `uvm_object_utils_begin(ahb_master_trans)
        `uvm_field_int(HWRITE, UVM_ALL_ON | UVM_DEC)
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

    function void post_randomize();
        wrap_address_boundaries();
    endfunction

    function void wrap_address_boundaries();
        int unsigned wrap_size;
        if(burst_type inside {WRAP4, WRAP8, WRAP16})
        begin
            wrap_size = (1 << transfer_size) * burst_len;
            wrap_lower_boundary = (HADDR / wrap_size) * wrap_size;
            wrap_upper_boundary = wrap_lower_boundary + wrap_size - 1;
        end
    endfunction

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        if(burst_type inside {WRAP4, WRAP8, WRAP16})
        begin
            printer.print_field("wrap_lower_boundary", wrap_lower_boundary, $bits(wrap_lower_boundary), UVM_DEC);
            printer.print_field("wrap_upper_boundary", wrap_upper_boundary, $bits(wrap_upper_boundary), UVM_DEC);
        end
    endfunction

endclass : ahb_master_trans

`endif