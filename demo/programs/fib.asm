; Program to compute the Fibonacci sequence

ldi 0x01    ; Load 1 into the Accumulator as a starting value
sta 0x0100  ; Store 1 at memory location 0x0100

cla         ; Set acc to 0
mva         ; copy acc into DR
sta 0x0101  ; Store 0 at memory location 0x0101


@loop1

;;; c = a + b ;;;
; Load a in to DR
lda 0x0100
mva

; Load b into ACC
lda 0x0101

; Add a + b and store it at memory location 0x0102
add
sta 0x0102

;;; a = b ;;;
; Load b into accumulator
lda 0x0101
; Replace a with the current value of b
sta 0x0100

;;; b = c ;;;
lda 0x0102
sta 0x0101


;;; End if computed value is 233 (prevent overflow problems) ;;;
ldi 0xE9    ; Load 233 into accumulator
mva         ; Move 233 into DR

lda 0x0102  ; Load c into accumulator
eq          ; ACC=1 if(c==233) -> if(ACC==DR)
JPNZ @end   ; If acc is not 0, jump to the end of the program

jmp loop1

@end
nop
jmp end