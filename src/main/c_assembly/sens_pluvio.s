.section .data

.section .text
 .global sens_pluvio

.section .data

.section .text
 .global sens_pluvio

sens_pluvio: # unsigned char sens_pluvio(unsigned char ult_pluvio, char ult_temp, char comp_rand);
    # prologue
    pushq %rbp
    movq %rsp, %rbp

    addb %dil, %sil
    movb %sil, %al

    cmpb $0, %dil # verifica se o ult_pluvio é zero
    jz pluvio_zero

    cmpb $0, %sil # calcula o valor de modificação com base no ult_temp
    jge temp_positive
    negb %sil      # nega se for negativo

temp_positive:
    addb %sil, %sil  # duplica o valor da temperatura
    addb %sil, %dl  # adiciona à componente aleatória
    movb %dl, %al
    jmp end

pluvio_zero:
    cmpb $0, %sil
    jge end
    xorb %al, %al
end:  
    # epilogue
    movq %rbp,%rsp
    popq %rbp
    ret