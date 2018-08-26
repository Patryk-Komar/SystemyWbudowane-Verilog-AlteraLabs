module adder_1_bit_primitive(
	input a,b,cin,
	output s,cout);

	wire x,y,z;
	
	xor (x,a,b);
	xor (s,x,cin);
	and (y,x,cin);
	and (z,a,b);
	or (cout,y,z);
 
endmodule