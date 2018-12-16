/*
  * Simulation of a multiplier using data path and controller.
  * Simulated By :- Satyam Kumar <satyamkumar4@acm.org>
  * Repo :- verilog [MIT LICENSE]
*/

module PIP01 (dout, din, clk, Id);
	input [15:0] din;
	input clk, Id;
	output reg[15:0] dout;
	always @(posedge clk)
		if(Id)
			dout <= din;
endmodule
module PIP02 (dout, din, Id, clr, clk);
	input [15:0] din;
        input clk, Id, clr;
        output reg[15:0] dout;
        always @(posedge clk)
                if(Id)
                        dout <= din;
		else if(clr)
			dout <= 16'b0;
endmodule
module ADD(out, in1, in2);
	input [15:0] in1, in2;
	output reg [15:0] out;
	always @(*)
		out = in1 + in2;
endmodule
module EQZ(eqz, data);
	input [15:0] data;
	output eqz;
	assign eqz= ( data==0 );
endmodule
module CNTR (dout, din, Id, dec, clk);
	input [15:0] din;
	input Id, clk, dec;
	output reg [15:0] dout;
	always @(posedge clk)
		if(Id)
			dout <= din - 1;
		else if(dec)
			dout <= dout-1;
endmodule
module controller (lda, ldb, ldp, clrp, decb, done, clk, eqz, start);
	input  clk, eqz, start;
	output reg lda, ldb, ldp, clrp, decb, done;
	reg [2:0] state;
	parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100;
	always @(posedge clk)
	begin
		case(state)
			s0: if(start) state <= s1;
			s1: state <= s2;
			s2: state <= s3;
			s3: #2 if(eqz) state <= s4;
			s4: state <= s4;
			default: state <= s0;
		endcase
	end

	always @(state)
	begin
		case(state)
			s0: begin #1 lda =0; ldb = 0; ldp = 0; clrp =0; decb =0; done = 0; end
			s1: begin #1 lda =1;end
			s2: begin #1 lda =0; ldb = 1; clrp = 1; end
			s3: begin #1 ldb=0; ldp =1; clrp= 0; decb=1; end
			s4: begin #1 done =1; ldb =0; ldp = 0; decb =0; end
			default: begin #1 lda = 0; ldb = 0; ldp = 0; clrp = 0; decb = 0; end
		endcase
	end
endmodule

module mul_data(eqz, lda, ldb, ldp, clrp, decb, data_in, clk);
	input lda, ldb, ldp, clrp, decb, clk;
	input [15:0] data_in;
	output eqz;
	wire [15:0] x, y, z, bout, bus;
	assign bus = data_in;
	//assign x  = data_in;

	PIP01 A(x, bus, lda, clk);
	PIP02 P(y, z, ldp, clrp, clk);
	CNTR B(bout, bus, ldb, decb, clk);
	ADD AD(z, x, y);
	EQZ COMP(eqz, bout);
endmodule

module mul_test;
	reg [15:0] data_in;
	reg clk, start;
	wire done;

	mul_data dp(eqz, lda, ldb, ldp, clrp, decb, data_in, clk);
	controller con(lda, ldb, ldp, clrp, decb, done, clk, eqz, start);
	initial
	begin
		clk = 1'b0;
		#3 start = 1'b1;
		#500 $finish;
	end
	always #5 clk = ~clk;
	initial
	begin
		#14 data_in = 17; 
		
		#13 data_in = 5;
	end

	initial
	begin
		$monitor ($time,"  x: %b  , y: %d   , z: %d Status: %b ",dp.x, dp.y, dp.z, done);
		$dumpfile("mul.vcd");
		$dumpvars(0,mul_test);
	end
endmodule
