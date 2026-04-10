rem -------------------------------------------------------------------------------------------
rem 	rom file 7.3h needs to be divided exactly in half (use a hex editor like HxD)
rem 	save 1st half as 7.3h_a
rem 	save 2nd half as 7.3h_b
rem
rem	rom file 8.3jk needs to be trimmed to exactly 4kb or 0-FFF (use a hex editor like HxD)
rem	save new 4kb file as 8.3jk_s
rem -------------------------------------------------------------------------------------------

make_vhdl_prom 6.3f CPUROM_0.vhd
make_vhdl_prom 7.3h_b CPUROM_1.vhd
make_vhdl_prom 7.3h_a CPUROM_2.vhd
make_vhdl_prom 8.3jk_s CPUROM_3.vhd

copy /b 10.3p + 9.3m BG_ROM.bin
make_vhdl_prom BG_ROM.bin BG_ROM.vhd

copy /b 12.3t + 11.3r FG_ROM.bin
make_vhdl_prom FG_ROM.bin FG_ROM.vhd

make_vhdl_prom 1.3jk SNDCPU_ROM.vhd

make_vhdl_prom 2.5lm SPRITE_ROM_0.vhd
make_vhdl_prom 3.6lm SPRITE_ROM_1.vhd
make_vhdl_prom 4.7lm SPRITE_ROM_2.vhd
make_vhdl_prom 5.8lm SPRITE_ROM_3.vhd

pause