include "mux1bit2to1.v";
include "mux1bit4to1.v";

module alu(a, b, cin, less, op, result, generate1, propagate, fa, cout, set);

input a, b, cin, less;
input [2:0] op;
output result, generate1, propagate, fa, cout, set;

wire [2:0] op;
wire a, b;

mux1bit2to1 instance1(a, ~a, op[0], result1);
mux1bit2to1 instance2(b, ~b, op[1], result2);

assign generate1 = result1 & result2;

assign propagate = result1 | result2;

assign fa = (result1 ^ result2 ^ cin);

assign cout = (result1 & result2) | ((result1 ^ result2)&cin);

new instance3(generate1, propagate, fa, less, op[0], op[1], result);

reg f;
always @(result or set)
begin
if (result == 0)
    assign f = 0;
end

assign set = f;
 
endmodule

