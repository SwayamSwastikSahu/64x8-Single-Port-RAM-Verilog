# Design & Verification of Single Port RAM

## Project Report
**By Swayam Swastik Sahu**  
**Department of Electronics and Communication Engineering**  
**NIST University**  
**Institute Park, Berhampur, Odisha -761008, India**  
**www.nist.edu**

## Table of Contents
1. Abstract
2. Introduction
3. Design Overview
4. Verilog Code
5. Testbench Design
6. Simulation and Results
7. Conclusion
8. References
9. Appendix

## 1. Abstract
This project involves the design and verification of a 64x8-bit single-port Random Access Memory (RAM) using Verilog. The RAM module is synchronous, with both read and write operations controlled by a clock signal and a write enable (we) signal. Various test cases were implemented in a Verilog testbench to verify the correct functionality of the RAM, including basic read/write operations, overwriting data, random access, and checking for uninitialized memory. The simulation results demonstrate that the single-port RAM design performs as expected, meeting the project’s objectives.

## 2. Introduction
### Background
In digital systems, Random Access Memory (RAM) is essential for temporary data storage, allowing fast access and retrieval of data. A single-port RAM allows both read and write operations, but only one operation at a time through a single address bus. This type of RAM is commonly used in embedded systems, processors, and data buffering applications where memory access can be controlled sequentially.

As part of this project, a single-port RAM was designed using Verilog, a hardware description language (HDL) used to model digital circuits. The main goal was to implement a 64x8-bit single-port RAM module, ensuring correct read and write operations.

- RAM is considered volatile memory, meaning stored information is lost when there is no power.
- RAM is made up of small memory chips that form a memory module.
- Programs are loaded from the hard drive into RAM for faster data access compared to reading from the hard drive.

### Objective
The objective of this project is to:
- Design a single-port RAM with 64 memory locations, each capable of storing 8-bit data.
- Simulate the design to verify correct functionality using various test cases.

### Scope
This project focuses on the design and verification of a basic single-port RAM using Verilog. The memory can store 64 locations of 8-bit data, with a clock-driven mechanism for synchronous read/write operations. The scope does not include advanced features like dual-port RAM, multi-bank memory, or error-correcting code (ECC) implementation.

## 3. Design Overview
### Single-Port RAM Architecture
The single-port RAM allows either a read or a write operation at a given time. The architecture includes:
- **Data Bus (8-bit)**: For reading from and writing to memory.
- **Address Bus (6-bit)**: To specify the memory location for read/write operations.
- **Write Enable (we)**: A control signal to determine whether to read from or write to memory.
- **Clock Signal**: Used to synchronize all operations.

### Key Features
- **Data Width**: 8-bit data for each memory location.
- **Address Width**: 6-bit address, enabling access to 64 locations.
- **Write Enable**: Allows data to be written when high (we = 1), or read when low (we = 0).
- **Synchronous Operation**: Both read and write operations are synchronous with the clock signal.

## 4. Verilog Code
### Single-Port RAM Design Code
**Code Explanation:**
- **Module Definition (single_port_ram)**: Implements a single-port RAM.
- **Inputs**:
  - `data [7:0]`: 8-bit input data to be written into the RAM.
  - `addr [5:0]`: 6-bit address input, allowing access to 64 memory locations.
  - `we`: Write enable signal. When high, data is written to the RAM at the specified address.
  - `clk`: Clock signal, used to trigger data writing and address storing operations.
- **Output**:
  - `q [7:0]`: 8-bit output, holding the data read from the RAM.
- **RAM Declaration**:
  - `reg [7:0] ram [63:0]`: A 64 x 8-bit memory array, where each of the 64 memory locations stores 8-bit data.
- **Address Register**:
  - `reg [5:0] addr_reg`: Stores the address during a read operation, holding the address from which data is read in the next cycle.
- **Sequential Block**:
  - The `always @(posedge clk)` block triggers on the rising edge of the clock.
- **Write Operation**:
  - If `we` is high (1), the input data is written into the memory location specified by `addr`.
- **Read Operation**:
  - If `we` is low (0), the current address value from `addr` is stored in `addr_reg`.
- **Data Output Assignment**:
  - The output `q` is continuously assigned the data stored in the memory location addressed by `addr_reg` from the last read cycle.

## 5. Testbench Design
### Testbench Code
**Code Explanation:**
- **Module Declaration**:
  - The `single_port_ram_tb` module is declared for testing the `single_port_ram` module.
- **Inputs/Outputs**:
  - `reg [7:0] data`: 8-bit register to hold the input data for the RAM.
  - `reg [5:0] addr`: 6-bit register to hold the address to access the RAM locations.
  - `reg we`: A register for the write enable signal.
  - `reg clk`: A register for the clock signal.
  - `wire [7:0] q`: Wire to capture the 8-bit output from the RAM.
- **Instantiation of the RAM**:
  - The `single_port_ram` module is instantiated as `SPR`, connecting the input and output signals to the testbench’s `data`, `addr`, `we`, `clk`, and `q`.
- **Clock Generation**:
  - Clock is initialized to 1 (`clk = 1'b1`).
  - The clock toggles every 5 time units (`forever #5 clk = ~clk`), creating a clock period of 10 time units.

### Test Cases
The initial block defines various test scenarios to verify the RAM's functionality:
- **Test Case 1: Basic Write and Read Operation**
  - Write `8'hAA` to address 0.
  - Write `8'hBB` to address 1.
  - Read from addresses 0 and 1 by setting `we = 0`.
- **Test Case 2: Multiple Write Operations Followed by Read**
  - Write `8'h11`, `8'h22`, and `8'h33` to addresses 0, 1, and 2, respectively.
  - Read the data back from addresses 0, 1, and 2.
- **Test Case 3: Overwrite Data at a Specific Address**
  - Write `8'h44` to address 3.
  - Overwrite with `8'h55` at address 3.
  - Read the value from address 3 to verify the overwrite.
- **Test Case 4: Write and Read at Random Addresses**
  - Write `8'h66` to address 5 and `8'h77` to address 10.
  - Read from addresses 5 and 10 to verify the data.
- **Test Case 5: Check RAM for Uninitialized Values**
  - Check data from addresses 7 and 15 without initializing them.
- **Test Case 6: Simultaneous Read/Write to the Same Address**
  - Write `8'hAA` to address 8 and immediately overwrite with `8'hBB`.
  - Read the data from address 8 to check if the overwrite was successful.
- **Ending the Simulation**:
  - The simulation is stopped with `$stop` after a delay of 20ns.

This testbench simulates scenarios like write, read, overwriting, and random access operations to verify the RAM's functionality.

## 6. Simulation and Results
The simulation results confirm that the single-port RAM performs as expected, with correct read/write operations, random access, and proper handling of uninitialized memory locations.

## 7. Conclusion
The design and verification of a single-port RAM using Verilog was successfully completed. The RAM was tested under various conditions, meeting the expected functionality, including correct read/write operations and random access. Future work could include expanding the design to dual-port RAM or adding error detection and correction mechanisms.

## 8. References
1. **Tools**: Vivado
2. **Hardware Description Language**: Verilog

## 9. Appendix
The full Verilog code for the Single-Port RAM implementation, including the main module and testbench, can be accessed on GitHub. For detailed code listings and further implementations, please visit the GitHub repository linked in the project report.

**THANK YOU!**