.section .data
.global state
.global inc
.global num
# ###################################
.section .text
    .global pcg32_random_r

    # variables in c?
    # uint64_t state=0;
    # uint64_t inc=0;
# #########################################
pcg32_random_r:
# prologue
pushq %rbp
movq %rsp, %rbp

movq num(%rip), %rdx

movq state(%rip), %rdi
movq %rdi, -8(%rbp) # oldstate

# state = oldstate * 6364136223846793005ULL + (inc|1);
movq -8(%rbp), %rax
mulq %rdx # oldstate * 6364136223846793005ULL

movq inc(%rip), %r8
orq	$1, %r8

addq %rdx, %r8

movq %r8, state(%rip)

# uint32_t xorshifted = ((oldstate >> 18u) ^ oldstate) >> 27u;
movq -8(%rbp), %rcx # oldstate
shrq $18, %rcx # (oldstate >> 18u)

xorq -8(%rbp), %rcx # (oldstate >> 18u) ^ oldstate)

shrq $27, %rcx # ((oldstate >> 18u) ^ oldstate) >> 27u

movl %eax, -12(%rbp) # xorshifted

# uint32_t rot = oldstate >> 59u;
movq -8(%rbp), %rax
shrq $59, %rax
movl %eax, -16(%rbp) # rot

movl -16(%rbp), %eax # rot
movl -12(%rbp), %edx # xorshifted

# return (xorshifted >> rot) | (xorshifted << ((-rot) & 31));
movl %eax, %ecx
shrl %cl, %edx # (xorshifted >> rot)

movl -16(%rbp), %r9d # rot
movl -12(%rbp), %r8d # xorshifted

negl %r9d
andl $31,%r9d
movl %r9d, %ecx
sal %cl, %r8d

orl %r8d, %edx

movl %edx, %eax

#EPILOGUE
# return uint32_t
movq %rbp,%rsp
popq %rbp

ret


