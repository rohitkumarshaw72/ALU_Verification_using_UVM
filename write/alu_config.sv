
class alu_config extends uvm_object;

    `uvm_object_utils(alu_config)
    
    virtual alu_if vif;
    
    uvm_active_passive_enum is_active = UVM_ACTIVE;
    
    function new(string name="alu_config");
        super.new(name);
    endfunction

endclass
