module hamming74_checker(
	input wire [6:0] code_in,
	output wire [2:0] syndrome,
	output wire error_detected,
	output wire [6:0] corrected_code
);

	wire p1 = code_in[0];
	wire p2 = code_in[1];
	wire d1 = code_in[2];
	wire p4 = code_in[3];
	wire d2 = code_in[4];
	wire d3 = code_in[5];
	wire d4 = code_in[6];

	//recompute parity checks (even parity)
	wire c1 = p1 ^ d1 ^ d2 ^ d4;
	wire c2 = p2 ^ d1 ^ d3 ^ d4;
	wire c3 = p4 ^ d2 ^ d3 ^ d4;
	
	//syndrome = binary value of error position
	assign syndrome = {c3, c2, c1};
	assign error_detected = |syndrome;

	//correct error by flipping bit at syndrome index
	reg[6:0] temp;
	always @(*) begin
		temp = code_in;
		if(error_detected)
			temp[syndrome-1] = ~temp[syndrome-1];
	end

	assign corrected_code = temp;
endmodule
