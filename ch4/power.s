.section .text

    .globl _start

_start:
    pushl $3         # push second parameter
    pushl $2         # push first parameter
    call  power      # call power function
    addl  $8,   %esp # restore stack pointer
    movl  %eax, %ebx # use result as exit code
    movl  $1,   %eax # set exit syscall
    int   $0x80      # call exit syscall

    .type power, @function
power:
    pushl %ebp                # save base pointer
    movl  %esp,     %ebp      # save stack pointer in base pointer
    subl  $4,       %esp      # reserve 4 bytes from stack
    movl  8(%ebp),  %ebx      # save first parameter in %eax
    movl  12(%ebp), %ecx      # save second parameter in %ecx
    movl  %ebx,     -4(%ebp)  # store result

power_loop_start:
    cmpl  $1,       %ecx     # if the power is 1, we're done
    je    end_power
    movl  -4(%ebp), %eax     # move result to %eax
    imull %ebx,     %eax     # multiply result with base number
    movl  %eax,     -4(%ebp) # store result
    decl  %ecx               # decrement power
    jmp   power_loop_start   # run for the next power

end_power:
    movl -4(%ebp), %eax # store result in %eax
    movl %ebp,     %esp # restore stack pointer
    popl %ebp           # restore base pointer
    ret
