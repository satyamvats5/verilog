/*
 * Simulate a D Flip-Flop.
 * Simulated By: Satyam Kumar. <satyamkumar4@acm.org>
 * REpo :- verilog  [MIT LICENSE]
*/

module DFF(
    output reg q,
    input      Rs, Pr,
    input      d, clk);

    always @( posedge clk ) begin
        if (Rs == 0)
            q <= 0;
        else if (Pr == 1)
            q <= 1;
        else
            q <= d;
    end
endmodule

module wb ;
	reg clk, d, res, pr;
	wire q;
	DFF df(q, res, pr, d, clk);
	initial begin
		$dumpfile("dff.vcd");
		$dumpvars(0, wb);
		clk = 0'b0;
		pr = 1'b0;
		res = 1'b1;
		d = 1'b0;
		
		
	end
	always #1 clk = ~clk;
	initial begin
		$monitor($time,,,"clk: %d, d : %d, q: %d res = %d\n", clk, d, q, res);
		#02 d = 1'b1;
		#02 res = 1'b0;
		#02 d = 1'b1;
		#04 $finish;
	end
endmodule
