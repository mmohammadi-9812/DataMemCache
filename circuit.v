module circuit(
    input clk, rst,
    input [14:0] address,
    output [31:0] reg out
);

    reg [31:0] dmout, cache_in;
    wire [14:0] cache_adr;
    reg Hit;

    DataMemory dm(clk, rst, address, dmout);

    assign cache_adr = address;

    Cache cache(clk, rst, cache_adr, dmout, Hit, out);

    integer i;

    if(~Hit) begin
        reg [14:0] tmp = address;
        for(i = 1; i < 4; i++) begin
            assign address = tmp + i, cache_adr = tmp + i;
        end
    end

endmodule
