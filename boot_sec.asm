;
;	Basic boot sector that just loops
;
[org 0x7c00] ; our executable memory starts here

KERNEL_OFFSET equ 0x1000 ; address of the kernel

mov [BOOT_DRIVE], dl

mov bp, 0x9000          ; Set stack
mov sp, bp

jmp main

%include "iolib_16.asm"
%include "disk_io.asm"

main:
mov bx, boot_string
call print_string

call load_kernel

call switch_to_pm

jmp $

[bits 16]
load_kernel:
	mov bx, load_kernel_string
	call print_string

	mov bx, KERNEL_OFFSET
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call load_disk

	ret

%include "gdt.asm"
%include "switch_pm.asm"
%include "iolib.asm"

[bits 32]
BEGIN_32:
	mov ebx, pm_switch_string
	call print_string_pm

	call KERNEL_OFFSET
	
	jmp end

newline:
	db 0xD, 0xA, 0

boot_string:
	db "Booting up BlockOS...", 0xD, 0xA, 0

pm_switch_string:
	db "Switched to 32 bit mode", 0xD, 0xA, 0

load_kernel_string:
	db "Loadeding Hib Kernel", 0xD, 0xA, 0

goodbye_string:
	db "Shutting Down BlockOS...", 0

BOOT_DRIVE: db 0

end:

times 510-($-$$) db 0

dw 0xAA55
