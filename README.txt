Sweet32 CPU and Toolchain usage README.


"What is Sweet32??"
-------------------
Sweet32 is best described as a ‘no-frills’ 32bit minimal-RISC microprocessor core with a 
load/store register architecture with a simple bus interface. Sweet32 was developed by 
Valentin Angelovski (ie. me :-).

"Okay, I'd like to play with Sweet32, what do I do now?" :-)
------------------------------------------------------------
This document contains a brief outline on how to get up and running with my Sweet32 
homebrew CPU with my FleaFPGA classic or Uno FPGA development boards. Alternatively,
There's also a Sweet32 emulator that runs under MS Windows for those who do not have
an FPGA board. 

DISCLAIMER: All executable files and/or sources provided on an 'as-is' basis and do not 
come with any warranties or guarantees whatsoever. I do ask you to paste/add one folder
(\Sweet32) to the root directory of your system, if you object to this I suggest you do 
not proceed with this how-to. Use the software contained in this archive at your own risk!

Usage instructions:

1.)	Move the \Sweet32 folder included in this zip archive to the root directory of your
	C: drive. This folder contains the following subfolders:
			\bin 		= Sweet32 c compiler and assembler.
			\bitfiles 	= FPGA bitfiles for classic and Uno FleaFPGA boards.
			\examples 	= c and asm examples complete with .bat build files.
			\includes 	= some useful include files.
			\VHDL		= Sweet32 VHDL and Lattice Diamond project files.
			\Toolchain_src 	= Sources for the Sweet32 compiler etc.

2.) 	Upload the Sweet32 bitfile to the relevant FleaFPGA board you want to configure
	using the JTAG utility - you should see a screen full of green smileys on a VGA 
	monitor if successful. PB2 on your FleaFPGA board resets the Sweet32 CPU and 
	restarts it's internal monitor ROM. Please refer to the FleaFPGA User manual of 
	your specific board to learn more around how to use the FleaFPGA JTAG utility.

3.)	Open an example in the examples folder. Run the .bat file associated with the 
	example to build the project. Once compilation and assembly are done, you should see
	three files: z.swe and z.bin. Note that we are only interested in z.swe, as that is
	the file format the Sweet32 SoC monitor ROM recognizes over a serial terminal
	connection..

4.) 	Open a serial terminal program and connect to the FleaFPGA's USB slave COM port as 
	detected by your host PC's operating system. Select 115200 baud, 8bits, no parity,
	one stop bit for the comms link. Make sure that any terminal file sends made are in
	binary format, not ASCII. Note: Author uses the 'TeraTerm' terminal program, but 
	generally any terminal program that supports raw binary file transfers will do.

5.) 	Connect to your FleaFPGA board using the terminal program and THEN press PB2 on the
	board, you should see the following text appear on your terminal console:

		Sweet32 Monitor/Loader v0.92-beta

		>



6.)	Press 'r' for registers and THEN press enter, you should
	see the following:

		> r
 		 r0 pc=00000060  r4 pc=10000000  r8 pc=00000001 r12 pc=FFFFFFDD
 		 r1 pc=10014FB9  r5 pc=00000001  r9 pc=FFFFFF00 r13 pc=00000000
 		 r2 pc=0000FFBB  r6 pc=00000000 r10 pc=1000074E r14 pc=00000F40
 		 r3 pc=00000000  r7 pc=00000000 r11 pc=0000FFBC r15 pc=10004AF4
 		 pc=00001000
		Modify reg 0-15 (C for pc)  pc= pc=

7.) 	Enter the number 10000000, this is the start address of the DRAM in Sweet32 memory
	map. Press enter when done. Note: You can press '?' at any time at this point to
	get a list of monitor commands.

8.)	Now, from our step#3, we are now ready to upload our z.swe formatted binary
	executably file for Sweet32! Send this file to the FleaFPGA using a raw binary 
	file send feature of your serial terminal program. Your terminal screen should now
	fill with '.' characters for every byte sent to Sweet32 on the FleaFPGA board.

9.) 	Once the binary file transfer has completed, the program example is immediately run.
	Press PB2 to reset Sweet32 and repeat step#3 onwards to recompile or load another
	example.

10.) 	That's it! :-) Further details on the Sweet32 can be found in the PDF user guide,
	which is in the same location as this README. Please note however the section on
	the monitor ROM tutorial is old and no longer accurate (hence why it's explained
	here).


ACKNOWLEDGEMENTS/THANKS GOES OUT TO:

- Alexey Frunze for his impressive Smaller-C compiler, used as a basis for Sweet32's c
 compiler https://github.com/alexfru/SmallerC
- Xark (of XarkLabs) for his excellent (and blazingly quick!) macro assembler for sweet32 https://github.com/XarkLabs
- Mike Chambers for his Sweet32 emulator program

Sweet32's c compiler sources are released under the 2-clause FreeBSD, while VHDL sources 
are released under LGPL 2.1

Well, that's it for now. Feel free to browse the sources and Enjoy! :-)


Cheers,
Valentin Angelovski
