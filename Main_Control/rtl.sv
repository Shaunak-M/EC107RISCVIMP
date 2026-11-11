module main_control (
    input  logic [6:0] opcode,
    input  logic [2:0] fn3,
    output logic [1:0] memtoreg,    // write-back select
    output logic       branch,
    output logic       mux_inp,     // 1 = JALR (target comes from the ALU)
    output logic       memread,
    output logic       memwrite,
    output logic       alusrc,      // 0 = rs2, 1 = immediate
    output logic       reg_write,
    output logic [2:0] aluop        // operation class for the ALU control
);
    always_comb begin
        case (opcode)
            //                 memtoreg branch mux_inp memread memwrite alusrc reg_write aluop
            7'b0110011: {memtoreg, branch, mux_inp, memread, memwrite, alusrc, reg_write, aluop} = 11'b00_0_0_0_0_0_1_000; // R-type
            7'b0010011: {memtoreg, branch, mux_inp, memread, memwrite, alusrc, reg_write, aluop} = 11'b00_0_0_0_0_1_1_001; // I-type ALU
            7'b0000011: {memtoreg, branch, mux_inp, memread, memwrite, alusrc, reg_write, aluop} = 11'b01_0_0_1_0_1_1_010; // Load
            7'b0100011: {memtoreg, branch, mux_inp, memread, memwrite, alusrc, reg_write, aluop} = 11'b11_0_0_0_1_1_0_011; // Store
            7'b1100011: {memtoreg, branch, mux_inp, memread, memwrite, alusrc, reg_write, aluop} = 11'b00_1_0_0_0_0_0_100; // Branch
            7'b1101111: {memtoreg, branch, mux_inp, memread, memwrite, alusrc, reg_write, aluop} = 11'b10_0_0_0_0_1_1_110; // JAL
            7'b1100111: {memtoreg, branch, mux_inp, memread, memwrite, alusrc, reg_write, aluop} = 11'b10_0_1_0_0_1_1_001; // JALR
            7'b0110111: {memtoreg, branch, mux_inp, memread, memwrite, alusrc, reg_write, aluop} = 11'b10_0_0_0_0_1_1_110; // LUI
            7'b0010111: {memtoreg, branch, mux_inp, memread, memwrite, alusrc, reg_write, aluop} = 11'b10_0_0_0_0_1_1_000; // AUIPC
            default:    {memtoreg, branch, mux_inp, memread, memwrite, alusrc, reg_write, aluop} = 11'b00_0_0_0_0_0_0_000; // other
        endcase
    end
endmodule
