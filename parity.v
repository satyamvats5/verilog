/*
  * Simulation of a parity checker using finite machine.
  * Simulated By :- Satyam Kumar <satyamkumar4@acm.org>
  * Repo :- verilog [MIT LICENSE]
*/


module parity (x, clk, z, ev);
	input x, clk;
	output reg z, ev;
	parameter EVEN = 0, ODD = 1;
	reg even_odd;
	always @(posedge clk) 
		case(even_odd)
			EVEN:
				begin
					z <= x ? 1 : 0;
					even_odd <= x ? ODD : EVEN;
					ev = even_odd;
				end
			ODD:
				begin
					z <= x ? 0 : 1;
					even_odd <= x ? EVEN : ODD;
					ev = even_odd;
				end
			default 
				begin
				even_odd = EVEN;
				ev = even_odd;
			end
		endcase
endmodule

module wb;
	reg x, clk;
	wire z, ev;
	parity par(x, clk, z, ev);
	
	initial begin
		$dumpfile("parity.vcd");
		$dumpvars(0, wb);
		clk = 1'b0;
	end
	always  #5 clk = ~clk;
	initial begin
		#2 x = 0;
		#10 x = 1;
		#10 x = 1; #10 x = 1;
		#10 x = 0;
		#10 x = 1;
		#10 $finish;
	end
	initial begin
		$monitor($time,,,"input : %b, output: %b, state: %b, clk : %b\n", x, z, ev, clk);
	end
endmodule
