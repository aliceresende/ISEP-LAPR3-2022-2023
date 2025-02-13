.section .data

.section .text
 .global sens_humd_solo

sens_humd_solo: # unsigned char sens_humd_solo(unsigned char ult_hmd_solo, unsigned char ult_pluvio, char comp_rand);
    # prologue
    pushq %rbp
    movq %rsp, %rbp

    
    # Verifica se o ult_pluvio é zero
    cmpb $0, %sil
    je notRaining

    addb %dil, %dl

notRaining:
    movb %dl, %al
    shrb $1, %al
    jmp end

end:
    # epilogue
    movq %rbp,%rsp
    popq %rbp
    ret
    