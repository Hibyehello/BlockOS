; 32 bit protected mode functions
[bits 32]
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
	pusha
	mov edx, VIDEO_MEMORY 		; set edx to start of video mem

	print_string_pm_loop:
		mov al, [ebx]			; char
		mov ah, WHITE_ON_BLACK 	; attribute

		cmp al, 0
		je done

		mov [edx], ax			; store char and attribute to video memory

		add ebx, 1 				; onto next char
		add edx, 1 				; onto next column

		jmp print_string_pm_loop

	done:
		popa
		ret
