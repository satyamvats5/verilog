/*
 * Simulate a behavioral design of 8 bit adder.
 * Simulated By: Satyam Kumar. <satyamkumar4@acm.org>
 * REpo :- verilog  [MIT LICENSE]
*/

module adder(X1, X2, out, Cy);
	input [7:0] X1,X2;
	output [7:0] out;
	output Cy;
//	assign cy = 0;

	assign {Cy,out}=X1+X2;

endmodule

module test(
		output reg [0:7] X1, X2, 
		input [0:7] out, 
		input Cy);
		initial begin
			$monitor( $time,,, "X1: %d,    X2: %d   Cy: %b    out: %d", X1, X2, Cy, out);
			#5 X1= 10; X2=5;
	                #5 X1 = 5; X2 = 6;
        	        #5 X1 = 20; X2 = 15;
               		#5 X1 = 8; X2 = 7;
			#5 X1 = 255; X2 = 128;

                	#5 $finish;
		end
endmodule

			

module TB;
	wire [7:0] X1,X2;

	wire [7:0] out;
	wire Cy;

	adder MyFulladder(X1,X2,out,Cy);
	test tes(X1, X2, out, Cy);

	initial
	begin
		$dumpfile("Fulladder.vcd");
		$dumpvars(0,TB);
	end

endmodule
