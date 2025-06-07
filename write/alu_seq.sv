
class alu_seq extends uvm_sequence #(alu_xtn);

    `uvm_object_utils(alu_seq)
    
    function new(string name="alu_seq");
        super.new(name);
    endfunction
    
    task body();
        alu_xtn req;
        repeat(10)  begin
            
            req=alu_xtn::type_id::create("req");
            start_item(req);
            
            assert(req.randomize() with {
            ALUCtrl_i inside {3'b000, 3'b001, 3'b010, 3'b011, 3'b100, 3'b110};  }
            );
            
            finish_item(req);
            
        end
    endtask

endclass
