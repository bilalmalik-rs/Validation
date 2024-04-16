

module ram_primitive_tdp_no_split_9 (
  input clock0, clock1, weA, weB,
  input [9:0] addrA, addrB,
  input [8:0] dinA, dinB, 
  output [8:0] doutA, doutB);

TDP_RAM36K #(.INIT({32768{1'b0}}), // Initial Contents of memory
  .INIT_PARITY({2048{1'b0}}), // Initial Contents of memory
  .WRITE_WIDTH_A(9), // Write data width on port A (1-36)
  .READ_WIDTH_A(9), // Read data width on port A (1-36)
  .WRITE_WIDTH_B(9), // Write data width on port B (1-36)
  .READ_WIDTH_B(9) // Read data width on port B (1-36)
) inst ( 
  .WEN_A(weA), // Write-enable port A
  .WEN_B(weB), // Write-enable port B
  .REN_A(reA), // Read-enable port A
  .REN_B(reB), // Read-enable port B
  .CLK_A(clock0), // Clock port A
  .CLK_B(clock1), // Clock port B
  .BE_A(4'b1111), // Byte-write enable port A
  .BE_B(4'b1111), // Byte-write enable port B
  .ADDR_A(addrA), // Address port A, align MSBs and connect unused MSBs to logic 0
  .ADDR_B(addrB), // Address port B, align MSBs and connect unused MSBs to logic 0
  .WDATA_A(dinA[7:0]), // Write data port A
  .WPARITY_A(dinA[8]), // Write parity data port A
  .WDATA_B(dinB[7:0]), // Write data port B
  .WPARITY_B(dinB[8]), // Write parity port B
  .RDATA_A(doutA[7:0]), // Read data port A
  .RPARITY_A(doutA[8]), // Read parity port A
  .RDATA_B(doutB[7:0]), // Read data port B
  .RPARITY_B(doutB[8]) // Read parity port B
);

endmodule
