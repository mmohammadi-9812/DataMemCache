module Cache(
    input clk, rst,
    input read_enable, write_enable,
    input [14:0] address,
    input [128:0] in,
    output reg Hit,
    output [31:0] reg out
);

    reg [131:0] mem [0:1023];

    integer i;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            for(i = 0; i < 1023; i++) mem[i] <= 132'b0;
        end
        if(write_enable) mem[address[11:2]] <= {1, address[14:12], in};
    end


    always @(address, Hit) begin
        if(read_enable) begin
            case(address[1:0])
                2'b00: out <= mem[address[11:2]][31:0];
                2'b01: out <= mem[address[11:2]][63:32];
                2'b10: out <= mem[address[11:2]][95:64];
                2'b11: out <= mem[address[11:2]][127:96];
            endcase
        end
    end


initial begin
    Hit <= (mem[address[11:2]][131] == 1 && mem[address[11:2]][130:128] == address[14:12]);
end

endmodule
