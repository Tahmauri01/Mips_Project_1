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
