`timescale 1ns/1ps

module signed_multiplier #(
    parameter int WIDTH = 8
) (
    input  logic signed [WIDTH-1:0]     a,
    input  logic signed [WIDTH-1:0]     b,
    output wire  signed [(2*WIDTH)-1:0] product
);
    localparam int PRODUCT_WIDTH = 2 * WIDTH;

    wire signed [PRODUCT_WIDTH-1:0] a_extended;
    wire signed [PRODUCT_WIDTH-1:0] b_extended;

    assign a_extended = {{WIDTH{a[WIDTH-1]}}, a};
    assign b_extended = {{WIDTH{b[WIDTH-1]}}, b};
    assign product = a_extended * b_extended;
endmodule
