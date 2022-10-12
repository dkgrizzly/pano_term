#ifndef _PANIO_IO_H_
#define _PANIO_IO_H_

#define PIC_BASE              0x90000000
#define TIMER_BASE            0x91000000
#define UART_BASE             0x92000000

#define SPI_BASE              0x93000000

#define GPIO_BASE             0x94000000

#define GPIO_BIT_PANO_BUTTON  (1<<1)
#define GPIO_BIT_RED_LED      (1<<2)
#define GPIO_BIT_GREEN_LED    (1<<3)
#define GPIO_BIT_BLUE_LED     (1<<4)

#define GPIO_LED_MASK  (0x7)
#define GPIO_LED_SHIFT (2)
#define GPIO_LED(n)    (((n) & GPIO_LED_MASK) << GPIO_LED_SHIFT)
#define GPIO_LED_BITS         (GPIO_LED_MASK << GPIO_LED_SHIFT)

#define GPIO_BIT_CODEC_SDA    (1<<5)
#define GPIO_BIT_CODEC_SCL    (1<<6)

#define GPIO_BIT_GMII_RESET   (1<<7)

#define GPIO_BIT_PWR_STATUS0  (1<<8)
#define GPIO_BIT_PWR_STATUS1  (1<<9)
#define GPIO_BIT_PWR_STATUS2  (1<<10)
#define GPIO_BIT_PWR_STATUS3  (1<<11)

#define GPIO_PWR_STATUS_MASK  (0xf)
#define GPIO_PWR_STATUS_SHIFT (8)
#define GPIO_PWR_STATUS(n)    (((n) & GPIO_PWR_STATUS_MASK) << GPIO_PWR_STATUS_SHIFT)
#define GPIO_PWR_STATUS_BITS  (GPIO_PWR_STATUS_MASK << GPIO_PWR_STATUS_SHIFT)

#define GPIO_BIT_CONSOLE    (1<<13)

#define GPIO_CONSOLE_MASK     (0x1)
#define GPIO_CONSOLE_SHIFT    (13)
#define GPIO_CONSOLE(n)       (((n) & GPIO_CONSOLE_MASK) << GPIO_CONSOLE_SHIFT)

#define GPIO_BIT_INVERSE    (1<<14)

#define GPIO_INVERSE_MASK     (0x1)
#define GPIO_INVERSE_SHIFT    (14)
#define GPIO_INVERSE(n)       (((n) & GPIO_INVERSE_MASK) << GPIO_INVERSE_SHIFT)

#define GPIO_BIT_SCANLINES    (1<<15)

#define GPIO_SCANLINES_MASK     (0x1)
#define GPIO_SCANLINES_SHIFT    (15)
#define GPIO_SCANLINES(n)       (((n) & GPIO_SCANLINES_MASK) << GPIO_SCANLINES_SHIFT)

#define GPIO_BIT_PALETTE0     (1<<16)
#define GPIO_BIT_PALETTE1     (1<<17)

#define GPIO_PALETTE_MASK     (0x3)
#define GPIO_PALETTE_SHIFT    (16)
#define GPIO_PALETTE(n)       (((n) & GPIO_PALETTE_MASK) << GPIO_PALETTE_SHIFT)
#define GPIO_PALETTE_BITS     (GPIO_PALETTE_MASK << GPIO_PALETTE_SHIFT)

#define GPIO_BIT_CLK_LOCKED   (1<<24)
#define GPIO_BIT_CLKP_LOCKED  (1<<25)
#define GPIO_BIT_ENC_RESET    (1<<26)

#define GPIO_BIT_SHOWREGS     (1<<27)
#define GPIO_BIT_STEP         (1<<28)
#define GPIO_BIT_SINGLE       (1<<29)

#define GPIO_BIT_Z80_RESET    (1<<30)
#define GPIO_BIT_6502_RESET   (1<<31)



// Ethernet Controller
#define ETH_BASE              0x95000000


// I2C Busses
// Bus 0: DVI Encoders 0x76 & 0x75
// Bus 1: LCD DDC / DVI DDC
// Bus 2: DVI DDC / microHDMI DDC
// Bus 3: Audio Codec 0x34
#define I2C_BASE              0x96000000

#define I2C_CMD_STATUS        0x00
#define I2C_BUS               0x04
#define I2C_DEVICE            0x08
#define I2C_ADDRESS           0x0C
#define I2C_DATA              0x10

#define I2C_CMD_ENABLE        (1<<0)
#define I2C_CMD_READ          (1<<1)
#define I2C_CMD_WRITE         (0<<1)

#define I2C_STATUS_BUSY       (1<<8)
#define I2C_STATUS_NACK       (1<<9)

#define I2C_BUS_AUD           0
#define I2C_BUS_ENC           1
#define I2C_BUS_DVI           2
#define I2C_BUS_HDMI          3

#define I2C_AUD_WM8750        0x34
#define I2C_ENC_DVI           0x75
#define I2C_ENC_HDMI          0x76


// CRT Controller
#define CRTC_BASE             0x97000000


// Mini2 / Mega2 Address Window for debugging & DMA
#define M2IO_BASE             0x98000000


// Quake Console
#define QCON_BOTTOM           0x99000000
#define QCON_BUFFER           0x99002000
#define QCON_BUFFERSIZE       0x00008000

// RTC UNIX Second Counter
#define RTC_SECONDS           0x9C000000

// Harddisk Controller - RISC-V Side
#define HD_EXECUTE            0x9D000000
#define HD_STATUS             0x9D000004
#define HD_COMMAND            0x9D000008
#define HD_UNITNUM            0x9D00000C
#define HD_MEMADDR            0x9D000010
#define HD_BLKADDR            0x9D000014
#define HD_DATABUF            0x9D000800


// Keyboard & Joystick - RISC-V Side
#define SSP_KEYBOARD         0x9E000000
#define SSP_AN               0x9E000008
#define SSP_BUTTONS          0x9E00000C
#define SSP_PADDLE0          0x9E000010
#define SSP_PADDLE1          0x9E000014
#define SSP_PADDLE2          0x9E000018
#define SSP_PADDLE3          0x9E00001C

#define SSP_GAMEPAD0         0x9E000050
#define SSP_GAMEPAD1         0x9E000054

#define SSP_SCANLINES        0x9E000060
#define SSP_PALETTE          0x9E000064
#define SSP_INVERSE          0x9E000068

#define SSP_SLEEP            0x9E000080

#define SSP_RTC_CS           0x9E000090
#define SSP_RTC_SEC          0x9E000094
#define SSP_RTC_MIN          0x9E000098
#define SSP_RTC_HR           0x9E00009C
#define SSP_RTC_DOW          0x9E0000A0
#define SSP_RTC_DAY          0x9E0000A4
#define SSP_RTC_MON          0x9E0000A8
#define SSP_RTC_YR           0x9E0000AC


#endif   // _PANIO_IO_H_

