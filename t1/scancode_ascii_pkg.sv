`ifndef SCANCODE_ASCII_PKG
`define SCANCODE_ASCII_PKG

package scancode_ascii_pkg;

    typedef enum logic [7:0] {
        SCANCODE_A          = 8'h1C,
        SCANCODE_B          = 8'h32,
        SCANCODE_C          = 8'h21,
        SCANCODE_D          = 8'h23,
        SCANCODE_E          = 8'h24,
        SCANCODE_F          = 8'h2B,
        SCANCODE_G          = 8'h34,
        SCANCODE_H          = 8'h33,
        SCANCODE_I          = 8'h43,
        SCANCODE_J          = 8'h3B,
        SCANCODE_K          = 8'h42,
        SCANCODE_L          = 8'h4B,
        SCANCODE_M          = 8'h3A,
        SCANCODE_N          = 8'h31,
        SCANCODE_O          = 8'h44,
        SCANCODE_P          = 8'h4D,
        SCANCODE_Q          = 8'h15,
        SCANCODE_R          = 8'h2D,
        SCANCODE_S          = 8'h1B,
        SCANCODE_T          = 8'h2C,
        SCANCODE_U          = 8'h3C,
        SCANCODE_V          = 8'h2A,
        SCANCODE_W          = 8'h1D,
        SCANCODE_X          = 8'h22,
        SCANCODE_Y          = 8'h35,
        SCANCODE_Z          = 8'h1A,

        SCANCODE_0          = 8'h45,
        SCANCODE_1          = 8'h16,
        SCANCODE_2          = 8'h1E,
        SCANCODE_3          = 8'h26,
        SCANCODE_4          = 8'h25,
        SCANCODE_5          = 8'h2E,
        SCANCODE_6          = 8'h36,
        SCANCODE_7          = 8'h3D,
        SCANCODE_8          = 8'h3E,
        SCANCODE_9          = 8'h46
    } scancode_t;

    typedef enum logic {
        PASS = 1,
        FAIL = 0
    } test_status_t;

    class scancode_test;
        logic [7:0] in;
        logic [7:0] out;
        logic [7:0] expected;

        function test_status_t check();
            return (expected === out) ? PASS : FAIL;
        endfunction

        function void print();
            $display("[%s] SCANCODE: %h | GOT: %h | EXPECTED %h",
                        check().name(), in, out, expected);
        endfunction
    endclass
endpackage

`endif