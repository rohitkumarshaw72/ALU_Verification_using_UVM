
class alu_write_agent_top extends uvm_env;

    `uvm_component_utils(alu_write_agent_top)
    
    alu_write_agent agth[];
    //alu_write_agent agth;
    env_config m_cfg;
    
    function new(string name="alu_write_agent_top",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
            `uvm_fatal(get_type_name(),"ENV: alu_write_agent error")
        
        agth = new[m_cfg.no_of_wr_agt];
        
        foreach(agth[i])  begin
            agth[i]=alu_write_agent::type_id::create($sformatf("agth[%0d]",i),this);
            
            `uvm_info("ALU_CFG_SET", $sformatf("Setting alu_config for agth[%0d]", i), UVM_LOW)
            uvm_config_db #(alu_config)::set(this,$sformatf("agth[%0d]*",i),"alu_config",m_cfg.alu_cfg[i]);
        end
        
        /*agth = alu_write_agent::type_id::create("agth", this);
        uvm_config_db #(alu_config)::set(this,"*","alu_config",m_cfg.alu_cfg);*/
        
    endfunction

endclass
