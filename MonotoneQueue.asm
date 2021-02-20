data segment
       len db 5;数组长度
       mx db 2;子串最大长度（可能存在负数，所以子串并非越长越优）
       arr db 0, 3, 3, 1, 1, 1;原数组
       pre db 0, 3, 6, 7, 8, 9;前缀和
       queue db 10 dup(0);单调队列
       ans db 0;保存答案
       l db 1;左值
       r db 1;右值
       p db 0;用于记录临时变量
       q db 0
       pos db 1;用于遍历
data ends
code segment
assume cs:code, ds:data
start:
       mov ax, data
       mov ds, ax

L1:    mov al, l
       mov bl, r
       cmp al, bl
       jbe con1
       jmp next1
con1:  mov al, pos
       mov bl, mx
       cmp al, bl
       jbe next1
       sub al, bl
       mov q, al
       mov bl, l
       mov al, queue[bx]
       mov bl, q
       cmp bl, al
       jbe next1
       mov al, l
       inc al
       mov l, al
       jmp L1

next1: mov bl, l
       mov al, queue[bx]
       mov bl, al
       mov al, pre[bx]
       mov q, al
       mov bl, pos
       mov al, pre[bx]
       mov bl, q
       cmp al, bl
       jbe next2
       sub al, bl
       mov bl, ans
       cmp al, bl
       jbe next2
       mov ans, al

next2: mov al, l
       mov bl, r
       cmp al, bl
       jbe con2
       jmp next3
con2:  mov bl, r
       mov al, queue[bx]
       mov bl, al
       mov al, pre[bx]
       mov p, al
       mov bl, pos
       mov al, pre[bx]
       mov bl, p
       cmp al, bl
       jbe con3
       jmp next3
con3:  mov al, r
       mov bl, 1
       dec al, bl
       mov r, al
       jmp next2

next3: mov bl, r
       inc bl
       mov al, pos
       mov queue[bx], al
       mov r, bl
       inc al
       mov bl, len
       cmp al, bl
       jbe con4
       jmp Finsh
con4:  mov pos, al
       jmp L1

Finsh: mov dl, ans
       add dl, 48
       mov ah, 02h
       int 21h
       mov ah, 4ch
       int 21h
code ends
end start