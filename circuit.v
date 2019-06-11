`timescale 1ns/1ns


module Circuit(
    input clk, rst,
    input [14:0] address,
    output reg Miss,
    output reg [31:0] out
);

    reg [127:0] cache_in;

    // reg cache_hit;

    reg [127:0] dm_out;

    Cache cache(clk, rst, Miss, address, cache_in, Miss, out);

    DataMemory DM(address, dm_out);

    always @(Miss) begin
        if(Miss) begin
            cache_in = dm_out;
            case(address[1:0])
                2'b00: out <= dm_out[31:0];
                2'b01: out <= dm_out[63:32];
                2'b10: out <= dm_out[95:64];
                2'b11: out <= dm_out[127:96];
            endcase
        end
    end

endmodule
