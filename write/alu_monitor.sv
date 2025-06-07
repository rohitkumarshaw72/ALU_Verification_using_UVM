
class alu_monitor extends uvm_monitor;

    `uvm_component_utils(alu_monitor)
    
    virtual alu_if vif;
    alu_config alu_cfg;
    alu_xtn txn;
    
    uvm_analysis_port #(alu_xtn) mon_ap;
    
    function new(string name="alu_monitor",uvm_component parent);
        super.new(name,parent);
        mon_ap = new("mon_ap",this);
    endfunction
    
    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(alu_config)::get(this,"","alu_config",alu_cfg))
            `uvm_fatal("ALU_MONITOR","cannot get() alu_cfg from uvm_config_db, have you set() it?")
    endfunction
    
    function void connect_phase(uvm_phase phase);
        vif = alu_cfg.vif;
    endfunction
    
    task run_phase(uvm_phase phase);
        forever  begin
            collect_data();
        end
    endtask
    
    task collect_data();
        txn=alu_xtn::type_id::create("txn");
        @(vif.cb_mon);
        txn.dataA_i = vif.cb_mon.dataA_i;
        txn.dataB_i = vif.cb_mon.dataB_i;
        txn.ALUCtrl_i = vif.cb_mon.ALUCtrl_i;
        //txn.rst_i = vif.rst_i;
        txn.ALUResult_o = vif.cb_mon.ALUResult_o;
        txn.Zero_o = vif.cb_mon.Zero_o;
        
        `uvm_info("ALU_MONITOR","Displaying the alu monitor data",UVM_MEDIUM)
        txn.print();
        mon_ap.write(txn);
    endtask

endclass
