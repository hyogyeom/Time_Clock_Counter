`timescale 1ns / 1ps

module Comparator(
    input[6:0] i_msec,  // 0~99하기위해
    output[3:0] o_fndDP
    );

    assign o_fndDP = (i_msec < 50) ? 11 : 10;  
    // (  ) 괄호가 참으면 앞(11), 틀리면 뒤(10)
    // 참으면 꺼지고, 틀리면 점이 켜져라 BCD_to_FND_Decoder line.19 참고

endmodule
