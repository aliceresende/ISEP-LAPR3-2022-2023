.section .data
.equ MAX_DIFERENCE_DIR, 10
.section .text
 .global sens_dir_vento

sens_dir_vento: # unsigned short sens_dir_vento(unsigned short ult_dir_vento, short comp_rand);
 
    # prologue
    pushq %rbp
    movq %rsp, %rbp

    addw %di, %si # Adiciona o último valor gerado à componente aleatória
    movw %si, %ax
    subw %di, %ax # Guarda a diferença entre o novo valor gerado e o último registo da temperatura em %al

    cmpw $MAX_DIFERENCE_DIR, %ax 
    jge new_dir_big              # verifica se a diferença é maior que 3
    cmpw $-MAX_DIFERENCE_DIR, %ax 
    jl new_dir_small            # verifica se a diferença é menor que -3
    jmp end

new_dir_big:
    addw $MAX_DIFERENCE_DIR,%di
    movw %di, %ax
    jmp end

new_dir_small:
    subw $MAX_DIFERENCE_DIR,%di
    movw %di, %ax
    jmp end

 
end:
    # epilogue
    movq %rbp,%rsp
    popq %rbp
    
    ret