module circuit(
    input clk, rst,
    input [14:0] address,
    output [31:0] reg out
);

    reg [31:0] dmout;
    reg valid;
    
    DataMemory dm(clk, rst, address, dmout);

    Cache cache(clk, rst, address, dmout, valid, out);

endmodule
