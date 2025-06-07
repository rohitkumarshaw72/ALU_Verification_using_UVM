
class alu_virtual_seq extends uvm_sequence #(uvm_sequence_item);

    `uvm_object_utils(alu_virtual_seq)
    
    alu_seqr seqr[];
    //alu_seqr seqr;
    alu_virtual_seqr v_seqr;
    env_config m_cfg;
    
    function new(string name="alu_virtual_seq");
        super.new(name);
    endfunction
    
    task body();
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"m_cfg",m_cfg))
            `uvm_fatal("VSEQ_BODY","cannot get() m_cfg from uvm_config_db")
        
        seqr=new[m_cfg.no_of_wr_agt];
        //seqr=alu_seqr::type_id::create("seqr",this);
        
        assert($cast(v_seqr,m_sequencer))  else  begin
            `uvm_error("VSEQ_BODY","Error in $cast of virtual sequencer")
        end
        
        foreach(seqr[i])  begin
            seqr[i] = v_seqr.seqr[i];
        end
        //seqr = v_seqr.seqr;
        
    endtask

endclass
