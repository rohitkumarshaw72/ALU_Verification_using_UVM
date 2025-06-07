
class alu_driver extends uvm_driver #(alu_xtn);

    `uvm_component_utils(alu_driver)
    
    virtual alu_if.DRV_MP vif;
    alu_config alu_cfg;
    
    function new(string name="alu_driver",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        if(uvm_config_db #(alu_config)::get(this,"","alu_config",alu_cfg))
            `uvm_fatal("ALU_DRIVER","cannot get() alu_cfg from uvm_config_db, have you set() it?")
    endfunction
    
    function void connect_phase(uvm_phase phase);
        vif = alu_cfg.vif;
    endfunction
    
    task run_phase(uvm_phase phase);
        forever  begin
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            seq_item_port.item_done();
        end
    endtask
    
    task send_to_dut(alu_xtn xtn);
        @(vif.cb_drv);
        vif.cb_drv.dataA_i <= req.dataA_i;
        vif.cb_drv.dataB_i <= req.dataB_i;
        vif.cb_drv.ALUCtrl_i <= req.ALUCtrl_i;
        //vif.rst_i <= req.rst_i;
        
        `uvm_info("ALU_DRIVER","Displaying alu driver data",UVM_MEDIUM)
        xtn.print();
    endtask

endclass
