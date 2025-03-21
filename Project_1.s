.data
inputBuffer: .space 12      #buffer for 10 characters
NAoutput: .asciiz "N/A"     #Output for invalid string

.text
.globl main

main:

    li $t0, 3134060 #loads Howrad ID into $t0
    li $t1, 11 #loads 11 into $t1
    div $t0, $t1 #divides id by 11
    mfhi $t2 #stores remainder into $t2

    li $t3, 26 #stores 26 into $t3
    add $t4, $t3, $t2 #$t4 = 26 + ($t0 % 11) or N
    li $t5, 10 #loads 10 into $t5
    sub $t6, $t4, $t5 #$t6 = $t4 - $t5 or M

    li $t7, 0x61 #stores 'a' into $t7
    add $t8, $t7, $t6 #$t8 = 'a' + M
    addi $t8, $t8, -1 #cap for lowercase

    li $t9, 0x41 #stores 'A' int $t9    