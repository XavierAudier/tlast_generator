# Issues found in other implementations.
This simple repository provides the tools to insert a TLAST signal in an AXI Stream.
There are other implementations online, mostly under the name "tlast_gen.v".
However, those do not pass very basic tests and present several issues:
- They trigger a TLAST signal one sample ealier than they should upon initial TVALID = 0;
- The TLAST signal is kept high until a new sample is received.

Altogether : those implementations are working as expected only when the TVALID signal is kept high.
For regular operations they are non functional.

The implementation presented here aims at solving these issues and having a robust implementation.
One that works with a TVALID signal that can change, as is the most common case.

# Description
The IP takes an AXI Stream Slave signal that does not contain a TLAST signal.
It outputs an AXI Stream Master signal that contains the TLAST signal.
The TLAST signal is generated after N valid samples, where N is the PACKET_LENGTH specified.
An external FORCE_TLAST signal can be applied to trigger the end of packet early.

# Usage
All three "\*.v" files are verilog code.
- tlast_gen.v : contains the functionnal code.
- tlast_gen_NONFUNCTIONAL.v : contains the non functionnal code that is available in multiple places online.
- tlast_gen_tb.v : contains the test bench used to illustrate the problem in the code.

The "\*.png" illustrate the problem encountered by the non functionnal code, and how it works as intended with the proposed fix.
The test bench was ran using Vivado 2019.2 software.
