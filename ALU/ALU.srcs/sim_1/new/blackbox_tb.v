`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: blackbox_tb
// Project Name: TP1 ALU - Arquitectura de Computadoras
// Authors: Amallo, Sofia - Raya, Matias
// Target Devices: Basys2/3
// Description: 
// Implementacion de una ALU basica con un testbench
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module blackbox_tb();
//parameter global
parameter SWITCHES = 6;
parameter OUTPUT_SIZE = 4;

//inputs
reg load_1;
reg load_2;
reg load_3;
reg load_4;
reg clock;
reg [SWITCHES-1:0] numero;

//outputs
wire [OUTPUT_SIZE-1:0] o_result;
wire o_carry;
wire o_zero;
wire o_signo;
wire o_load_1;
wire o_load_2;
wire o_load_3;
wire o_load_4;

//parameter local
localparam ADD = 6'b100000; //32
localparam SUB = 6'b100010; //34
localparam AND = 6'b100100; //36
localparam OR  = 6'b100101; //37
localparam XOR = 6'b100110; //38
localparam SRA = 6'b000011; //3
localparam SRL = 6'b000010; //2
localparam NOR = 6'b100111; //39

initial begin
    load_1 = 1'b0;
    load_2 = 1'b0;
    clock = 1'b1;
    numero = 6'd0;
    load_3 = 1'b0;
    load_4 = 1'b0;
end

always begin
    #1
    clock = ~clock;
end
always begin
    
    load_4 = 1'b1;
    #5
    load_4 = 1'b0;
    
    
    #2
    load_3 = 1'b0;
    
    
   
   ///////////////////////////////////////////////////////////////////////////////////
   
    //primera resta
    #2
    numero = 1'b1; //cargo a con un 1
    load_1 = 1'b1;
    #2
    load_1 = 1'b0;
    #2
    numero = 2; //cargo b con un 2
    load_2 = 1'b1;
    #2
    load_2 = 1'b0;
    #2
    numero = SUB;
    load_3 = 1'b1; //cargo opcode (resta)
    #2
    load_3 = 1'b0;
    
    //se limpia opcode
    #2
    numero = 0;
    load_3 =1;
    #2
    load_3 = 1'b0;
    
    //segunda resta
    #2
    numero = 15; //cargo a con un 15
    load_1 = 1'b1;
    #2
    load_1 = 1'b0;
    #2
    numero = 1; //cargo b con un 1
    load_2 = 1'b1;
    #2
    load_2 = 1'b0;
    #2
    numero = SUB;
    load_3 = 1'b1; //cargo opcode (resta)
    #2
    load_3 = 1'b0;
    
    //se limpia opcode
    #2
    numero = 0;
    load_3 =1;
    #2
    load_3 = 1'b0;
    
    
    //tercera resta
    #2
    numero = 15; //cargo a con un 15
    load_1 = 1'b1;
    #2
    load_1 = 1'b0;
    #2
    numero = 15; //cargo b con un 15
    load_2 = 1'b1;
    #2
    load_2 = 1'b0;
    #2
    numero = SUB;
    load_3 = 1'b1; //cargo opcode (resta)
    #2
    load_3 = 1'b0;
    
    //se limpia opcode
    #2
    numero = 0;
    load_3 =1;
    #2
    load_3 = 1'b0;
    
    
    
      
    $finish;
end    

black_box blackbox(
    .numero(numero),
    .clock(clock),
    .load_1(load_1),
    .load_2(load_2),
    .load_3(load_3),
    .load_4(load_4),
    .o_result(o_result),
    .o_carry(o_carry),
    .o_zero(o_zero),
    .o_signo(o_signo),
    .o_load_1(o_load_1),
    .o_load_2(o_load_2),
    .o_load_3(o_load_3),
    .o_load_4(o_load_4)
);

endmodule
