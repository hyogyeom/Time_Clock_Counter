`timescale 1ns / 1ps

module Time_Clock(
    input i_clk,
    input i_reset,
    input i_modeSW,
    input i_on_off_SW,
    output[7:0] o_font,
    output[3:0] o_digitPosition
    );
    
    wire w_clk_1kHz;
    clock_divider_1kHz clock_divider_1kHz(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk(w_clk_1kHz)  // wire 1
    );

    wire[2:0] w_FND_counter;
    counter_FND counter_FND(
    .i_clk(w_clk_1kHz),
    .i_reset(i_reset),
    .o_counter(w_FND_counter)  // wire 2
    );

    Decoder_FND_Digit Decoder_FND_Digit(
    .i_select(w_FND_counter),
    .o_digitPosition(o_digitPosition)
    );

    wire[5:0] w_hour, w_min, w_sec;
    wire[6:0] w_msec;    // wire 3
    TimeClockCounter TimeClockCounter(
    .i_clk(w_clk_1kHz),
    .i_reset(i_reset),
    .o_hour(w_hour),
    .o_min(w_min),
    .o_sec(w_sec),
    .o_msec(w_msec)
    );

    wire[3:0] w_hour_10, w_hour_1, w_min_10, w_min_1;  // wire 4
    digit_divider_hour_min digit_divider_hour_min(
    .i_hour(w_hour),
    .i_min(w_min),
    .o_hour_10(w_hour_10),
    .o_hour_1(w_hour_1),
    .o_min_10(w_min_10),
    .o_min_1(w_min_1)
    );

    wire[3:0] w_fndDP;
    Comparator Comparator(  
    .i_msec(w_msec),
    .o_fndDP(w_fndDP)
    );

    wire[3:0] w_hour_min_MUX;  // wire 5
    MUX_8x1 w_hour_min_MUX(
    .i_a(w_min_1),
    .i_b(w_min_10),
    .i_c(w_hour_1),
    .i_d(w_hour_10),
    .i_a1(11),
    .i_b1(11),
    .i_c1(w_fndDP),
    .i_d1(11),  // 11 = 꺼지는거 
    .i_sel(w_FND_counter),
    .o_y(w_hour_min_MUX)
    );

    

    wire[3:0] w_sec_10, w_sec_1, w_msec_10, w_msec_1;  // wire 6
    digit_divider_sec_msec digit_divider_sec_msec(
    .i_sec(w_sec),
    .i_msec(w_msec),
    .o_sec_10(w_sec_10),
    .o_sec_1(w_sec_1),
    .o_msec_10(w_msec_10),
    .o_msec_1(w_msec_1)
    );

    

    wire[3:0] w_sec_msec_MUX;  // wire 7
    MUX_8x1 w_sec_msec_MUX(
    .i_a(w_msec_1),
    .i_b(w_msec_10),
    .i_c(w_sec_1),
    .i_d(w_sec_10),
    .i_a1(11),
    .i_b1(11),
    .i_c1(w_fndDP),
    .i_d1(11),
    .i_sel(w_FND_counter),
    .o_y(w_sec_msec_MUX)
    );

    wire[3:0] fnd_value;  // wire 8
    MUX_2x1 MUX_2x1(
    .i_a(w_hour_min_MUX),
    .i_b(w_sec_msec_MUX),
    .i_sel(i_modeSW),
    .o_y(fnd_value)
    );

    BCD_to_FND_Decoder BCD_to_FND_Decoder(
    .i_value(fnd_value),
    .i_on_off_SW(i_on_off_SW),
    .o_font(o_font)
    );
endmodule
