format PE64 GUI 4.0 DLL

include 'win64a.inc'

section '.data' readable writeable
    array dq 0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9
    ArraySize = ($ - array) / 8
    message db " || "

section '.data' readable
    format_stringD db "%d", 0
    format_stringS db "%s", 0
    NewLine dq 0xA

section '.text' code readable executable
proc MyProc
        mov qword [array + 8] , 98

        fastcall gnome_sortInt64, array ,ArraySize

        fastcall write_consol , format_stringS , NewLine

        mov rsi, 0
        ForLoop:

                fastcall write_consol, format_stringD, [array + (rsi * 8)]

                fastcall write_consol , format_stringS, message

                fastcall wait_time, 10

        inc rsi
        cmp rsi, ArraySize
        jl ForLoop

        fastcall write_consol , format_stringS , NewLine


        fastcall sum, 10, 10

        fastcall write_consol , format_stringD,rax

        ;-------------------------------------

        fastcall wait_time, 2000
        ret
endp

proc sum
     add rcx,rdx
     mov rax,rcx
     ret
endp

proc gnome_sortInt64
         mov r8, 1
        .ForLoop:
                cmp r8,0
                je .IFBlock
                mov rax, [rcx + (r8 * 8)]
                mov r9, [rcx + (r8 * 8) - 8]
                cmp rax, r9
                jge .IFBlock
        .ElseBlock:
                mov [rcx + (r8 * 8)], r9
                mov [rcx + (r8 * 8) - 8], rax
                dec r8
                jmp .End_IF
        .IFBlock:
                inc r8
        .End_IF:
                cmp r8, rdx
                jl .ForLoop
        ret
endp

proc write_consol
        cinvoke printf,rcx,rdx
        ret
endp

proc write_consol_line
        cinvoke printf,rcx,rdx
        cinvoke printf,format_stringS,NewLine
        ret
endp


proc wait_time
        invoke Sleep, rcx
        ret
endp

section '' import readable
library kernel32, 'C:\Windows\System32\kernel32.dll',\
          user,'C:\Windows\System32\USER32.DLL',\
          msvcrt,'C:\Windows\System32\msvcrt.dll'

import  kernel32,\
        Sleep, 'Sleep',\
        ExitProcess, 'ExitProcess'

import  msvcrt,\
        printf, 'printf'

section '.edata' export data readable
export  'x64l.DLL',\
        wait_time, 'wait_time',\
        write_consol, 'write_consol',\
        MyProc,'MyProc',\
        gnome_sortInt64, 'gnome_sortInt64',\
        write_consol_line,'write_consol_line',\
        sum,'sum'
