`timescale 1ns / 1ps

module digit_divider_hour_min(
    input[5:0] i_hour, i_min,

    output[3:0] o_hour_10, o_hour_1, o_min_10, o_min_1
    );


    assign o_hour_10 = i_hour / 10 % 10;
    assign o_hour_1  = i_hour % 10;
    
    assign o_min_10 = i_min / 10 % 10;
    assign o_min_1  = i_min % 10;

    /*ab:cd 12:34

    o_hour_10 = o_a = 12 / 10 = 1, 1 % 10 = 1
    o_hour_1  = o_b = 12 % 10 = 2
    o_min_10  = o_c = 34 / 10 = 3, 3 % 10 = 3
    o_min_1   = o_d = 34 % 10 = 4
    12 : 34 출력. 
    */
endmodule
