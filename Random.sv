//`timescale 1ns / 1ps

module dff(input clk, preset, d, output logic q);

    always_ff @(posedge clk)
        if (preset) q <= 1'b1;
        else        q <= d;
		  
endmodule

module Random(input clk, preset, output logic [3:0] code );
 
    logic q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15;
    logic out1, out2, out3;
 
    dff f0(clk, preset, out3, q0);
    dff f1(clk, preset, q0, q1);
    dff f2(clk, preset, q1, q2);
    dff f3(clk, preset, q2, q3);
    dff f4(clk, preset, q3, q4);
    dff f5(clk, preset, q4, q5);
    dff f6(clk, preset, q5, q6);
    dff f7(clk, preset, q6, q7);
    dff f8(clk, preset, q7, q8);
    dff f9(clk, preset, q8, q9);
    dff f10(clk, preset, q9, q10);
    dff f11(clk, preset, q10, q11);
    dff f12(clk, preset, q11, q12);
    dff f13(clk, preset, q12, q13);
    dff f14(clk, preset, q13, q14);
    dff f15(clk, preset, q14, q15);

//    xor(out1, q13, q15);
//    xor(out2, q12, out1);
//    xor(out3, q10, out2);

	
    always @(posedge clk)
  
        code <= {out1 ^ q13, out2 ^ q12, out3 ^ q10, q15};
endmodule 