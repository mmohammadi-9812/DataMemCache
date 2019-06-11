module DataMemory(
    input clk, rst,
    input [14:0] address,
    output reg [31:0] out
);

    reg [31:0] mem [0:32767];

    integer i;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            for(i = 0; i < 32767; i++) mem[i] <= 32'b0;
        end
        else out <= mem[address];
    end

    initial begin
        for(i = 0; i < 32767; i++) mem[i] <= i;
    end

endmodule
