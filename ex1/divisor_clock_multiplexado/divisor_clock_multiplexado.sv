/*
	Prof. Marlon Moraes
	marlon.moraes@pucrs.br
*/

module divisor_clock_multiplexado
#
(
	parameter int	DIV1 = 20_000,
	parameter int	DIV2 = 4_000,
	parameter int	DIV3 = 500_000,
	parameter int	DIV4 = 20_000,
	
	parameter int	DUTY1 = 25,
	parameter int	DUTY2 = 40,
	parameter int	DUTY3 = 80,
	parameter int	DUTY4 = 15
)
(
	input	logic		clk_in,
	input	logic [1:0]	selecao,
	output	logic		clk_out
);

	logic clk_A;
	logic clk_B;
	logic clk_C;
	logic clk_D;


	// instanciação do divisor de clock.
	divisor_clock #(.DIVISOR(DIV1), .DUTY_CYCLE(DUTY1)) divisor_clock_1
	(
		.clk_in		(clk_in),
		.clk_out	(clk_A)
	);
	
	// instanciação do divisor de clock.
	divisor_clock #(.DIVISOR(DIV2), .DUTY_CYCLE(DUTY2)) divisor_clock_2
	(
		.clk_in		(clk_in),
		.clk_out	(clk_B)
	);
	
	// instanciação do divisor de clock.
	divisor_clock #(.DIVISOR(DIV3), .DUTY_CYCLE(DUTY3)) divisor_clock_3
	(
		.clk_in		(clk_in),
		.clk_out	(clk_C)
	);

	// instanciação do divisor de clock.
	divisor_clock #(.DIVISOR(DIV4), .DUTY_CYCLE(DUTY4)) divisor_clock_4
	(
		.clk_in		(clk_in),
		.clk_out	(clk_D)
	);

	// multiplexador.
	always_comb
	begin
		case (selecao)
			2'b00:	clk_out = clk_A;
			2'b01:	clk_out = clk_B;
			2'b10:	clk_out = clk_C;
			2'b11:	clk_out = clk_D;
			default:clk_out = 1'b0;
		endcase
	end 


endmodule