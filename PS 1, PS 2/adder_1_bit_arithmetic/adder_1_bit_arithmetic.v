module adder_1_bit_arithmetic(
	input a,b,cin,
	output s,cout);

	assign {cout,s} = cin + a + b;

endmodule