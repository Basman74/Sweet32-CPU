### Sweet32 CPU Project ###

Sweet32 32bit MRISC CPU - VHDL and software toolchain sources (including documentation)

Sweet32 is best described as a ‘no-frills’ 32bit minimal-RISC microprocessor core with a load/store register architecture with a simple bus interface. Sweet32 was developed by Valentin Angelovski (ie. me :-).

Sweet32's c compiler sources are released under the 2-clause FreeBSD, while VHDL sources are released under LGPL 2.1

WHAT THIS REPOSITORY CONTAINS:
_VHDL folder = VHDL sources for 'minimal' and 'complex' Sweet32 SoC designs for use in an FPGA device. Sources posted were tested on a Lattice MachXO2 FPGA but can easily be ported to FPGA parts from other vendors too. Further details can be found in the 'user docs' folder.

\Software toolchain = Contains a fork of Alexey Frunze's Smaller-C project, to target the Sweet32 CPU. Please note this is a partially complete port and works well for even intermediate program development. Not quite self-compiling yet however.. :-) Also contained within this folder is Xark's excellent Macro Assembler targetting the Sweet32 CPU (and WAY BETTER than my earlier FreeBASIC effort of the same :-)

\User docs = Contains a general overview of the Sweet32 CPU, BIU (Bus Interface Unit) and selected peripherals. It also explains how to use the integrated Monitor ROM as well as a breakdown of the .SWE firmware file format for the reliable upload of executable binary files to the Sweet32 via serial terminal and inbuilt monitor ROM.

ACKNOWLEDGEMENTS/THANKS GOES OUT TO:

- Alexey Frunze for his impressive Smaller-C compiler. https://github.com/alexfru/SmallerC
- Xark (of XarkLabs) for his excellent (and blazingly quick!) macro assembler for sweet32 https://github.com/XarkLabs

Well, that's it for now. More will be added here - hopefully soon. Feel free to browse the sources and Enjoy! :-)


Regards,
Valentin Angelovski
