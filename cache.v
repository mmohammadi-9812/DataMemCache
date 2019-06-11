`timescale 1ns/1ns

module Cache(
    input clk, rst,
    input read_enable, write_enable,
    input [14:0] address,
    input [127:0] in,
    output Hit,
    output [31:0] out
);

    reg [131:0] mem [0:1023];
    reg [31:0] outreg;

    integer i;

    assign Hit = (mem[address[11:2]][131] == 1 & mem[address[11:2]][130:128] == address[14:12]);
    assign out = outreg;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            for(i = 0; i < 1024; i = i + 1)
                mem[i] <= 132'b0;
        end
        else if(write_enable) mem[address[11:2]] <= {1'b1, address[14:12], in};
    end


    always @(address, Hit) begin
        if(read_enable) begin
            case(address[1:0])
                2'b00: outreg = mem[address[11:2]][31:0];
                2'b01: outreg = mem[address[11:2]][63:32];
                2'b10: outreg = mem[address[11:2]][95:64];
                2'b11: outreg = mem[address[11:2]][127:96];
            endcase
        end
    end




endmodule
