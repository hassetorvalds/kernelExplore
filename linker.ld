ENTRY(_start)

PHDRS
{
    text PT_LOAD FLAGS(5);  /* R + X */
    data PT_LOAD FLAGS(6);  /* R + W */
}

SECTIONS
{
    . = 0x80000000;

    .text : {
        *(.text.init)
        *(.text*)
    } :text

    .rodata : {
        *(.rodata*)
    } :text

    .data : {
        *(.data*)
        . = ALIGN(16);
        __global_pointer$ = . + 0x800;
    } :data

    .bss (NOLOAD) : {
        _sbss = .;
        *(.bss*) *(COMMON)
        _ebss = .;
        . = ALIGN(16);
    } :data

    .stack (NOLOAD) : {
        . = ALIGN(16);
        . = . + 0x4000;
        _stack_top = .;
    } :data
}
