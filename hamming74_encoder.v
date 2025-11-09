module hamming74_encoder(
	input wire [3:0] data_in,
	output wire [6:0] code_out 
);
	wire d1 = data_in[0];
	wire d2 = data_in[1];
	wire d3 = data_in[2];
	wire d4 = data_in[3];


	//parity bits (even parity)
	wire p1 = d1 ^ d2 ^ d4;
	wire p2 = d1 ^ d3 ^ d4;
	wire p4 = d2 ^ d3 ^ d4;

	//codeword: [P1 P2 D1 P4 D2 D3 D4]
	assign code_out = {d4, d3, d2, p4, d1, p2, p1};
endmodule
