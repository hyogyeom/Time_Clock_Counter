`timescale 1ns / 1ps

module digit_divider_sec_msec(
    input[5:0] i_sec,
    input[9:0] i_msec,
    output[3:0] o_sec_10, o_sec_1, o_msec_10, o_msec_1
    );

    assign o_sec_10 = i_sec / 10 % 10;
    assign o_sec_1  = i_sec % 10;
    
    assign o_msec_10 = i_msec / 10 % 10;
    assign o_msec_1  = i_msec % 10;


    /*ab:cd 12:34

    i_sec_10 = i_a = 12 / 10 = 1, 1 % 10 = 1
    i_sec_1  = i_b = 12 % 10 = 2
    i_msec_10  = i_c = 34 / 10 = 3, 3 % 10 = 3
    i_msec_1   = i_d = 34 % 10 = 4
    12 : 34 출력. 
    */

endmodule

