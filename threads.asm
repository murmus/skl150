BITS 64

default rel

extern puts

global thread1

thread1:

push rdi
mov rdi, qword [rdi]

call puts

pop r15

mov r10, qword [r15]
mov r14, qword [r15+8]

;caml_gc_sweep_hp
lea r13, [r14]

;limit
lea r11, [r14+0x1000]

mov qword[r13], r10
mov r8,0x7fffffffffffffff
mov qword[r11], r8

mov r12, 0
mov rsi, 1

startLoop:
	mov rdi, qword[r13]
	cmp rdi, qword [r11]
	jae end
block2:
	mov rax, qword [rdi]
	mov rdx, rax
	shr rdx, 0xa
	mov rbp, rdx
	lea rdx, [rdi+rdx*8+8]
	not rbp
	mov qword[r13], rdi
	mov rdx, rax
	add rbp, r12
	and edx, 0x300
	mov r12, rbp
	je end

block3:
	cmp rdx, 0x200
	jne block4
	int3
	int3

block4:
	and ah, 0x4f
	mov qword [rdi], rax
	jmp block5
	int3
	int3

block5:
	test rsi, rsi
	jg startLoop

end:

mov rdi, final
call puts
pop r8
pop r8 
ret

final:
db "Ending now", 0xa, 0

limit:
db 0xffffffffffffffff
