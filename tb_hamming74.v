`timescale 1ns/1ps
module tb_hamming74;
	reg [3:0] data;
	wire [6:0] encoded;
	wire [2:0] syndrome;
	wire error_detected;
	wire [6:0] corrected;
	reg [6:0] code_err;

	hamming74_encoder enc(.data_in(data), .code_out(encoded));
	hamming74_checker chk(.code_in(encoded), .syndrome(syndrome), .error_detected(error_detected), .corrected_code(corrected));

	initial begin
		$display("DATA CODEWORD ERROR? SYNDROME CORRECTED");
		data = 4'b1010; #5;
		$display("%b %b %b %b %b", data, encoded, error_detected, syndrome, corrected);

		//simulate a 1-bit error: flip bit 3
		code_err = encoded;
		code_err[2] = code_err[2];
		#5;
		$display("Injected error at bit 3:");
		$display("Code_in=%b Syndrome=%b Corrected=%b", code_err, syndrome, corrected);

		$finish;
	end
endmodule
