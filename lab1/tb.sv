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

    decoder_scancode_ascii_golden golden (
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

    typedef enum logic {
        PASS = 1,
        FAIL = 0
    } test_status_t;

    int score;
    int total;

    task automatic checker(input logic [7:0] a, input logic [7:0] b, output test_status_t status);
        #5;
        status = (a === b) ? PASS : FAIL;
    endtask

    task automatic run_character_test(ref logic [7:0] in, ref logic [7:0] golden, ref logic [7:0] out);
        scancode_t sc = SCANCODE_A;
        test_status_t status;
        int total = 0;
        for (int i = 0; i < N_LETTERS; i++) begin
            checker(golden, out, status);
            $display("[%s] SCANCODE: %h | EXPECTED %s | GOT: %s", status.name(), sc, golden, out);
            sc = sc.next();
            total += status;
        end
        #5;
    endtask

    initial begin

        run_character_test(scancode_in, ascii_out_g, ascii_out);
//         string status;

//         sc = SCANCODE_A; // sc.first();
//         score = 0;
//         total = 0;
        
//         // characters test
//         for (int i = 0; i < N_LETTERS; i++) begin
//             scancode_in = sc;

//             #5;

//             status = (ascii_out === ascii_out_g) ? "PASS" : "FAIL";
//             if (ascii_out === ascii_out_g) score++;

//             $display("[%s] SCANCODE: %h | EXPECTED %s | GOT: %s", 
//                         status, sc, ascii_out_g, ascii_out);
                        
//             sc = sc.next();
//         end

//         $display("[SCORE]: %d/%0d", score, N_LETTERS);
//         $display("---------------------------------------------------");

//         sc = SCANCODE_0;
//         total += score;
//         score = 0;

//         // numbers test
//         for (int i = 0; i < N_DIGITS; i++) begin
//             scancode_in = sc;

//             #5;

//             status = (ascii_out === ascii_out_g) ? "PASS" : "FAIL";
//             if (ascii_out === ascii_out_g) score++;

//             $display("[%s] SCANCODE: %h | EXPECTED %s | GOT: %s", 
//                         status, sc, ascii_out_g, ascii_out);
                        
//             sc = sc.next();
//         end

//         $display("[SCORE]: %d/%0d", score, N_DIGITS);
//         $display("---------------------------------------------------");

//         total += score;
//         score = 0;

//         // symbols test
//         for (int i = 0; i < N_SYMBOLS; i++) begin
//             scancode_in = symbols[i];
// z
//             #5;

//             status = (ascii_out === ascii_out_g) ? "PASS" : "FAIL";
//             if (ascii_out === ascii_out_g) score++;

//             $display("[%s] SCANCODE: %h | EXPECTED %h | GOT: %h", 
//                         status, symbols[i], ascii_out_g, ascii_out);
//         end

//         total += score;

//         $display("[SCORE]: %d/%0d", score, N_SYMBOLS);
//         $display("---------------------------------------------------");

//         $display("[TOTAL SCORE]: %d/%0d", total, N_LETTERS + N_DIGITS + N_SYMBOLS);

//         $finish;
    end

endmodule