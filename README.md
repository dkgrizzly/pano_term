# Pano Term

[https://github.com/dkgrizzly/pano_term](https://github.com/dkgrizzly/pano_term)

# Usage

Pano Term provides the user with a ANSI/VT100-like terminal at 160x64 characters.

The basic framework has been provided from Skip Hansen's panog2_ldr project, with
verilog modules added to enable video output and eventually terminal bell, as well
as firmware to provide the terminal emulation with truecolor support and most of
codepage 437.  Unicode and loadable fonts could probably be supported in the future
given the current BRAM usage.

The panog2_ldr interface is still present at Telnet port 23.
Character streams can be sent to the terminal on TCP port 10023.

Currently no keyboard input nor terminal response codes are supported.

# Acknowledgement and Thanks
This project uses code from several other projects including:
 - [Skip Hansen's panog2_ldr](https://github.com/skiphansen/panog2_ldr)
 - [ultraembedded's fpga_test_soc](https://github.com/ultraembedded/fpga_test_soc.git)
 - [Yol's Ethernet MAC](https://github.com/yol/ethernet_mac.git)
 - [The Light Weight IP project](https://savannah.nongnu.org/projects/lwip)

# Pano Links                          

Links to other Pano logic information can be found on the 
[Pano Logic Hackers wiki](https://github.com/tomverbeure/panologic-g2/wiki)

# LEGAL 

My original work (the dvi crtc verilog code and pano term firmware) is 
released under the GNU General Public License, version 2.
