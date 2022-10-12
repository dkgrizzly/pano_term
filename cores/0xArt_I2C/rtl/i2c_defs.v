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

`define I2C_CMD_STATUS  8'h0

    `define I2C_CMD_ENABLE         0
    `define I2C_CMD_RW             1
    `define I2C_STATUS_BUSY        8
    `define I2C_STATUS_NACK        9

`define I2C_BUS         8'h4

    `define I2C_BUS_R              1:0

`define I2C_DEVICE      8'h8

    `define I2C_DEVICE_R           6:0

`define I2C_ADDRESS     8'hC

    `define I2C_ADDRESS_R          7:0

`define I2C_DATA        8'h10

    `define I2C_DATA_R             7:0

`define I2C_DIVIDER     8'h14

    `define I2C_DIVIDER_R         15:0


