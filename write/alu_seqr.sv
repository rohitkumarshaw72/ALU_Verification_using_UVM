
class alu_seqr extends uvm_sequencer #(alu_xtn);

    `uvm_component_utils(alu_seqr)
    
    function new(string name="alu_seqr",uvm_component parent);
        super.new(name,parent);
    endfunction

endclass
