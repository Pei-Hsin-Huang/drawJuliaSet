        .data
f:      .word 1500
g:      .word 4000000
k:      .hword 0xffff
cY:     .word 0
cX:     .word 0
array:  .word 0

        .text
        .globl drawJuliaSet

drawJuliaSet:
        stmfd   sp!, {r4-r12,lr}
        ldr     r10,=cX         @ r10 = cX
        ldr     r12,=cY         @ r12 = cY
        str     r0, [r10]       @ store cX at r10
        str     r1, [r12]       @ store cY at r12
        ldr     r10,=array      @ r10 = frame
        str     r2, [r10]       @ stpre frame at r10
        mov     r4, #0          @ x(r4) = 0
        mov     r6, #640        @ width(r6) = 640
        mov     r7, #480        @ height(r7) = 480
loop1:  cmp     r4, r6          @ x compare with width
        bge     done            @ x >= width
        movlt   r5, #0          @ r15 = y
loop2:  cmp     r5, r7          @ y compare with height
        bge     done2           @ y >= height
        mov     r10,#0          @ clean
        mov     r10,r6, ASR #1  @ tmp = width >> 1
        sub     r8, r4, r10     @ zx = x - (width>>1)
        ldr     r12,=f          @ r12 = 1500
        ldr     r12,[r12]
        mul     r8, r8, r12     @ zx = x - (width>>1) * 1500
        mov     r0, r8          @ r0 = x - (width>>1) * 1500
        mov     r1, r10         @ r1 = width >> 1
        bl      __aeabi_idiv    @ r0 = 1500*(x-(width)>>1)/(width>>1)
        mov     r8, r0          @ r8 = 1500*(x-(width)>>1)/(width>>1)
        mov     r12,r7, ASR #1  @ r12 = height>>1
        sub     r9, r5, r12     @ zy = (y-height>>1)
        mov     r10,#1000       @ tmp(r10) = 1000
        mul     r9, r9, r10     @ zy = (y-height >> 1)*1000
        mov     r0, r9          @ r0 = zy = (y-height >> 1)*1000
        mov     r1, r12         @ r1 = height>>1
        bl      __aeabi_idiv    @ r0 = (y-height >> 1)*1000 / height>>1
        mov     r9, r0          @ r9 = (y-height >> 1)*1000 / height>>1
        mov     r11,#255        @ i(r11) = 255
loop3:  mov     r12,#0          @ clean
        mul     r12,r8, r8      @ r12 = zx*zx
        mul     r10,r9, r9      @ r10 = zy*zy
        add     r12,r12,r10     @ r12 = zx*zx+zy*zy
        ldr     r10,=g          @ r10 = 4000000
        ldr     r10,[r10]
        cmp     r12,r10         @ zx*zx + zy*zy compare with 4000000
        bge     done3           @ zx*zx + zy*zy >= 4000000
        cmp     r11,#0          @ i compare with 0
        ble     done3           @ i <=0
        muls    r10,r8, r8      @ tmp = zx*zx
        mulne   r12,r9, r9      @ r12 = zy*zy
        sub     r10,r10,r12     @ tmp = zx*zx - zy*zy
        mov     r10,r10,ASR #10 @ tmp = (zx*zx - zy*zy)/1000
        ldr     r0, =cX         @ r0 = cX
        ldr     r0, [r0]        @
        add     r10,r10,r0      @ tmp = (zx*zx - zy*zy)/1000 + cX
        mul     r9, r8, r9      @ zy = zx*zy
        mov     r9, r9, LSL #1  @ zy = zx*zy*2
        mov     r9, r9, ASR #10 @ zy = (zx*zy*2)/1000
        ldr     r1, =cY         @ r1 = cY
        ldr     r1, [r1]
        add     r9, r9, r1      @ zy = (zx*zy*2)/1000 + cY
        mov     r8, r10         @ zx=tmpo = (zx*zy*2)/1000 + cY
        sub     r11,r11,#1      @ i = i--
        b       loop3

done:   ldmfd   sp!, {r4-r12,lr}
        subs    r0, r14, r13
        mov     r0, #0
        mov     pc, lr
done2:  add     r4, r4, #1      @ x = x++
        b       loop1
done3:  and     r10,r11,#0xff   @ color = i&0xff
        mov     r12,r10,LSL #8  @ r12 = i&0xff << 8
        orr     r10,r12,r10     @ color=(i&0xff<<8)|(i&0xff)
        mvn     r10,r10         @ color = ~color
        ldr     r12,=k          @ r12 = oxffff
        ldr     r12,[r12]
        and     r10,r10,r12     @ color=(-color)&0xffff
        mov     r12,#0
        mul     r12,r4, r7      @ r12 = y*height
        add     r12,r12,r12     @ r12 = y*height + y*height
        add     r12,r12,r5      @ r12 = y*height + y*height+ x
        add     r12,r12,r5      @ r12 = y*height + y*height+x+x
        ldr     r2, =array      @ r2 = frame
        ldr     r2, [r2]
        add     r12,r12,r2      @ r12 =y*height + y*height+x+x+ frame
        strh    r10,[r12]       @ store color in r12
        add     r5, r5, #1      @ y = y++
        b       loop2


