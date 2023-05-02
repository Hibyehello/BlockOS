load_disk:
	push dx ; save dx for later

	; AH = 02
	; AL = number of sectors to read	(1-128 dec.)
	; CH = track/cylinder number  (0-1023 dec., see below)
	; CL = sector number  (1-17 dec.)
	; DH = head number  (0-15 dec.)
	; DL = drive number (0=A:, 1=2nd floppy, 80h=drive 0, 81h=drive 1)
	; ES:BX = pointer to buffer
	
	mov ah, 0x2
	mov al, dh
	mov ch, 0
	mov dh, 0
	mov cl, 2

	int 0x13 ; disk i/o bios interrupt

	jc disk_error

	pop dx

	cmp dh, al ; make sure all sectors read
	jne disk_error

	ret

disk_error:
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $

DISK_ERROR_MSG:	db "Disk read error", 0xD, 0xA, 0
