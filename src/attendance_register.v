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
module attendance_register (
  input clk,
  input clr,
  input attendance,
  output reg is_safe,
  output reg FA,
  output reg [3:0]leaves,
  output reg [6:0]to_attend,
  output reg [6:0]total_attandance,
  output reg [6:0]current_attandance
);

  reg fa=0;
  reg [6:0] count1 = 1;
  reg [6:0] count2 = 1;
  reg [6:0] temp_leaves = 0;
 
//COUNTERS USED FOR BOTH TOTAL_ATTENDANCE AND CURRENT_ATTENDANCE
  always @(posedge clk)begin
    total_attandance = total_attandance + 1;
    if(attendance)
       current_attandance = current_attandance + 1;
  end

 //RESET   
  always @(*)begin
    if(total_attandance >= 26 || clr==1 ) begin 
       total_attandance = 1; current_attandance = 1 ; count1 = 1 ; count2 = 1 ; leaves = 0 ;
       to_attend = 0 ; is_safe = 0 ; FA = 0 ; temp_leaves = 0 ;
    end
  end

//COMPARATOR FOR ATTENDANCE SAFETY AND FA CALCULATOR
  always @(posedge clk) begin
    if((total_attandance + to_attend) >= 26 ) 
       fa = 1;
    FA=fa;
    count2 = current_attandance << 2;
    count1 = (total_attandance << 1) + total_attandance;
    if(count2 >= count1) 
       is_safe = 1;
    else 
       is_safe = 0; 
  end

//TOTAL NUMBER OF LEAVES CALCULATOR
  always @(posedge clk)begin
    if(is_safe)begin 
       to_attend = 0;
       if((current_attandance<<2) >= ((total_attandance<<1) + total_attandance))begin
          temp_leaves = (current_attandance<<2) - ((total_attandance<<1) + total_attandance);
          leaves = temp_leaves/3;
       end
    else 
       leaves = 0;
    end
 
 //TOTAL NUMBER OF DAYS TO ATTEND CLASSES TO BE SAFE CALCULATOR
    else begin
       leaves = 0;
       if(((total_attandance<<1) + total_attandance) >= (current_attandance<<2)) 
          to_attend = ((total_attandance<<1) + total_attandance) - (current_attandance<<2);
       else  
          to_attend=0;
    end
  end  

endmodule
