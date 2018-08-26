module master_slave_D(
	input [1:0] SW,
	output [0:0] LEDR);
	
	(* KEEP = "TRUE" *) wire [1:0] firstLatchInput;
	
	assign firstLatchInput[0] = SW[0];
	assign firstLatchInput[1] = ~SW[1];
	
	(* KEEP = "TRUE" *) wire firstLatchOutput;
	
	latch_D latchOne(firstLatchInput,firstLatchOutput);
	
	(* KEEP = "TRUE" *) wire [1:0] secondLatchInput;
	
	assign secondLatchInput[0] = firstLatchOutput;
	assign secondLatchInput[1] = SW[1];
	
	(* KEEP = "TRUE" *) wire secondLatchOutput;
	
	latch_D latchTwo(secondLatchInput,secondLatchOutput);
	
	assign LEDR[0] = secondLatchOutput;
	
endmodule