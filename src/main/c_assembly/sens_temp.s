.section .data
.equ MAX_DIFERENCE_TEMP, 3
.section .text
 .global sens_temp

 sens_temp: # char sens_temp(char ult_temp, char comp_rand);
    # prologue
   pushq %rbp
   movq %rsp, %rbp

   addb %dil, %sil # Adiciona o último valor gerado à componente aleatória
   movb %sil, %al
   subb %dil, %al # Guarda a diferença entre o novo valor gerado e o último registo da temperatura em %al

   cmpb $MAX_DIFERENCE_TEMP, %al 
   jge new_temp_big              # verifica se a diferença é maior que 3
   jl new_temp_small            # verifica se a diferença é menor que -3
   jmp end

new_temp_big:
   addb $MAX_DIFERENCE_TEMP,%dil
   movb %dil, %al
   jmp end

new_temp_small:
   subb $MAX_DIFERENCE_TEMP,%dil
   movb %dil, %al
   jmp end

end:
    # epilogue
   movq %rbp,%rsp
   popq %rbp
   ret
    