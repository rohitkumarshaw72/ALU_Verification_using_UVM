
module alu_top  (
    input clk_i,
    input rst_i,
    input [31:0] dataA_i,
    input [31:0] dataB_i,
    input [2:0] ALUCtrl_i,
    output reg [31:0] ALUResult_o,
    output reg Zero_o
);

    reg [31:0] temp_alu_result;
    reg temp_zero;
    
    always @(*)  begin
        if(rst_i == 1'b1)  begin
            temp_alu_result = 32'b0;
            temp_zero = 1'b0;
        end  else  begin
        
        case (ALUCtrl_i)
            3'b010:
            begin
                temp_alu_result = dataA_i + dataB_i;
            end
            
            3'b110:
            begin
                temp_alu_result = dataA_i - dataB_i;
            end
            
            3'b000:
            begin
                temp_alu_result = dataA_i & dataB_i;
            end
            
            3'b001:
            begin
                temp_alu_result = dataA_i | dataB_i;
            end
            
            3'b011:
            begin
                temp_alu_result = dataA_i ^ dataB_i;
            end
            
            3'b100:  
            begin
                temp_alu_result = ~(dataA_i | dataB_i);
            end
            
            default:
            begin
                temp_alu_result = 32'b0;
                temp_zero = 1'b0;
            end
        endcase
        
        
        //The zero signal is mainly used by the branch
        if(temp_alu_result == 32'b0)  begin
            temp_zero = 1'b1;
            
        end  else  begin
            temp_zero = 1'b0;
        end
        
        end
    end
    
    always @(posedge clk_i or posedge rst_i)  begin
        if(rst_i == 1'b1)  begin
            ALUResult_o <= 32'b0;
            Zero_o <= 1'b1;
        end  else  begin
            ALUResult_o <= temp_alu_result;
            Zero_o <= temp_zero;
        end
    end
    
endmodule: alu_top
