/* 	
  *Structural implementation of 8:1 mux.
  *Author :- Satyam Kumar <satyamkumar4@acm.org>
  * Repo:-  verilog [MIT LICENSE]
*/

module And(
		output o1, 
		input i1, i2, i3, i4);
			wire w1, w2;
			and(w1, i1, i2);
			and(w2, i3, i4);
			and(o1, w1, w2);
endmodule

module Or(
	output o1,
	input i1, i2, i3, i4, i5, i6, i7, i8);
		wire w1, w2, w3, w4, w5, w6;
		or(w1, i1, i2);
		or(w2, i3, i4);
		or(w3, i5, i6);
		or(w4, i7, i8);
		or(w5, w1, w2);
		or(w6, w3, w4);
		or(o1, w5, w6);
endmodule

module Test(
	output reg s1, s2, s3, b1, b2, b3, b4, b5, b6, b7, b8,
	input i1);
	wire [7:0] d;
	wire [2:0] s;
	assign d = {b1, b2, b3, b4, b5, b6, b7, b8};
	assign s = {s1, s2, s3};
	initial begin 
		$dumpfile ("mux.vcd");
                $dumpvars (0, Test);
		$monitor($time,, "D = %b s = %b out = %b", d, s, i1);
		{s1, s2, s3} = {1'b0,  1'b0, 1'b0};
		{b1, b2, b3, b4, b5, b6, b7, b8} = {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1};
		#5 {s1, s2, s3} = {1'b0, 1'b0, 1'b1};
		#5 {s1, s2, s3} = {1'b0, 1'b1, 1'b0};
		#5 {s1, s2, s3} = {1'b0, 1'b1, 1'b1};
		#5 {s1, s2, s3} = {1'b1, 1'b0, 1'b0};
		#5 {s1, s2, s3} = {1'b1, 1'b0, 1'b1};
		#5 {s1, s2, s3} = {1'b1, 1'b1, 1'b0};
		#5 {s1, s2, s3} = {1'b1, 1'b1, 1'b1};
		#5 $finish;
	end
endmodule

module Mux(
	output a1,
	input b1, b2, b3, b4, b5, b6, b7, b8, s1, s2, s3);
	
	wire w1, w2, w3, w4, w5, w6, w7, w8, ns1, ns2, ns3;
	not(ns1, s1);
	not(ns2, s2);
	not(ns3, s3);
	And ag1(w1, b1, ns1, ns2, ns3);
	And ag2(w2, b2, ns1, ns2, s3);
	And ag3(w3, b3, ns1, s2, ns3);
	And ag4(w4, b4, ns1, s2, s3);
	And ag5(w5, b5, s1, ns2, ns3);
	And ag6(w6, b6, s1, ns2, s3);
	And ag7(w7, b7, s1, s2, ns3);
	And ag8(w8, b8, s1, s2, s3);
	Or or1(a1, w1, w2, w3, w4, w5, w6, w7, w8);
endmodule

module sat();
	wire a1, b1, b2, b3, b4, b5, b6, b7, b8, s1, s2, s3;
	Mux mu(a1, b1, b2, b3, b4, b5, b6, b7, b8, s1, s2, s3);
	Test test(s1, s2, s3, b1, b2, b3, b4, b5, b6, b7, b8, a1);
endmodule
	
