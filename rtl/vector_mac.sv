`timescale 1ns/1ps

module vector_mac (
    input  logic [31:0]        vector_a,
    input  logic [31:0]        vector_b,
    input  logic signed [31:0] accumulator,
    output logic signed [31:0] result
);
    logic signed [15:0] products [0:3];
    logic signed [31:0] sum;

    genvar lane;
    generate
        for (lane = 0; lane < 4; lane = lane + 1) begin : gen_lane
            wire signed [7:0] lane_a;
            wire signed [7:0] lane_b;

            assign lane_a = vector_a[(lane * 8) +: 8];
            assign lane_b = vector_b[(lane * 8) +: 8];

            signed_multiplier #(.WIDTH(8)) multiplier (
                .a(lane_a),
                .b(lane_b),
                .product(products[lane])
            );
        end
    endgenerate

    always_comb begin
        sum = accumulator;
        for (int i = 0; i < 4; i = i + 1) begin
            sum = sum + {{16{products[i][15]}}, products[i]};
        end
        result = sum;
    end
endmodule
