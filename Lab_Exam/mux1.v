/* 	
  * Simulation of 8 bit 4:1 MUX.
  * Simulated by :- Satyam Kumar <satyamkumar4@acm.org>
  * Repo:-  verilog [MIT LICENSE]
*/

module mux (
	output reg [7:0] out,
	input [7:0] a,b, c, d,	
	input [1:0] select);
	always @(*)
		begin
			case(select)
				3'b00: out = a;
				3'b01: out = b;
				3'b10: out = c;	
				3'b11: out = d;
			endcase
		end
endmodule

module wb();
	reg [1:0] sel;
	reg [7:0] a, b, c, d;
	wire [7:0] out;
	mux mu1(out, a, b, c, d, sel);
	initial
		begin
		$dumpfile("mux.vcd");
		$dumpvars(0, wb);
		{a} = {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1};
		{b} = {1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1};
		{c} = {1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
		{d} = {1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1};
			sel = {1'b0, 1'b0};
			#5 sel = {1'b0, 1'b1};
			#5 sel = {1'b1, 1'b0};
			#5 sel = {1'b1, 1'b1};
	end
	initial
		begin
			$monitor ($time,,, "a = %b b = %b,  c = %b,  d= %b , sel = %b, out = %b\n", a,b, c, d, sel, out);
		end
endmodule
				
