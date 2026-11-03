// Initial arithmetic block for the validation framework.
// Inputs are signed WIDTH-bit two's-complement values. The output is 2*WIDTH bits.
module signed_multiplier #(
    parameter int WIDTH = 8
) (
    input  logic signed [WIDTH-1:0]       a,
    input  logic signed [WIDTH-1:0]       b,
    output logic signed [(2*WIDTH)-1:0]   product
);
    localparam int PRODUCT_WIDTH = 2 * WIDTH;

    logic signed [PRODUCT_WIDTH-1:0] a_extended;
    logic signed [PRODUCT_WIDTH-1:0] b_extended;

    always_comb begin
        a_extended = {{WIDTH{a[WIDTH-1]}}, a};
        b_extended = {{WIDTH{b[WIDTH-1]}}, b};
        product = a_extended * b_extended;
    end
endmodule
