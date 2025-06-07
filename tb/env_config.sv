
class env_config extends uvm_object;

    bit has_wagent = 1;
    int no_of_wr_agt = 1;
    bit has_virtual_sequencer = 1;
    bit has_scoreboard;
    
    `uvm_object_utils(env_config)
    
    alu_config alu_cfg[];
    //alu_config alu_cfg;
    
    function new(string name="env_config");
        super.new(name);
    endfunction

endclass
