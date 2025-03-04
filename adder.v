`timescale 1ns / 1ps

module calculator (
    input [7:0] a,
    input [7:0] b,
    input clk,  //btn 대신 보드에서 받아올 시간
    output [3:0] seg_comm,
    output [7:0] seg
);
    wire [7:0] s;
    wire cout; 
    reg  [3:0] sum_to_display;
    reg  [1:0] btn;

    fa_8 U_fa8 (
        .a(a),
        .b(b),
        .s(s),
        .c(cout)
    );

    /*
      btn을 input으로 받지 않고 자동으로 0~3이 반복되도록 하면 어떨까?
    */
    reg [26:0] counter; //clk변화가 너무 빠를것같아서서 속도 조절을 위한 변수

    always @(posedge clk) begin
        if (counter == 27'd99999) begin //헤르츠조절
            counter <= 0;
            if (btn == 2'b11) btn <= 2'b00;
            else btn <= btn + 1'b1;
        end else counter <= counter + 1;
    end

    always @(*) begin
        case (btn)
            2'b00:   sum_to_display = s[3:0];
            2'b01:   sum_to_display = s[7:4];
            2'b10:   sum_to_display = {3'b000, cout};
            2'b11:   sum_to_display = 4'b0000;
            default: sum_to_display = 4'b0000;
        endcase
    end

    fnd_controller U_fndcontroller (
        .sum({cout,s}),
        .seg_sel(btn),
        .seg_comm(seg_comm),
        .seg(seg)
    );

endmodule

module fa_8 (
    input [7:0] a,
    input [7:0] b,
    //input cin,
    output [7:0] s,
    output c
);
    wire w_c;
    fa_4 U_fa4_0 (
        .a  (a[3:0]),
        .b  (b[3:0]),
        .cin(1'b0),
        .s  (s[3:0]),
        .c  (w_c)
    );
    fa_4 U_fa4_1 (
        .a  (a[7:4]),
        .b  (b[7:4]),
        .cin(w_c),
        .s  (s[7:4]),
        .c  (c)
    );
endmodule


module fa_4 (
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] s,
    output c
);
    wire [2:0] w_c;
    full_adder U_fa0 (
        .a  (a[0]),
        .b  (b[0]),
        .cin(cin),
        .sum(s[0]),
        .c  (w_c[0])
    );
    full_adder U_fa1 (
        .a  (a[1]),
        .b  (b[1]),
        .cin(w_c[0]),
        .sum(s[1]),
        .c  (w_c[1])
    );
    full_adder U_fa2 (
        .a  (a[2]),
        .b  (b[2]),
        .cin(w_c[1]),
        .sum(s[2]),
        .c  (w_c[2])
    );
    full_adder U_fa3 (
        .a  (a[3]),
        .b  (b[3]),
        .cin(w_c[2]),
        .sum(s[3]),
        .c  (c)
    );
endmodule

module full_adder (
    input  a,
    input  b,
    input  cin,
    output sum,
    output c
);
    wire w_s, w_c1, w_c2;
    half_adder U_ha1 (
        .a  (a),
        .b  (b),
        .sum(w_s),
        .c  (w_c1)
    );
    half_adder U_ha2 (
        .a  (w_s),
        .b  (cin),
        .sum(sum),
        .c  (w_c2)
    );
    or (c, w_c1, w_c2);
endmodule

module half_adder (
    input  a,    //1bit wire
    input  b,
    output sum,
    output c
);
    // 게이트 프리미티브 방식
    xor (sum, a, b);  // (출력, 입력0, 입력1 ....)
    and (c, a, b);
endmodule
