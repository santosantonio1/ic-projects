/*
	Prof. Marlon Moraes
	marlon.moraes@pucrs.br
*/

`timescale 1ns/1ps

module divisor_clock_multiplexado_tb;

	const time	PERIOD_OSC			= 10ns;		// período de clock do oscilador.
	
	const real	ESCALA_TEMPO		= 1e-9;		// ajuste da escala de tempo para calculo do relatório.

	logic		tb_clk_in			= 1'b0;
	logic [1:0]	tb_selecao  		= 2'b00;
	logic		tb_clk_out;

	int			deboucer			= 0;
		
	// parâmetros para geração do relatório do transcript.
	real		per_calc 			= 0.0;		// período calculado.
	real		fator_calc			= 1;		// fator de divisão do clock calculado.
	real		freq_calc 			= 0.0;		// frequencia do clock calculado.
	real		tempo_alto_calc		= 100;		// tempo em nível lógico alto do clock calculado.
	real		duty_calc			= 100;		// duty cycle do clock calculado.
	
	real		sub_t1;							// registro do instante de tempo #1 da borda de subida. 
	real		sub_t2;							// registro do instante de tempo #2 da borda de subida.
	real		desc_t1;						// registro do instante de tempo #1 da borda de descida.
	real		desc_t2;						// registro do instante de tempo #2 da borda de descida.
	

	// instanciação do divisor de clock multiplexado.
	divisor_clock_multiplexado duv
	(
		.clk_in		(tb_clk_in),
		.selecao	(tb_selecao),
		.clk_out	(tb_clk_out)
	);
	

	// geração de um sinal de clock.
	always #(PERIOD_OSC/2) tb_clk_in = ~tb_clk_in;


	// registra o período de um ciclo de clock.
	always @(posedge tb_clk_out)
	begin
		sub_t1 	<= $time;
		sub_t2 	<= sub_t1;
		per_calc 	<= (sub_t1 - sub_t2);
	end
	
	// calcula o fato de divisão do clock do sinal de saída.
	always @(per_calc)
	begin
		fator_calc <= per_calc / PERIOD_OSC;
	end
	
	// calcula a frequencia do sinal de saída.
	always @(per_calc)
	begin
		freq_calc <= 1 / (per_calc * 1e-9);
	end
	
	// registra o tempo do sinal em nível lógico alto.
	always @(negedge tb_clk_out or posedge tb_clk_out)
	begin
		desc_t1 		<= $time;
		desc_t2 		<= desc_t1;
		tempo_alto_calc <= (desc_t1 - desc_t2);
	end

	// calcula o duty cycle do sinal de saída.
	always @(per_calc)
	begin
		duty_calc 	<= (tempo_alto_calc / per_calc) * 100;
 	end


	// geração do relatório no transcript.
	always @(posedge tb_clk_out)
	begin

		if (deboucer < 5)
			deboucer <= deboucer + 1;
		else begin
			deboucer <= 0;	
							
			if (tb_selecao == 0) begin
				$display("--------------------------------------------------------------------------");
				$display("selecao		Fator		Periodo[ns]		Frequencia[Hz]		Duty[%%]");	
				$display("--------------------------------------------------------------------------");
			end
			
			$display("%2b		%.0f		%.2f		%.1f		%.1f", tb_selecao, fator_calc, per_calc, freq_calc, duty_calc);

			if (tb_selecao < 3)
				tb_selecao <= tb_selecao + 1;
			else begin			
				tb_selecao <= 0;
				$display("--------------------------------------------------------------------------");
				$finish;
			end
		end	
	end
	

endmodule