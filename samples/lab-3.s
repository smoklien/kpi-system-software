; This code was created by using command '-s' in gcc compiler

	.file	"lab-3.c"
	.text
	.globl	x
	.data
	.align 4
x:
	.long	2
	.globl	z
	.bss
	.align 4
z:
	.space 4
	.text
	.globl	process_function
	.def	process_function;	.scl	2;	.type	32;	.endef
	.seh_proc	process_function
process_function:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	x(%rip), %eax
	testl	%eax, %eax
	js	.L3
	movl	x(%rip), %edx 
	movl	x(%rip), %eax 
	imull	%eax, %edx  ; AX = AX * DX (AX = x * x)
	movl	x(%rip), %eax 
	movl	%edx, %ecx 
	imull	%eax, %ecx
	movl	x(%rip), %edx
	movl	x(%rip), %eax
	imull	%edx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	addl	$11, %eax
	movl	x(%rip), %edx
	addl	%edx, %edx
	leal	1(%rdx), %ecx
	cltd
	idivl	%ecx
	movl	%eax, z(%rip)
.L3:
	nop
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	call	process_function
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (Rev3, Built by MSYS2 project) 13.2.0"
