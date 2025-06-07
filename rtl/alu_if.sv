
interface alu_if(input logic clk_i, input logic rst_i);

    logic [31:0] dataA_i;
    logic [31:0] dataB_i;
    logic [2:0] ALUCtrl_i;
    logic [31:0] ALUResult_o;
    logic Zero_o;
    
    clocking cb_drv @(posedge clk_i);
        output dataA_i;
        output dataB_i;
        output ALUCtrl_i;
        //input ALUResult_o;
        //input Zero_o;
    endclocking
    
    clocking cb_mon @(posedge clk_i);
        input dataA_i;
        input dataB_i;
        input ALUCtrl_i;
        input ALUResult_o;
        input Zero_o;
    endclocking
    
    modport DRV_MP (clocking cb_drv, input rst_i);
    modport MON_MP (clocking cb_mon, input rst_i);

endinterface
