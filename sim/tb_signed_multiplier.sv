`timescale 1ns/1ps

module tb_signed_multiplier;
    localparam int WIDTH = 8;

    logic signed [WIDTH-1:0] a;
    logic signed [WIDTH-1:0] b;
    logic signed [(2*WIDTH)-1:0] product;

    signed_multiplier #(.WIDTH(WIDTH)) dut (
        .a(a),
        .b(b),
        .product(product)
    );

    task automatic check_case(
        input logic signed [WIDTH-1:0] lhs,
        input logic signed [WIDTH-1:0] rhs,
        input logic signed [(2*WIDTH)-1:0] expected,
        input string case_name
    );
        begin
            a = lhs;
            b = rhs;
            #1;
            if (product !== expected) begin
                $fatal(1, "FAIL %s: %0d * %0d produced %0d; expected %0d",
                       case_name, lhs, rhs, product, expected);
            end
            $display("PASS %s: %0d * %0d = %0d",
                     case_name, lhs, rhs, product);
        end
    endtask

    initial begin
        check_case(8'sd3,    8'sd4,    16'sd12,     "positive operands");
        check_case(-8'sd3,   8'sd4,   -16'sd12,     "negative lhs");
        check_case(8'sd3,   -8'sd4,   -16'sd12,     "negative rhs");
        check_case(-8'sd3,  -8'sd4,    16'sd12,     "two negative operands");
        check_case(8'sd0,  8'sd127,     16'sd0,     "zero operand");
        check_case(-8'sd128, 8'sd127, -16'sd16256,  "minimum times maximum");
        check_case(-8'sd128, -8'sd128, 16'sd16384,  "minimum times minimum");
        check_case(8'sd127, 8'sd127, 16'sd16129,    "maximum times maximum");

        $display("All signed multiplier cases passed.");
        $finish;
    end
endmodule
