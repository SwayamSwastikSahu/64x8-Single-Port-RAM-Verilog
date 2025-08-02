
`timescale 1ns / 1ps
module single_port_ram(
    input [7:0] data,       // input data
    input [5:0] addr,       // address
    input we,               // write enable pin
    input clk,              // clock
    output [7:0] q          // output data
);

reg [7:0] ram[63:0];      // 64x8 bit RAM
reg [5:0] addr_reg;       // address register

always @(posedge clk ) begin
    if(we)
    ram[addr] <= data;
    else
    addr_reg <= addr;
end

assign q = ram[addr_reg];
endmodule