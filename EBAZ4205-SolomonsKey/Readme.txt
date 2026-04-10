Solomons Key Arcade for the EBAZ-4205 ZYNQ-7010 FPGA Board. Pinballwiz.org 2026
Code from Mister-X.

Notes:
Setup for keyboard controls in Upright mode (5 = Coin) (1 = Start P1) (2 = Start P2) (LCtrl = Fire) (X = Jump) (Arrow Keys = Move D or L or R)
Consult the Docs Folder for Information regarding peripheral connections and schematics.

Build:
* Obtain correct roms file for Solomons Key (see scripts in tools folder for rom details).
* Unzip rom files to the tools folder.
* Edit 2 Rom files as described in prom script header.
* Run the make solomons proms script in the tools folder.
* Place the generated prom files inside the proms folder.
* Open the EBAZ4205-SolomonsKey project file using Vivado (v2022.2 or silimar is recommended)
* Compile the project updating filepaths to source files as necessary.
* If not using Zynq Arcade Platform connect JTAG Programmer and program EBAZ4205 Board.
* If using Zynq Arcade (see the github repo) copy bitstream file to MicroSD Card and sys reset EBAZ4205 Adapter board to load.

