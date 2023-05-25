# mat in %eax, num_rows in %ecx, num_cols in %ebx
# display mat function
_start:
mov i, 0
mov j, 0
mov num_rows, 0
mov num_cols, 0
mov %eax, mat



section .data
    ; Define constants
    ROWS_A equ 100 ; Maximum number of rows in matrix A
    COLS_A equ 100 ; Maximum number of columns in matrix A
    ROWS_B equ 100 ; Maximum number of rows in matrix B
    COLS_B equ 100 ; Maximum number of columns in matrix B

section .bss
    ; Define variables
    mat_a resd ROWS_A*COLS_A ; Matrix A
    mat_b resd ROWS_B*COLS_B ; Matrix B
    mat_c resd ROWS_A*COLS_B ; Resultant matrix C

section .text
    global _start

_start:
    ; Read command-line arguments
    mov eax, 4          ; System call number for write
    mov ebx, 1          ; File descriptor 1 (stdout)
    mov edx, len_prompt ; Length of the prompt
    mov ecx, prompt     ; Address of the prompt
    int 0x80            ; Call the kernel

    ; Check if enough arguments are provided
    cmp dword [esp+4], 3
    jl exit_program

    ; Read matrices from files
    push dword [esp+12] ; Push the address of matrix A file name
    call readMat        ; Call readMat function to read matrix A
    add esp, 4          ; Clean up the stack

    push dword [esp+12] ; Push the address of matrix B file name
    call readMat        ; Call readMat function to read matrix B
    add esp, 4          ; Clean up the stack

    ; Perform matrix multiplication
    push ROWS_A          ; Push number of rows in matrix A
    push COLS_A          ; Push number of columns in matrix A
    push ROWS_B          ; Push number of rows in matrix B
    push COLS_B          ; Push number of columns in matrix B
    push mat_b           ; Push the address of matrix B
    push mat_a           ; Push the address of matrix A
    call matMult         ; Call matMult function to perform multiplication
    add esp, 20          ; Clean up the stack

    ; Display the resultant matrix
    push COLS_B          ; Push number of columns in matrix B (resultant matrix columns)
    push ROWS_A          ; Push number of rows in matrix A (resultant matrix rows)
    push mat_c           ; Push the address of the resultant matrix C
    call displayMat      ; Call displayMat function to display the matrix
    add esp, 12          ; Clean up the stack

    ; Exit the program
exit_program:
    mov eax, 1      ; System call number for exit
    xor ebx, ebx    ; Exit status 0
    int 0x80        ; Call the kernel

readMat:
    ; Function to read a matrix from a file
    ; Arguments:
    ;   [esp+4] - Address of the file name
    ;   [esp+8] - Address of the matrix
    ;   [esp+12] - Address of the number of rows
    ;   [esp+16] - Address of the number of columns
    ; Clobbered registers: eax, ebx, ecx, edx

    push ebp
    mov ebp, esp

    ; Open the file
    mov eax, 5          ; System call number for open
    mov ebx, [ebp+8]    ; Address



