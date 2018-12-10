/*
 * Simulate a Morey machine which will check for 1010 input string.
 * Simulated By: Satyam Kumar. <satyamkumar4@acm.org>
 * REpo :- verilog  [MIT LICENSE]
*/


module Moore(x, clk, reset, y);
 	input x, clk, reset;
	output reg y;
	parameter A = 0, B = 1, C = 2, D = 3, E = 4;
	reg [2:0] ps, ns;
	always@(posedge clk, posedge reset)
		begin
			if(reset)
				ps <= A;
			else
			ps <= ns;
		end
	always@(ps, x)
		begin
			case(ps)
				A: ns = x ? B : A;
				B: ns = x ? B : C;
				C: ns = x ? D : A;
				D: ns = x ? B : E;
				E: ns = x ? D : A;
			default: ps = A;
		endcase
	end
	always@(ps)
		begin
		case(ps)
			A: y = 0;
			B: y = 0;
			C: y = 0;
			D: y = 0;
			E: y = 1;
		endcase
	end
endmodule

module TB;
	reg x, clk, reset;
	wire y;
	Moore dut(x, clk, reset, y);
	initial 
		begin
			$dumpfile("Moor.vcd"); 
			$dumpvars(0,TB);
	end
	
	always #5 clk = ~clk;

	initial begin
		#10 clk = 1'b0; 
		    reset = 1'b1;
		#12 reset=1'b0;
		#8 x=1; 
		#10 x=0;
		#10 x=1; 
		#10 x=0;
		#10 x=0; 
		#10 x=0; 
		#10 x=1; 
		#10 x=0;
		#10 x=1; 
		#10 x=0; 
		#10 x=1; 
		#10 x=0; 
		#10 x=1; 
		#10 x=0;
		#10 $finish;
	end
endmodule
