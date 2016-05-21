.section .bss

    .lcomm my_buffer, 500

.section .text

    .globl _start

_start:
    movl %esp,       %ebp      # save stack pointer
    subl $8,         %esp      # allocate 4 bytes for storing input fd and read bytes

    ### Open Input File ###
    movl $5,         %eax      # 'open' syscall
    movl 8(%ebp),    %ebx      # set filename
    movl $0,         %ecx      # set flag
    movl $0666,      %edx      # set permissions
    int  $0x80                 # syscall
    movl %eax,       -4(%ebp)  # store fd

    ### Read Input File ###
    movl $3,         %eax      # 'read' syscall
    movl -4(%ebp),   %ebx      # pass fd
    movl $my_buffer, %ecx      # pass buffer
    movl $500,       %edx      # pass size
    int  $0x80
    movl %eax,       -8(%ebp)  # store read bytes

    ### Close Input File ###
    movl $2,         %eax      # 'close' syscall
    movl -4(%ebp),   %ebp      # pass fd
    int  $0x80

    ### Write To STDOUT ###
    movl $4,         %eax      # 'read' syscall
    movl $1,         %ebx      # pass fd
    movl $my_buffer, %ecx      # pass buffer
    movl -8(%ebp),   %edx      # pass size
    int  $0x80

    ### Exit ###
    movl $1,         %eax      # 'exit' syscall
    movl $0,         %ebx      # 0 exit status
