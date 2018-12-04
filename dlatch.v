/*
 * Simulate a D-LATCH.
 * Simulated By: Satyam Kumar. <satyamkumar4@acm.org>
 * REpo :- verilog  [MIT LICENSE]
*/
module dl(e, d, q);
input e, d;
output q;
reg q;
always @ (e or d)
begin
	if(e)
		q = d;
end
endmodule

module TB;
	wire q;
	reg e, d;
	dl dut(e, d, q);

	initial begin
		$dumpfile("dlatch.vcd");
		$dumpvars(0, TB);
		$monitor ($time, " e = %b, d = %b, q = %b", e, d, q);
		#5 e = 1; 
		   d = 0;
		#4 d = 1;
		#5 e = 0;
		#4 d = 0;
		#10 $finish;
	end
endmodule


