section .data
inputBuf:   db  0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A	; allocate space for the input string
inputLen:   equ 8

section .bss
outputBuf:  resb 80   ; reserve 80 bytes for output buffer

section .text
global _start

_start:
	; initialize all values
    mov esi, inputBuf        ; source index
    mov edi, outputBuf       ; destination index
    mov ecx, inputLen        ; number of bytes

translate_loop:
	; process byte by translating high nibble first and low nibble second
    lodsb                    ; load byte from [esi] into AL
    push eax                 ; preserve AL value for 2nd digit
    shr al, 4                ; get high nibble
    call hex_to_ascii
    stosb                    ; store ASCII char to [edi]

    pop eax                  ; retrieve original byte
    and al, 0x0F             ; get low nibble
    call hex_to_ascii
    stosb                    ; store ASCII char to [edi]

    mov al, ' '              ; space separator
    stosb

    loop translate_loop

    ; overwrite last space with newline
    dec edi
    mov byte [edi], 10       ; newline character

    ; print output
    mov edx, edi
    sub edx, outputBuf       ; compute output length
    mov ecx, outputBuf
    mov ebx, 1               ; stdout
    mov eax, 4               ; sys_write
    int 0x80

    ; exit
    mov eax, 1               ; sys_exit
    xor ebx, ebx
    int 0x80

; Subroutine: hex_to_ascii
; Input: AL = 0x0 - 0xF
; Output: AL = ASCII character

hex_to_ascii:
	; converts each nibble to corresponding ASCII character
    cmp al, 9	; compare nibble with 9, if less than or equal to 9 then it is a number
    jbe .digit
    add al, 'A' - 10	; converts to letters A-F by adding ASCII 'A' minus 10
    ret
.digit:
    add al, '0'	; converts to digits 0-9 by adding ASCII '0'
    ret
