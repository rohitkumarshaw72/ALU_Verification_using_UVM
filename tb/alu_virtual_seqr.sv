
class alu_virtual_seqr extends uvm_sequencer;

    `uvm_component_utils(alu_virtual_seqr)
    
    alu_seqr seqr[];
    //alu_seqr seqr;
    env_config m_cfg;
    
    function new(string name="alu_virtual_seqr",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    
    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
            `uvm_fatal("VSEQR_CONFIG","cannot get() m_cfg from uvm_config_db, have you set() it?")
        
        seqr=new[m_cfg.no_of_wr_agt];
        //seqr=alu_seqr::type_id::create("seqr",this);
        
    endfunction
    
endclass
