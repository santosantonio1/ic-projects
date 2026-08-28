`include "scancode_ascii_pkg.sv"

module decoder_scancode_ascii_tb (

);

    logic [7:0] scancode_in;
    logic [7:0] ascii_out;
    logic [7:0] ascii_out_g;

    decoder_scancode_ascii cuv (
        .scancode_in(scancode_in),
        .ascii_out(ascii_out)
    );

    decoder_scancode_ascii_g cuv_g (
        .scancode_in(scancode_in),
        .ascii_out(ascii_out_g)
    );

    localparam int N_LETTERS = 26, N_DIGITS = 10, N_SYMBOLS = 16;

    logic [7:0] symbols [N_SYMBOLS] = '{
        8'h0E, // `
        8'h0D, // tab
        8'h29, // space
        8'h41, // ,
        8'h49, // .
        8'h4A, // /
        8'h4C, // ;
        8'h4E, // -
        8'h52, // '
        8'h54, // [
        8'h55, // =
        8'h5A, // enter
        8'h5B, // ]
        8'h5D, // \
        8'h66, // backspace
        8'h76  // esc
    }; // expect 0xFF

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

            status = (ascii_out === ascii_out_g) ? "PASS" : "FAIL";
            if (ascii_out === ascii_out_g) score++;

            $display("[%s] SCANCODE: %h | EXPECTED %s | GOT: %s", 
                        status, sc, ascii_out_g, ascii_out);
                        
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

            status = (ascii_out === ascii_out_g) ? "PASS" : "FAIL";
            if (ascii_out === ascii_out_g) score++;

            $display("[%s] SCANCODE: %h | EXPECTED %s | GOT: %s", 
                        status, sc, ascii_out_g, ascii_out);
                        
            sc = sc.next();
        end

        $display("[SCORE]: %d/%0d", score, N_DIGITS);
        $display("---------------------------------------------------");

        total += score;
        score = 0;

        // symbols test
        for (int i = 0; i < N_SYMBOLS; i++) begin
            scancode_in = symbols[i];
            expected    = SCANCODE_DEFAULT;

            #5;

            status = (ascii_out === ascii_out_g) ? "PASS" : "FAIL";
            if (ascii_out === ascii_out_g) score++;

            $display("[%s] SCANCODE: %h | EXPECTED %h | GOT: %h", 
                        status, symbols[i], ascii_out_g, ascii_out);
        end

        total += score;

        $display("[SCORE]: %d/%0d", score, N_SYMBOLS);
        $display("---------------------------------------------------");

        $display("[TOTAL SCORE]: %d/%0d", total, N_LETTERS + N_DIGITS + N_SYMBOLS);

        $finish;
    end

endmodule