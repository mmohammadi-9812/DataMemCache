module cache(
    input clk, rst,
    input [14:0] address,
    input [31:0] in,
    output reg valid,
    output [31:0] reg out
);

    reg [4095:0] mem [0:35];

    integer i;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            for(i = 0; i < 4096; i++) mem[i] <= 36'b0;
        end
        else if(mem[address][35] == 0 || (mem[address][35] == 1 && mem[address][34:32] != address[14:12]) ) begin
            valid <= 0;
            mem[address[11:0]] <= {1, address[14:12], in};
            out <= in;
        end
        else if(mem[address][35] == 1 && mem[address][34:32] == address[14:12]) begin
            valid <= 1;
            out <= mem[address[11:0]];
        end
    end

endmodule
