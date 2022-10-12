//---------------------------------------------------------------------
// This file is open source HDL; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this file.  If not, see <https://www.gnu.org/licenses/>.
//---------------------------------------------------------------------

`define CRTC_CONTROL             8'h0
    `define CRTC_ENABLE             0
    `define CRTC_VSPN_R             1
    `define CRTC_HSPN_R             2

`define CRTC_YSCAN               8'h4
    `define CRTC_YSCAN_R        27:16
    `define CRTC_YPIXEL_R        11:0

`define CRTC_XSCAN               8'h8
    `define CRTC_XSCAN_R        27:16
    `define CRTC_XPIXEL_R        11:0

`define CRTC_VACTIVE            8'h10
    `define CRTC_VACTIVE_R       11:0

`define CRTC_VFW                8'h14
    `define CRTC_VFW_R           11:0

`define CRTC_VSW                8'h18
    `define CRTC_VSW_R           11:0

`define CRTC_VBW                8'h1C
    `define CRTC_VBW_R           11:0

`define CRTC_HACTIVE            8'h20
    `define CRTC_HACTIVE_R       11:0

`define CRTC_HFW                8'h24
    `define CRTC_HFW_R           11:0

`define CRTC_HSW                8'h28
    `define CRTC_HSW_R           11:0

`define CRTC_HBW                8'h2C
    `define CRTC_HBW_R           11:0

