`timescale 1ns / 1ps

module single_port_ram_tb;

  reg [7:0] data;    
  reg [5:0] addr;   
  reg we;            
  reg clk;         
  wire [7:0] q;           
  
  // Instantiate the Single Port RAM here (assume the instance name is 'SPR')
  single_port_ram SPR (.clk(clk), .we(we), .addr(addr), .data(data), .q(q));

  // Clock generation
  initial
  begin
    clk = 1'b1;
    forever #5 clk = ~clk;
  end

  // Test Cases 
  initial
  begin
    // Test Case 1: Basic Write and Read Operation
    data = 8'hAA;
    addr = 6'd0;
    we = 1'b1;
    #10;

    data = 8'hBB;
    addr = 6'd1;
    #10;
    
    addr = 6'd0;
    we = 1'b0;
    #10;
    
    addr = 6'd1;
    #10;

    // Test Case 2: Multiple Write Operations Followed by Read
    data = 8'h11;
    addr = 6'd0;
    we = 1'b1;
    #10;
    
    data = 8'h22;
    addr = 6'd1;
    #10;
    
    data = 8'h33;
    addr = 6'd2;
    #10;
    
    addr = 6'd0;
    we = 1'b0;
    #10;
    
    addr = 6'd1;
    #10;
    
    addr = 6'd2;
    #10;

    // Test Case 3: Overwrite Data at Specific Address
    data = 8'h44;
    addr = 6'd3;
    we = 1'b1;
    #10;
    
    data = 8'h55;
    addr = 6'd3;
    #10;
    
    addr = 6'd3;
    we = 1'b0;
    #10;

    // Test Case 4: Write and Read at Random Addresses
    data = 8'h66;
    addr = 6'd5;
    we = 1'b1;
    #10;

    data = 8'h77;
    addr = 6'd10;
    #10;

    addr = 6'd5;
    we = 1'b0;
    #10;

    addr = 6'd10;
    #10;

    // Test Case 5: Check RAM for Uninitialized Values
    addr = 6'd7;
    we = 1'b0;
    #10;

    addr = 6'd15;
    #10;

    
    // Test Case 6: Simultaneous Read/Write to the Same Address
    data = 8'hAA;
    addr = 6'd8;
    we = 1'b1;
    #10;

    data = 8'hBB;
    addr = 6'd8;
    we = 1'b1;
    #10;

    we = 1'b0;
    #10;

    // End the simulation
    #20;
    $stop;
  end

endmodule