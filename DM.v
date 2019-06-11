module DataMemory(
    input clk, rst,
    input [14:0] address,
    output reg [127:0] out
);

    reg [31:0] mem [0:32767];

    integer i;

    always @(posedge rst) begin
            if (rst) begin
                for(i = 0; i < 32767; i++) mem[i] <= 32'b0;
            end
    end

    always @(address) begin
        else begin
            out <= {mem[address], mem[address+1], mem[address+2], mem[address+3]};
        end
    end

    initial begin
        for(i = 0; i < 32767; i++) mem[i] <= i;
    end

endmodule
