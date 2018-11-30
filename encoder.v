/*
 * Simulate a 8 : 3 encoder.
 * Simulated By: Satyam Kumar. <satyamkumar4@acm.org>
 * REpo :- verilog  [MIT LICENSE]
*/

module Encoder( 
	output a1, a2, a3, 
	input b1, b2, b3, b4, b5, b6, b7, b8);

	assign a1 = b1 | b3 | b5 | b7;
	assign a2 = b2 | b3 | b6 | b7;
	assign a3 = b4 | b5 | b6 | b7;
	
endmodule

module Test(
	output reg b1, b2, b3, b4, b5, b6, b7, b8,
	input a1, a2, a3);
	
	wire [7:0] inp;
	assign inp = {b1, b2, b3, b4, b5, b6, b7, b8};
	initial begin 
		$dumpfile ("encoder.vcd");
		$dumpvars (0, Test);
		$monitor($time,, "IP = %b A1 = %b A2 = %b A3 = %b", inp, a1, a2, a3);
		{ b8, b7, b6, b5, b4, b3, b2, b1 } = { 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
        	#2 { b8, b7, b6, b5, b4, b3, b2, b1} = { 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
        	#2 { b8, b7, b6, b5, b4, b3, b2, b1 } = { 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
        	#2 { b8, b7, b6, b5, b4, b3, b2, b1 } = { 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0 };
        	#2 { b8, b7, b6, b5, b4, b3, b2, b1 } = { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };
        	#5 { b8, b7, b6, b5, b4, b3, b2, b1 } = { 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0 };
        	#2 { b8, b7, b6, b5, b4, b3, b2, b1 } = { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0 };
		#2 $finish;
	end
endmodule

module wb();
	wire a1, a2, a3, b1, b2, b3, b4, b5, b6, b7, b8;
	Encoder enc(a1, a2, a3, b1, b2, b3, b4, b5, b6, b7, b8);
	Test test(b1, b2, b3, b4, b5, b6, b7, b8, a1, a2, a3);
endmodule
