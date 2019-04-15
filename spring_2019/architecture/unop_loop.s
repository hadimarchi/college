	.file	"loop.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -52(%rbp)
	movl	$0, -56(%rbp)
	jmp	.L2
.L3:
	movl	-56(%rbp), %eax
	cltq
	movl	-56(%rbp), %edx
	movl	%edx, -48(%rbp,%rax,4)
	movl	-56(%rbp), %eax
	cltq
	movl	-48(%rbp,%rax,4), %eax
	addl	%eax, -52(%rbp)
	addl	$1, -56(%rbp)
.L2:
	cmpl	$9, -56(%rbp)
	jle	.L3
	movl	-52(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L5
	call	__stack_chk_fail@PLT
.L5:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
