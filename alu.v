/* 	
  * Design of a 4 bit ALU that can do addition, substraction, and, or and not operations.
  *Author :- Satyam Kumar <satyamkumar4@acm.org>
  * Repo:-  verilog [MIT LICENSE]
*/



module HalfAdder (
	output sum, carry,
	input augend, addend, sub);
	wire p;
	xor(p, augend, sub);
	xor(sum, p, addend);
	and(carry, p, addend);
endmodule

module FullAdder (
	output sum, carry,
	input augend, addend, carry_in, sub);
	wire p, q, r;
	
	HalfAdder ha1(p, q, augend, addend, sub);
	HalfAdder ha2(sum, r, p, carry_in, sub);
	
	or(carry, q, r);
	
endmodule


module MyAdder (
	output[3:0] c,
	output carry,
	input [3:0] a, b,
	input sub);
	wire w1, w2, w3;
	FullAdder fadd1(c[0], w1, a[0], b[0], 1'b0, sub);
	FullAdder fadd2(c[1], w2, a[1], b[1], w1, sub);
	FullAdder fadd3(c[2], w3, a[2], b[2], w2, sub);
	FullAdder fadd4(c[3], carry, a[3], b[3], w3, sub);
endmodule

module MyAnd(
	output [3:0]  c,
	input [3:0] a, b);
	and(c[0], a[0], b[0]);
	and(c[1], a[1], b[1]);
	and(c[2], a[2], b[2]);
	and(c[3], a[3], b[3]);
endmodule

module MyOr (
	output [3:0] c,
	input [3:0] a, b);
	or(c[0], a[0], b[0]);
	or(c[1], a[1], b[1]);
	or(c[2], a[2], b[2]);
	or(c[3], a[3], b[3]);
endmodule

module MyNot (
	output [3:0] b,
	input [3:0] a);
	not(b[0], a[0]);
	not(b[1], a[1]);
	not(b[2], a[2]);
	not(b[3], a[3]);
endmodule

module MyMux(
	output out,
	input s1, s2, s3, s4, s5,
	input [2:0] s);
	wire o1, o2, o3, o4, o5;	
	and(o1, ~s[0], ~s[1], ~s[2], s1);
	and(o2, s[0], ~s[1], ~s[2], s2);
	and(o3, ~s[0], s[1], ~s[2], s3);
	and(o4, s[0], s[1], ~s[2], s4);
	and(o5, ~s[0], ~s[1], s[2], s5);
	or(out, o1, o2, o3, o4, o5);
endmodule

module MyALU(
	output [3:0] s,
	output carry,
	input [2:0] op,
	input [3:0] a, b);
	
	wire [3:0] w1, w2, w3, w4, w5;
	wire w6, w7;
	MyAdder add(w1, w6, a, b, 1'b0);
	MyAdder sub(w2, w7, a, b, 1'b1);
	MyAnd mand(w3, a, b);
	MyOr mor(w4, a, b);
	MyNot mnot(w5, a);
	MyMux mux1(s[0], w1[0], w2[0], w3[0], w4[0], w5[0], op);
	MyMux mux2(s[1], w1[1], w2[1], w3[1], w4[1], w5[1], op);
	MyMux mux3(s[2], w1[2], w2[2], w3[2], w4[2], w5[2], op);
	MyMux mux4(s[3], w1[3], w2[3], w3[3], w4[3], w5[3], op);
	assign carry = ((~op[0] & w6) | (op[0] & w7));
endmodule

module Test (
	input [3:0] c,
	input carry,
	output reg[2:0] op,
	output reg [3:0] a, b);
	initial begin
		$monitor($time,,, "\n Opcode: %b A: %b B: %b Summ : %b carry: %b\n", op, a, b, c, carry);
		{op, a, b} = {3'd0, 4'd8, 4'd4};
		#02 op = 3'd1;
		#02 op = 3'd2;
		#02 op = 3'd3;
		#02 op = 3'd4;
	end
endmodule
	

module wb;
	wire [3:0]a,b,c, w1;
	wire [2:0] op;
	wire carry, c1;
	MyALU ALU(w1, carry, op, a, b);
	Test test(w1, carry, op,a, b);
endmodule
