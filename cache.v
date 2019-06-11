module Cache(
    input clk, rst,
    input [14:0] address,
    input [31:0] in,
    output reg Hit,
    output [31:0] reg out
);

    reg [131:0] mem [0:1023];

    integer i;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            for(i = 0; i < 1023; i++) mem[i] <= 132'b0;
        end
        else if(mem[address][131] == 0 || (mem[address][131] == 1 && mem[address][130:128] != address[14:12]) ) begin
            Hit <= 0;
            mem[address[11:2]] <= {1, address[14:12], in};
            out <= in;
        end
        else if(mem[address][131] == 1 && mem[address][130:128] == address[14:12]) begin
            Hit <= 1;
            out <= mem[address[11:0]];
        end
    end

endmodule
