`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: interface
// Project Name: TP#2 UART - Arquitectura de Computadoras
// Authors: Amallo, Sofia - Raya Plasencia, Matias
// Target Devices: Basys3
// Description: Interface module to communicate UART and ALU
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module interface
    #(  parameter   WORD_SIZE = 8
    )(
        input wire  in_reset, in_clk,
        //UART
        input wire  [1:0]in_rx_status,
        input wire  [7:0]in_rx_data,
        input wire  [1:0]in_tx_status,
        output wire [1:0]out_interface_status,
        output wire [7:0]out_tx_data,
        //ALU
        input wire  [7:0]in_result,
        input wire  in_alu_status,
        output wire [7:0]out_dato_a,
        output wire [7:0]out_dato_b,
        output wire [7:0]out_opcode
    );
/*  
localparam
    DATO_A  =   0,
    DATO_B  =   1,
    OP_CODE =   2;   
*/
localparam
    IDLE    =   3'b000,
    DATO_A  =   3'b001,
    DATO_B  =   3'b010,
    OPCODE  =   3'b011,
    COMPUTE =   3'b100;
    
reg [1:0]interface_status;
reg [7:0]tx_data;
reg [7:0]dato_a;
reg [7:0]dato_b;
reg [7:0]opcode;    
reg [7:0]aux_dato_a;
reg [7:0]aux_dato_b;
reg [7:0]aux_opcode;
integer contador; 
reg [2:0]next_state, current_state;


always @(posedge in_clk) begin
    if(in_reset) begin
        interface_status = 2'b0;
        tx_data = 8'b0;
        dato_a = 8'b0;
        dato_b = 8'b0;
        opcode = 8'b0;
        contador = 0;
    end
    //necesito una m�quina de estados para esto? creo que no.
end

/* posible caso en el que cambie cualquier otra variable y el bit de ok del receptor se 
mantenga igual, en ese caso seguir�amos conmutando de estado cuando no es correcto.
*/

always @* begin
    //in_rx_status == 0 cuando recibi� los 8 bits de datos + el stop bit sin errores
   // if(!in_rx_status)begin
        case(current_state)
            IDLE: begin
                if(!in_rx_status) begin
                    next_state = DATO_A;
                end
            end
            DATO_A: begin
                aux_dato_a = in_rx_data;
                if(!in_rx_status) begin  
                    next_state = DATO_B;
                end
            end
            DATO_B: begin
                aux_dato_b = in_rx_data;
                if(!in_rx_status) begin
                    next_state = OPCODE;
                end
            end
            OPCODE: begin
                aux_opcode = in_rx_data;
                next_state = COMPUTE;
            end
            COMPUTE: begin
                dato_a = aux_dato_a;
                dato_b = aux_dato_b;
                opcode = aux_opcode;
                //alu enable 
                if(!in_alu_status) begin
                    tx_data = in_result;
                    //tx_enable
                    if(in_tx_status) begin
                        next_state = IDLE;
                    end
                end
            end
        endcase
        //in_alu_status == 0 cuando termina la operaci�n sin errores
    //end
    if(!in_alu_status)begin
        tx_data = in_result;
    end 
end

assign  out_dato_a = dato_a;
assign  out_dato_b = dato_b;
assign  out_opcode = opcode;

endmodule
