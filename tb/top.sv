
module top;

    import uvm_pkg::*;
    
    import alu_pkg::*;
    
    bit clk_i;
    bit rst_i;
    
    always
        #5 clk_i = ~clk_i;
    
    alu_if in(clk_i, rst_i);
    
    alu_top DUV (.clk_i(clk_i),
                .rst_i(rst_i),
                .dataA_i(in.dataA_i),
                .dataB_i(in.dataB_i),
                .ALUCtrl_i(in.ALUCtrl_i),
                .ALUResult_o(in.ALUResult_o),
                .Zero_o(in.Zero_o)
    );
    
    initial  begin
        
        `ifdef VCS
            $fsdbDumpvars(0,top);
        `endif
        
        uvm_config_db #(virtual alu_if)::set(null,"*","vif",in);
        
        run_test();
        
    end

endmodule
