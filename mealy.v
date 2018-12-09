/*
 * Simulate a Mealy machine which will check for 1010 input string.
 * Simulated By: Satyam Kumar. <satyamkumar4@acm.org>
 * Repo :- verilog  [MIT LICENSE]
*/


module mealy(x, clk, reset, z);
	input x, clk, reset;
	output reg z;
	parameter A = 0, B = 1, C = 2, D =  3;
	reg [0:1] PS, NS;
	always @(posedge clk or posedge reset)
		if(reset) PS <= A;
		else PS <= NS;
	always @(PS, x) 
		case (PS)
			A : begin
				z = 0;
				NS = x ? B : A;
			end
			B : begin
				z = 0;
				NS = x ? B : C;
			end
			C : begin
				z = 0;
				NS = x ? D : A;
			end
			D : begin 
				z = x ? 0 : 1;
				NS = x ? B : C;
			end
		endcase
endmodule

module wb;
	output reg x, clk, reset;
	wire out;
	mealy mly(x, clk, reset, out);
	initial begin 
		$dumpfile("mealy.vcd");
		$dumpvars(0, wb);
		clk = 1'b0;
		reset = 1'b1;
		#15 reset = 1'b0;
	end
	always #5  clk = ~clk;
	initial begin
		#12 x = 0; 
		#10 x = 0; 
		#10 x = 1; 
		#10 x = 0; 
		#10 x = 1; 
		#10 x = 0; 
		#10 x = 1; 
		#10 x = 0;
		#10 x = 0; 
		#10 x = 1; 
		#10 x = 1; 
		#10 x = 0;
		#10 $finish;
	end
endmodule
	
