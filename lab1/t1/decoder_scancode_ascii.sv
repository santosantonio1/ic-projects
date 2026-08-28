`include "scancode_ascii_pkg.sv"

module decoder_scancode_ascii_golden (
    input  logic [7:0] scancode_in,
    output logic [7:0] ascii_out
);

    always_comb begin
        unique case (scancode_in)
            SCANCODE_A: ascii_out = "A";
            SCANCODE_B: ascii_out = "B";
            SCANCODE_C: ascii_out = "C";
            SCANCODE_D: ascii_out = "D";
            SCANCODE_E: ascii_out = "E";
            SCANCODE_F: ascii_out = "F";
            SCANCODE_G: ascii_out = "G";
            SCANCODE_H: ascii_out = "H";
            SCANCODE_I: ascii_out = "I";
            SCANCODE_J: ascii_out = "J";
            SCANCODE_K: ascii_out = "K";
            SCANCODE_L: ascii_out = "L";
            SCANCODE_M: ascii_out = "M";
            SCANCODE_N: ascii_out = "N";
            SCANCODE_O: ascii_out = "O";
            SCANCODE_P: ascii_out = "P";
            SCANCODE_Q: ascii_out = "Q";
            SCANCODE_R: ascii_out = "R";
            SCANCODE_S: ascii_out = "S";
            SCANCODE_T: ascii_out = "T";
            SCANCODE_U: ascii_out = "U";
            SCANCODE_V: ascii_out = "V";
            SCANCODE_W: ascii_out = "W";
            SCANCODE_X: ascii_out = "X";
            SCANCODE_Y: ascii_out = "Y";
            SCANCODE_Z: ascii_out = "Z";
            
            SCANCODE_0: ascii_out = "0";
            SCANCODE_1: ascii_out = "1";
            SCANCODE_2: ascii_out = "2";
            SCANCODE_3: ascii_out = "3";
            SCANCODE_4: ascii_out = "4";
            SCANCODE_5: ascii_out = "5";
            SCANCODE_6: ascii_out = "6";
            SCANCODE_7: ascii_out = "7";
            SCANCODE_8: ascii_out = "8";
            SCANCODE_9: ascii_out = "9";

            default:    ascii_out = SCANCODE_DEFAULT; 
        endcase
    end

endmodule