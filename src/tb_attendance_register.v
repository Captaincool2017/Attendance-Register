`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// TEAMATES:NISHCHAY PALLAV       &       YASH 
// ROLL NUMBERS:221EC233          &       221EC263 
// 
// Create Date: 13.11.2023 18:27:00 
// Module Name: attendance_register
// Project Name: ATTENDANCE REGISTER
// Tool Versions: 1.0
// Description: A USER FRIENDLY ATTENDANCE REGISTER FOR STUDENTS
// 
// 
// Revision 0.01 - File Created
// Additional Comments: LAB PROJECT FOR 3 SEMESTER DSD LAB EC204
//////////////////////////////////////////////////////////////////////////////////


module tb_attendance_register;
  // Inputs
  reg clk;
  reg attendance;
  reg clr;

  // Outputs
  wire is_safe;
  wire FA;
  wire [3:0]leaves;
  wire [6:0]to_attend;
  wire [6:0]total_attandance;
  wire [6:0]current_attandance;

  // Attendance register instance
  attendance_register uut_attendance_checker(
    clk,
    clr,
    attendance,
    is_safe,
    FA,
    leaves,
    to_attend,
    total_attandance,
    current_attandance
  );

    initial begin
        clk <= 1'b0;
        attendance=1;clr <= 1'b1;#1
        attendance<=1;clr <= 1'b0;#11
        attendance<=0;clr <= 1'b0;#5
        attendance<=1;clr <= 1'b0;#8
        attendance=0;
    end

    // Clock generator
    always #0.5 clk <= ~clk;

endmodule
