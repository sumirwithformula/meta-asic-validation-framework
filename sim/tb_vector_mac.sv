`timescale 1ns/1ps

module tb_vector_mac;
    logic [31:0] vector_a;
    logic [31:0] vector_b;
    logic signed [31:0] accumulator;
    logic signed [31:0] result;

    vector_mac dut (
        .vector_a(vector_a),
        .vector_b(vector_b),
        .accumulator(accumulator),
        .result(result)
    );

    task automatic check_case(
        input logic [31:0] a_value,
        input logic [31:0] b_value,
        input logic signed [31:0] accumulator_value,
        input logic signed [31:0] expected,
        input string case_name
    );
        begin
            vector_a = a_value;
            vector_b = b_value;
            accumulator = accumulator_value;
            #1;

            if (result !== expected) begin
                $fatal(1, "FAIL %s: got %0d, expected %0d",
                       case_name, result, expected);
            end

            $display("PASS %s: result = %0d", case_name, result);
        end
    endtask

    initial begin
        check_case(32'h04030201, 32'h04030201,
                   32'sd0, 32'sd30, "positive lanes");

        check_case(32'h04FD02FF, 32'hF807FA05,
                   32'sd100, 32'sd30, "mixed signed lanes");

        check_case(32'h00000000, 32'h7F80FF01,
                   -32'sd17, -32'sd17, "zero products");

        check_case(32'h80808080, 32'h80808080,
                   32'sd0, 32'sd65536, "minimum times minimum");

        check_case(32'h7F7F7F7F, 32'h7F7F7F7F,
                   32'sd0, 32'sd64516, "maximum times maximum");

        check_case(32'h80808080, 32'h80808080,
                   32'sd2147483647, -32'sd2147418113,
                   "32-bit wraparound");

        $display("All vector MAC cases passed.");
        $finish;
    end
endmodule
