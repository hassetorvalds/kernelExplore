.section .text.init
.globl _start

_start:
    # 1. 设置栈指针 (sp) —— 最关键的一步
    la sp, _stack_top

    # 2. 初始化全局指针 (gp) —— RISC-V 特有，用于高效访问全局变量
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

    # 3. 清零 .bss 段 (未初始化全局变量默认为 0)
    la t0, _sbss
    la t1, _ebss
    li t2, 0
1:
    bgeu t0, t1, 2f
    sw t2, 0(t0)
    addi t0, t0, 4
    j 1b
2:

    # 4. 跳转到 C 世界的入口
    call kmain

    # 5. 如果 C 函数意外返回，停在这里
3:  j 3b
