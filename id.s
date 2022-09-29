        .data
title1: .asciz "*****Input ID*****\n"
enter1: .asciz "**Please Enter Member1 ID : **\n"
enter2: .asciz "**Please Enter Member2 ID : **\n"
enter3: .asciz "**Please Enter Member3 ID : **\n"
read:   .asciz "%d"
title2: .asciz "**Please Enter Command**\n"
readS:  .asciz "%s"
strp:   .asciz "p"
print:  .asciz "%d\n%d\n%d\n"
title3: .asciz "*****Print Team Member ID and ID Summation*****\n"
        .globl sum
sum:    .asciz "\nID Summation = %d\n"
end:    .asciz "*****End Print*****\n"

p:      .word 0
        .globl id1
id1:    .word 0
        .globl id2
id2:    .word 0
        .globl id3
id3:    .word 0
        .globl ans
ans:    .word 0

        .text
        .globl ID

ID:     stmfd   sp!, {lr}
        ldr     r0, =title1
        bl      printf

        @scanf id1
        ldr     r0, =enter1
        bl      printf
        ldr     r0, =read
        ldr     r1, =id1
        bl      scanf

        @scanf id2
        ldr     r0, =enter2
        bl      printf
        ldr     r0, =read
        ldr     r1, =id2
        bl      scanf

        @scanf id3
        ldr     r0, =enter3
        bl      printf
        ldr     r0, =read
        ldr     r1, =id3
        bl      scanf

        @command
        ldr     r0, =title2
        bl      printf
        ldr     r0, =readS
        ldr     r1, =p
        bl      scanf
        ldr     r1, =p
        ldrB    r7, [r1], #7
        ldr     r2, =strp
        ldrB    r4, [r2], r3
        cmp     r7, r4
        bne     else

        @printf id
        ldr     r0, =title3
        bl      printf
        ldr     r0, =print
        ldr     r1, =id1
        ldr     r1, [r1]
        ldr     r2, =id2
        ldr     r2, [r2]
        ldr     r3, =id3
        ldr     r3, [r3]
        bl      printf

        @add
        ldr     r1, =id1
        ldr     r1, [r1]
        ldr     r2, =id2
        ldr     r2, [r2]
        adds    r3, r1, r2
        ldr     r4, =id3
        ldr     r4, [r4]
        addne   r3, r3, r4
        addeq   r3, r4, #0
        ldr     r2, =ans
        str     r3, [r2]
        mov     r1, r3
        ldr     r0, =sum
        bl      printf

        @end
        ldr     r0, =end
        bl      printf

        ldmfd   sp!, {lr}
        mov     pc, lr

else:   @add
        ldr     r1, =id1
        ldr     r1, [r1]
        ldr     r2, =id2
        ldr     r2, [r2]
        adds    r3, r1, r2
        ldr     r4, =id3
        ldr     r4, [r4]
        addne   r3, r3, r4
        addeq   r3, r4, #0
        ldr     r2, =ans
        str     r3, [r2]
        movle   r7, r7, ASR #1

        ldmfd   sp!, {lr}
        mov     pc, lr






