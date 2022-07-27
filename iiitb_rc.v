module DFlipFlop(D, clk, reset, init, Q);
    input D, clk, reset, init;
    output reg Q;

    always @ (posedge clk or posedge reset)
        if(reset) Q <= init;
        else Q <= D;
endmodule

module iiitb_rc(clk, reset, init, out);
    input clk, reset;
    input [3:0] init;
    output [3:0] out;

    wire [3:0] Q;
    wire [3:0] D;

    assign D[0] = Q[1];
    assign D[1] = Q[2];
    assign D[2] = Q[3];
    assign D[3] = Q[0]^Q[1];

    DFlipFlop d0 (D[0], clk, reset, init[0], Q[0]);
    DFlipFlop d1 (D[1], clk, reset, init[1], Q[1]);
    DFlipFlop d2 (D[2], clk, reset, init[2], Q[2]);
    DFlipFlop d3 (D[3], clk, reset, init[3], Q[3]);

    assign out = Q;
endmodule
