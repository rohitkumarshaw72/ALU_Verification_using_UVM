
class alu_env extends uvm_env;

    `uvm_component_utils(alu_env)
    
    alu_write_agent_top wr_agt_top;
    
    alu_virtual_seqr v_seqr;
    
    alu_scoreboard sb;
    
    env_config m_cfg;
    
    
    function new(string name="alu_env",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
            `uvm_fatal("ENV_CONFIG","cannot get() m_cfg from uvm_config_db, have you set() it?")
      
      begin
          wr_agt_top=alu_write_agent_top::type_id::create("wr_agt_top",this);
      end
      
      if(m_cfg.has_virtual_sequencer)  begin
          v_seqr=alu_virtual_seqr::type_id::create("v_seqr",this);
      end
      
      if(m_cfg.has_scoreboard)  begin
          sb=alu_scoreboard::type_id::create("sb",this);
      end
    endfunction
    
    
    
    function void connect_phase(uvm_phase phase);
        for(int i=0;i<m_cfg.no_of_wr_agt;i++)
            v_seqr.seqr[i] = wr_agt_top.agth[i].seqr;
        
        super.connect_phase(phase);
        //v_seqr.seqr = wr_agt_top.agth.seqr;
        `uvm_info("ALU_ENV","This is connect phase in alu_env",UVM_LOW)
    endfunction
    
    
    function void end_of_elaboration_phase(uvm_phase phase);
        m_cfg=env_config::type_id::create("m_cfg");
        super.end_of_elaboration_phase(phase);
        `uvm_info("ALU_ENV","This is end_of_elaboration phase in alu_env",UVM_LOW)
    endfunction
    
    task run_phase(uvm_phase phase);
        super.run();
        phase.raise_objection(this);
        #100;
        `uvm_info("ALU_ENV","This is run phase in alu_env",UVM_LOW)
        phase.drop_objection(this);
    endtask

endclass
