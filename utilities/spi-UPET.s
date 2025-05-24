;-----------------------------------------------------------------------------
; spi.s
; Copyright (C) 2023 Andre Fachat
;
; Using the interface described here
; https://github.com/fachat/MicroPET/blob/main/CPLD/SPI.md
;
; Changes to SD-Card version: 
; - sector size is 256 byte
; - error flag is C=1
; - inactive is device 7 selected
;-----------------------------------------------------------------------------

	.include "spi.inc"

;	.import sector_buffer

;	.export spi_ctrl, spi_read, spi_write, spi_select, spi_deselect, spi_read_sector, spi_write_sector



;-----------------------------------------------------------------------------
; Registers
;-----------------------------------------------------------------------------
SPI_CTRL      = $e808
SPI_DATA      = $e809
SPI_PEEK      = $e80a

SPI_CTRL_SELECT_MASK	= %00000111

;-----------------------------------------------------------------------------
; deselect card
;
; clobbers: A
;-----------------------------------------------------------------------------
spi_deselect:
	bit SPI_CTRL
	bmi spi_deselect	; wait for end
	lda SPI_CTRL
	ora #SPI_CTRL_SELECT_MASK
	sta SPI_CTRL
	rts

;-----------------------------------------------------------------------------
; select card
;
; clobbers: A,X,Y
;-----------------------------------------------------------------------------
spi_select:
	pha
	lda SPI_CTRL
	ora #SPI_CTRL_SELECT_MASK
	sta SPI_CTRL
	pla
	ora #255-SPI_CTRL_SELECT_MASK
	and SPI_CTRL
	sta SPI_CTRL
	rts


;-----------------------------------------------------------------------------
; spi_read
;
; result in A
;-----------------------------------------------------------------------------
spi_read:
	lda #$FF	; 2
spi_rw:
	bit SPI_CTRL
	bvs spi_rw	; wait for tx data register free
	sta SPI_DATA	; 4
@1:	bit SPI_CTRL	; 4
	bmi @1		; 2 + 1 if branch
	lda SPI_PEEK	; 4
	rts		; 6
			; >= 22 cycles

;-----------------------------------------------------------------------------
; spi_write
;
; byte to write in A
;-----------------------------------------------------------------------------
spi_write:
	bit SPI_CTRL
	bvs spi_write
	sta SPI_DATA
	rts

;-----------------------------------------------------------------------------
; sdcard_init
; result: C=0 -> error, C=1 -> success
;-----------------------------------------------------------------------------
spi_ctrl:
	bit SPI_CTRL
	bmi spi_ctrl		; wait for end of shift
	ora #SPI_CTRL_SELECT_MASK
	sta SPI_CTRL
	rts


;-----------------------------------------------------------------------------
; spi_read_sector
; read 4096 bytes from SPI to sector_buffer
; result: C=1 -> error, C=0 -> success
;-----------------------------------------------------------------------------
spi_read_sector:

	; Read 4k bytes of sector data
	ldx #16		; # pages
        ldy #0

@1:	jsr spi_read
	sta (sector_ptr), y
	iny
	bne @1
	inc sector_ptr+1
	dex
	bne @1
	clc
	rts

;-----------------------------------------------------------------------------
; spi_write_sector
; write 256 bytes of data from sector_buffer
; result: C=1 -> error, C=0 -> success
;-----------------------------------------------------------------------------
;spi_write_sector_:
;
;        ; Send 256 bytes of sector data
;        ldy #0
;
;@1:     bit SPI_CTRL
;	bvs @1
;	lda sector_buffer, y            ; 4
;        sta SPI_DATA
;        iny                             ; 2
;        bne @1                          ; 2 + 1
;
;	clc
;        rts

