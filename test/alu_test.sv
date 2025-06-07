
class alu_test extends uvm_test;

    `uvm_component_utils(alu_test)
    
    alu_env env;
    env_config m_cfg;
    alu_config alu_cfg[];
    //alu_config alu_cfg;
    
    int no_of_wr_agt = 1;
    
    
    function new(string name="alu_test",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    
    function void config_alu();
        begin
            alu_cfg = new[no_of_wr_agt];
            foreach(alu_cfg[i])  begin
                alu_cfg[i] = alu_config::type_id::create($sformatf("alu_cfg[%0d]",i));
                
                if(!uvm_config_db #(virtual alu_if)::get(this,"","vif",alu_cfg[i].vif))
                    `uvm_fatal("VIF_CONFIG","cannot get() vif from uvm_config_db, have you set() it?")
            
                alu_cfg[i].is_active = UVM_ACTIVE;
                m_cfg.alu_cfg[i] = alu_cfg[i];
            end
            
            /*alu_cfg = alu_config::type_id::create("alu_cfg");
                
                if(!uvm_config_db #(virtual alu_if)::get(this,"","vif",alu_cfg.vif))
                    `uvm_fatal("VIF_CONFIG","cannot get() vif from uvm_config_db, have you set() it?")
            
                alu_cfg.is_active = UVM_ACTIVE;
                m_cfg.alu_cfg = alu_cfg;*/
            
        end
        
        m_cfg.no_of_wr_agt = no_of_wr_agt;
        
    endfunction
    
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_cfg=env_config::type_id::create("m_cfg");
        
        if(m_cfg.has_wagent)  begin
            m_cfg.alu_cfg = new[no_of_wr_agt];
            //m_cfg.alu_cfg = alu_config::type_id::create("alu_cfg", this);
        end
        
        config_alu();
        
        uvm_config_db #(env_config)::set(this,"*","env_config",m_cfg);
        env = alu_env::type_id::create("env",this);
    endfunction

endclass



class alu_random_test extends alu_test;

    `uvm_component_utils(alu_random_test)
    
    alu_seq seqh;
    bit [2:0] ALUCtrl_i;
    
    function new(string name="alu_random_test",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        `uvm_info("ALU_TEST","Printing UVM topology",UVM_MEDIUM)
        uvm_top.print_topology();
    endfunction
    
    task run_phase(uvm_phase phase);
        ALUCtrl_i = {3'b000, 3'b001, 3'b010, 3'b011, 3'b100, 3'b110};
        uvm_config_db #(bit [2:0])::set(this,"*","ALUCtrl_i",ALUCtrl_i);
        
        phase.raise_objection(this);
        seqh=alu_seq::type_id::create("seqh");
        seqh.start(env.wr_agt_top.agth[0].seqr);
        phase.drop_objection(this);
        
    endtask

endclass
