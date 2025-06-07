class alu_xtn extends uvm_sequence_item;

    `uvm_object_utils(alu_xtn)
    
    rand bit [31:0] dataA_i;
    rand bit [31:0] dataB_i;
    rand bit [2:0] ALUCtrl_i;
    bit rst_i;
    bit [31:0] ALUResult_o;
    bit Zero_o;
    
    constraint C1 {
        ALUCtrl_i inside {3'b000, 3'b001, 3'b010, 3'b011, 3'b100, 3'b110};
    }
    
    function new(string name="alu_xtn");
        super.new(name);
    endfunction
    
    function void do_print(uvm_printer printer);
        super.do_print(printer);
        
        //string name        bitstream value        size      radix_for_printing
        printer.print_field("dataA_i",this.dataA_i,32,UVM_HEX);
        printer.print_field("dataB_i",this.dataB_i,32,UVM_HEX);
        printer.print_field("ALUCtrl_i",this.ALUCtrl_i,3,UVM_BIN);
        printer.print_field("rst_i",this.rst_i,1,UVM_BIN);
        printer.print_field("ALUResult_o",this.ALUResult_o,32,UVM_HEX);
        printer.print_field("Zero_o",this.Zero_o,1,UVM_BIN);
        
    endfunction

endclass
