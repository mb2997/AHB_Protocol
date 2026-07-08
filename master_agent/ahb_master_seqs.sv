`ifndef AHB_MASTER_SEQS
`define AHB_MASTER_SEQS

class ahb_master_seqs extends uvm_sequence #(ahb_master_trans);

    `uvm_object_utils(ahb_master_seqs)

    ahb_master_trans mtrans_h;

    function new(string name = "ahb_master_seqs");
        super.new(name);
    endfunction

    task body();
        mtrans_h = ahb_master_trans :: type_id :: create("mtrans_h");
        repeat(no_of_trans)
        begin
            start_item(mtrans_h);
            assert(mtrans_h.randomize());
            `uvm_info(get_type_name(), $sformatf("Generated Master Transaction = \n%s", mtrans_h.sprint()), UVM_MEDIUM)
            finish_item(mtrans_h);
        end
    endtask

endclass : ahb_master_seqs

`endif