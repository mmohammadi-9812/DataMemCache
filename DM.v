module DataMemory(
    input clk, rst,
    input [14:0] address,
    output reg [31:0] out
);

    reg [32767:0] mem [0:31];

    integer i;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            for(i = 0; i < 32767; i++) mem[i] <= 32'b0;
        end
        else out <= mem[address];
    end

endmodule
