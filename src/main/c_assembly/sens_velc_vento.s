.section .data
.equ MAX_VELC_VENTO, 75 # 75 km/h é considerado um vento muito forte

.section .text
.global sens_velc_vento


sens_velc_vento: # unsigned char sens_velc_vento(unsigned char ult_velc_vento, char comp_rand);

    # prologue
    pushq %rbp
    movq %rsp, %rbp
    movb %sil, %al
    addb %dil, %al # adiciona o último valor gerado à componente aleatória
    cmpb $MAX_VELC_VENTO, %al # se o novo valor a gerar for menor que 50, retorna o valor
    jb end
    subb %sil, %al # se ultrapassar os 75 o valor é muito grande

end:
    # epilogue
    movq %rbp,%rsp
    popq %rbp
    
    ret