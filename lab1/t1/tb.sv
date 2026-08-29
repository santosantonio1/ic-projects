`include "scancode_ascii_pkg.sv"

module decoder_scancode_ascii_tb (

);

    logic [7:0] scancode_in;
    logic [7:0] ascii_out;
    logic [7:0] ascii_out_golden;

    decoder_scancode_ascii_golden golden (
        .scancode_in(scancode_in),
        .ascii_out(ascii_out_golden)
    );
    decoder_scancode_ascii dut (
        .scancode_in(scancode_in),
        .ascii_out(ascii_out)
    );

    localparam int N_LETTERS = 26, N_DIGITS = 10;
    scancode_t sc;
    int score;
    int total;

    initial begin
        string status;

        sc = SCANCODE_A; // sc.first();
        score = 0;
        total = 0;
        
        // characters test
        for (int i = 0; i < N_LETTERS; i++) begin
            scancode_in = sc;

            #5;

            status = (ascii_out === ascii_out_golden) ? "PASS" : "FAIL";
            if (ascii_out === ascii_out_golden) score++;

            $display("[%s] SCANCODE: %h | EXPECTED %s | GOT: %s", 
                        status, sc, ascii_out_golden, ascii_out);
                        
            sc = sc.next();
        end

        $display("[SCORE]: %d/%0d", score, N_LETTERS);
        $display("---------------------------------------------------");

        sc = SCANCODE_0;
        total += score;
        score = 0;

        // numbers test
        for (int i = 0; i < N_DIGITS; i++) begin
            scancode_in = sc;

            #5;

            status = (ascii_out === ascii_out_golden) ? "PASS" : "FAIL";
            if (ascii_out === ascii_out_golden) score++;

            $display("[%s] SCANCODE: %h | EXPECTED %s | GOT: %s", 
                        status, sc, ascii_out_golden, ascii_out);
                        
            sc = sc.next();
        end

        total += score;

        $display("[SCORE]: %d/%0d", score, N_DIGITS);
        $display("---------------------------------------------------");
        $display("[TOTAL SCORE]: %d/%0d", total, N_LETTERS + N_DIGITS );

        $finish;
    end

endmodule