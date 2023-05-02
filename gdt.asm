; GDT
gdt_start:

gdt_null: 		; null descriptor (mandatory)
	dd 0x0 		; double word (4 bytes)
	dd 0x0

; base = 0x0	limit = 0xffff
; 1st flags: 	(present) 1 (privileges) 00 (descriptor type) 1 -> 1001b
; type flags: 	(code) 1 (conforming) 0 (readable) 1 (accessed) 0 -> 1010b
; 2nd flags;	(granularity) 1 (32 bit default) 1 (64 bit seg) 0 (AVL) 0 -> 1100b 
gdt_code:			; code segment descriptor
	dw 0xffff		; limit (bits 0-15)
	dw 0x0			; base (bits 0-15)
	dw 0x0			; base (bits 16-23)
	db 10011010b 	; 1st flag, type flag
	db 11001111b	; 2nd flag, limit (bits 16-19)
	db 0x0			; base (bits 24-31)

; type flags: 	(code) 0 (conforming) 0 (readable) 1 (accessed) 0 -> 0010b
gdt_data:			; code segment descriptor
	dw 0xffff		; limit (bits 0-15)
	dw 0x0			; base (bits 0-15)
	dw 0x0			; base (bits 16-23)
	db 10010010b 	; 1st flag, type flag
	db 11001111b	; 2nd flag, limit (bits 16-19)
	db 0x0			; base (bits 24-31)

gdt_end: 


; GDT Descriptor
gdt_descriptor:
	dw gdt_end - gdt_start - 1 ; size of gdt

	dd gdt_start ; start address of gdt

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start 
