// kmain.c
#define UART0_BASE 0x10000000

void uart_putc(char c) {
    *(volatile char *)UART0_BASE = c;
}

void kmain(void) {
    uart_putc('C'); // 输出 'C'，代表 C 语言世界已启动
    while (1);    // 内核不应返回
}
