.section .data

.section .text
 .global sens_humd_atm

sens_humd_atm: # unsigned char sens_humd_solo(unsigned char ult_hmd_solo, unsigned char ult_pluvio, char comp_rand);
    # prologue
    pushq %rbp
    movq %rsp, %rbp
    addb %dil, %al # Adiciona-se a modificação a ult_hmd_solo

    # Verifica se o ult_pluvio é zero
    cmpb $0, %sil
    je notRaining

    # Se ult_pluvio não for zero, define-se a modificação com o valor de comp_rand
    movb %dl, %al

notRaining:
    movb %dl, %al
    shrb $1, %al

end:
    # epilogue
    movq %rbp,%rsp
    popq %rbp
    ret