/*
 * Simulate a COunter which will increment its value at negative edge of clock.
 * Simulated By: Satyam Kumar. <satyamkumar4@acm.org>
 * REpo :- verilog  [MIT LICENSE]
*/

module count (
	output reg [7:0] count,
	input clr, clk) ;
	always @(*)
		if(clr)
		count <= 0;
	always @(negedge clk) 
		count <= count + 1;
endmodule


module wb;
	reg clk, clr;
	wire [0:7] out;
	
	count counter(out, clr, clk);
	initial clk =  1'b0;

	always #5 clk = ~clk;
		
	initial 
		begin
			clr = 1'b1;
			#15 clr = 1'b0;
			#30 clr = 1'b1;
			#35 clr = 1'b0;
			#100 clr = 1'b1;
			#10 $finish;
		end
	initial 
		begin
			$dumpfile("counter.vcd");
			$dumpvars(0, wb);
			$monitor($time,,,"Count : %d\n", out);
	end
endmodule
