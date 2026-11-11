module decoder (
    input  logic [31:0] instruction,
    output logic [4:0]  rs1,
    output logic [4:0]  rs2,
    output logic [4:0]  rd,
    output logic [6:0]  opcode,
    output logic [6:0]  imm11_5,      // instruction[31:25] (I-type ALU only)
    output logic [2:0]  fn3,
    output logic [11:0] imm,          // I / S / B immediate bits
    output logic [19:0] imm_uj,       // U / J immediate bits
    output logic        fn7_5         // instruction[30] (R-type only)
);
    assign opcode = instruction[6:0];

    always_comb begin
        // default: everything except opcode is 0
        rs1     = 5'b0;
        rs2     = 5'b0;
        rd      = 5'b0;
        imm11_5 = 7'b0;
        fn3     = 3'b0;
        imm     = 12'b0;
        imm_uj  = 20'b0;
        fn7_5   = 1'b0;

        case (instruction[6:0])
            7'b0110011: begin // R-type
                rd    = instruction[11:7];
                fn3   = instruction[14:12];
                rs1   = instruction[19:15];
                rs2   = instruction[24:20];
                fn7_5 = instruction[30];
            end
            7'b0010011: begin // I-type ALU
                rd      = instruction[11:7];
                fn3     = instruction[14:12];
                rs1     = instruction[19:15];
                imm     = instruction[31:20];
                imm11_5 = instruction[31:25];
            end
            7'b0000011: begin
