
class alu_write_agent extends uvm_agent;

    `uvm_component_utils(alu_write_agent);
    
    alu_config alu_cfg;
    alu_monitor monh;
    alu_seqr seqr;
    alu_driver drvh;
    
    function new(string name="alu_write_agent",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(alu_config)::get(this,"","alu_config",alu_cfg))
            `uvm_fatal("CONFIG","cannot get() alu_cfg from uvm_config_db, have you set() it?")
        monh = alu_monitor::type_id::create("monh",this);
        
        if(alu_cfg.is_active==UVM_ACTIVE)  begin
            drvh=alu_driver::type_id::create("drvh",this);
            seqr=alu_seqr::type_id::create("seqr",this);
        end
        
    endfunction
    
    function void connect_phase(uvm_phase phase);
        if(alu_cfg.is_active==UVM_ACTIVE)  begin
            drvh.seq_item_port.connect(seqr.seq_item_export);
        end
    endfunction

endclass
