`timescale 10 ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: tb_blackbox
// Project Name: TP#2 UART - Arquitectura de Computadoras
// Authors: Amallo, Sofia - Raya Plasencia, Matias
// Target Devices: Basys3
// Description: Blackbox module testbench
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

/*
    El m�dulo baud_generator genera los ticks cada 163 clocks como corresponde, 
    y el m�dulo rx cuenta los bits y cambia de estado de manera exitosa,
    pero el testbench no funciona como esperar�a. Cuenta menos ticks de los que deber�a.
    
    TODO: repensar como armar el testbench
*/

module tb_blackbox;
     
//inputs
reg in_clk, in_reset, in_rx;

//outputs
wire [1:0]out_rx_status;
wire [7:0]out_data;

reg i,j;

initial begin
    in_clk = 1'b1;
    in_rx = 1'b0;
    in_reset = 1'b1;
end

always begin
    #1
    in_clk = ~in_clk;
end

always begin
    in_reset = 1'b0;
     /*   
    for(i=0; i<8;i=i+1)begin
        #326
        in_rx = 1'b0;
    end
    */
    #326
    in_rx = 1'b0;
    #326
    in_rx = 1'b0;
    #326
    in_rx = 1'b0;
    #326
    in_rx = 1'b0;
    #326
    in_rx = 1'b0;
    #326
    in_rx = 1'b0;
    #326
    in_rx = 1'b0;
    
    for(j=0; j<128;j=j+1)begin
        #326
        in_rx = 1'b1;
    end
    
    #326
    in_rx = 1'b1;
    #326
    in_rx = 1'b1;
   
    $finish;

end


blackbox blackbox_instance(
    .in_clk(in_clk),
    .in_reset(in_reset),
    .in_rx(in_rx),
    .out_rx_status(out_rx_status),
    .out_data(out_data) 
);

endmodule
