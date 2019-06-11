`timescale 1ns/1ns


module DataMemory(
    input clk, rst,
    input [14:0] address,
    output reg [127:0] out
);

    reg [31:0] mem [0:32767];

    integer i;

    always @(address) begin
        begin
            out <= {mem[address], mem[address+1], mem[address+2], mem[address+3]};
        end
    end

    initial begin
        if (rst) begin
            for(i = 0; i < 32767; i = i + 1) mem[i] <= 32'b0;
        end
        else begin
            for(i = 0; i < 32767; i = i + 1)
                mem[i] = 2 * i;
        end
    end

endmodule
