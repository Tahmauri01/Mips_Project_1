.data
inputBuffer: .space 12      #buffer for 10 characters
NAoutput: .asciiz "N/A"     #Output for invalid string

.text
.globl main

main:

    li $t0, 32 #N calculated
    li $t1, 10 #loads 10 into $t1

    sub $t2, $t0, $t1 #M = $t0 - $t1

    li $t3, 0x61 #stores 'a' into $t3
    add $t4, $t3, $t2 #$t4 = 'a' + M
    addi $t4, $t4, -1 #cap for lowercase, $t4 = 'a' + M - 1

    li $t5, 0x41 #stores 'A' int $t5
    add $t6, $t5, $t2 #$t6 = 'A" + M
    addi $t6, $t6, -1 #$cap for uppercase, t6 = 'A' + M -1

    li $v0, 8 #reading string command for the input
    la $a0, inputBuffer #calls input buffer
    li $a1, 12 #max amount of characters to read