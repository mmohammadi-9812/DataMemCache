module Contoller(
    input clk, rst,
    input Hit, Start,
    output reg ready,
    // output reg outport,
    output reg read_enable, write_eneable
);

    parameter IDLE = 0, START = 1, MISS = 2, HIT = 3;

    reg [1:0] ps, ns;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            ns <= 2'b0;
            ps <= 2'b0;
        end
        ps <= ns;
    end

    always @(Hit, Start, ps) begin
        case(ps)
            IDLE: ns <= (Start == 1);
            START: ns <= (Hit == 1);
            HIT: ns <= IDLE;
            MISS: ns <= IDLE;
        endcase
    end

    always @(ps) begin
        {ready, read_enable, write_eneable} = 3'b0;
        case(ps)
            HIT: begin
                read_enable = 1;
                ready = 1;
            end
            MISS: write_eneable = 1;
        endcase
    end

endmodule
