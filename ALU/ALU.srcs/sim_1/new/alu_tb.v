`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: alu_tb
// Project Name: TP1 ALU - Arquitectura de Computadoras
// Authors: Amallo, Sofia - Raya, Matias
// Target Devices: Basys2/3
// Description: 
// Implementacion de una ALU basica con un testbench
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module alu_tb( );
parameter number_bus_input = 4;
parameter number_bus_output = 5;
parameter number_bus_operation = 6;

//inputs

reg clock;
reg load_1;
reg load_2;
reg load_3;
reg [number_bus_operation-1:0] numeros;

//outputs
wire [number_bus_output-1:0] o_result;
wire o_carry;
wire o_zero;
wire o_signo;

localparam ADD = 6'b100000;
localparam SUB = 6'b100010;
localparam AND = 6'b100100;
localparam OR  = 6'b100101;
localparam XOR = 6'b100110;
localparam SRA = 6'b000011;
localparam SRL = 6'b000010;
localparam NOR = 6'b100111;

initial
begin
    clock = 1'b1;
    numeros = 32;
    load_3 = 1;
end
always begin
#1
    clock = ~clock;
end
always begin
    #2
    load_3 = 1'b0;
    #2
    numeros = 1'b1; //cargo a con un 1
    load_2 = 1'b1;
    #2
    load_2 = 1'b0;
    #2
    numeros = 6'd2; //cargo b con un 2
    load_1 = 1'b1;
    #2
    load_1 = 1'b0;
    #2
    numeros = ADD;
    load_3 = 1'b1; //cargo opcode (suma)
    #2
    load_3 = 1'b0;
    #2
    numeros = 1'b1; //cargo a con un 2
    load_2 = 1'b1;
    #2
    load_2 = 1'b0;
    #2
    numeros = 6'd2; //cargo b con un 1
    load_1 = 1'b1;
    #2
    load_1 = 1'b0;
    #2
    numeros = SUB;
    load_3 = 1'b1; //cargo opcode (resta)
    #2
    load_3 = 1'b0;
    #2
    numeros = 6'd3; //cargo a con un 2
    load_2 = 1'b1;
    #2
    load_2 = 1'b0;
    #2
    numeros = 6'd2; //cargo b con un 1
    load_1 = 1'b1;
    #2
    load_1 = 1'b0;
    #2
    numeros = AND;
    load_3 = 1'b1; //cargo opcode (suma)
    #2
    $finish;
end

/*alu alu0(
    .numeros(numeros),
    .load_1(load_1),
    .load_2(load_2),
    .load_3(load_3),
    .clock(clock),
    .o_result(o_result),
    .o_carry(o_carry),
    .o_zero(o_zero),
    .o_signo(o_signo)
);*/
endmodule
