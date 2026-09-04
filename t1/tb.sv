`include "scancode_ascii_pkg.sv"

module decoder_scancode_ascii_tb 
    import scancode_ascii_pkg::*;
(
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

    logic [7:0] symbols [16] = '{
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

    scancode_test tests[$];

    function automatic void build_tests(ref scancode_test tests[$]);
        scancode_t sc = sc.first();
        scancode_test t;

        repeat(sc.num()) begin
            t = new();
            t.in = sc;
            tests.push_back(t);

            sc = sc.next();
        end

        foreach (symbols[i]) begin
            t = new();
            t.in = symbols[i];
            tests.push_back(t);
        end

    endfunction

    logic status;
    int score;

    initial begin
        build_tests(tests);

        score = 0;

        foreach (tests[i]) begin
            scancode_in = tests[i].in;

            #5;

            tests[i].expected = ascii_out_golden;
            tests[i].out      = ascii_out;
            // tests[i].print();

            status = tests[i].check();

            if (!status) tests[i].print();

            score += status;

        end

        $display("[SCORE]: %d/%0d", score, tests.size());

        $finish;
    end

endmodule