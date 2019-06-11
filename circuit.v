module circuit(
    input clk, rst,
    input [14:0] address,
    output [31:0] reg out
);

    wire [127:0] cache_in;

    reg cache_hit;

    reg [31:0] dm_out;

    Cache cahe(clk, rst, Hit, ~Hit, address, cache_in, cache_hit, out);

    DataMemory DM(clk, rst, address, dm_out);

    always @(Hit) begin
        cache_in = dm_out;
        if(~Hit) begin
            case(address[1:0])
                2'b00: out <= dm_out[31:0];
                2'b01: out <= dm_out[63:32];
                2'b10: out <= dm_out[95:64];
                2'b11: out <= dm_out[127:96];
            endcase
        end
    end

endmodule
