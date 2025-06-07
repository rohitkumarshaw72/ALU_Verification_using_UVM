
class alu_scoreboard extends uvm_scoreboard;
    
    `uvm_component_utils(alu_scoreboard)
    
    uvm_analysis_port #(alu_xtn) res;
    
    int pass_count = 0;
    int fail_count = 0;
    
    alu_xtn alu_data;
    alu_xtn alu_cov_data;
    env_config m_cfg;
    
    covergroup cg;
        option.per_instance = 1;
        cp_ctrl  :  coverpoint alu_cov_data.ALUCtrl_i;
        cp_rst   :  coverpoint alu_cov_data.rst_i;
        cp_result:  coverpoint alu_cov_data.ALUResult_o;
        cp_zero  :  coverpoint alu_cov_data.Zero_o;
    endgroup
    
    function new(string name="alu_scoreboard",uvm_component parent);
        super.new(name,parent);
        cg = new();
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
            `uvm_fatal("m_cfg","no update")
        res = new("res",this);
    endfunction
    
    task run_phase(uvm_phase phase);
        forever  begin
            res.get(alu_data);
            `uvm_info("ALU_SB","alu data",UVM_LOW)
            alu_data.print();
            
            alu_cov_data = alu_data;
            cg.sample();
        end
    endtask
    
    function void check_data(alu_xtn txn);
        
    endfunction
    
endclass
