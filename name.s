        .data
title:  .asciz "*****Print Name*****\n"

msg:    .asciz "Team02 \n"

        .globl name
name:   .asciz "Yu Jie LIn \n"

        .globl name2
name2:  .asciz "YI XUAN LI \n"

        .globl name3
name3:  .asciz "Pei Hsin Huang \n"

pall:   .asciz "%s%s%s"
end:    .asciz "*****End Print*****\n"

        .text
        .global NAME
NAME:  stmfd   sp!, {lr}
        ldr     r0, =title
        bl      printf
        ldr     r0, =msg
        bl      printf
        ldr     r1, =name
        ldr     r2, =name2
        ldr     r3, =name3
        ldr     r0, =pall
        bl      printf

        ldr     r0, =end
        bl      printf

        mov     r7, r14
        mov     r8, r13
        mov     r14, r15
        mov     r13, #8
        adds    r15, r14, r13

        mov     r14, r7
        mov     r13, r8
        ldr     r8, [r8, #4 ]
        mov     r8, #0
        ldmfd   sp!, {lr}
        mov     pc, lr
