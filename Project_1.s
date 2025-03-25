.data
inputBuffer: .space 12      #buffer for 10 characters
outputNA: .asciiz "N/A"     #Output for invalid string

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
    addi $t6, $t6, -1 #$cap for uppercase, t6 = 'A' + M - 1

    li $v0, 8 #reading string command for the input
    la $a0, inputBuffer #uses input buffer
    li $a1, 12 #max amount of characters to read
    syscall #calls read command

    li $s0, 0 #starting index is 0
    li $s1, 0 #stores G in $s1
    li $s2, 0 #stores H in $s2
    li $s3, 0 #digit counter starting at 0

loop:
    bge $s0, 10, finish_loop #loop ends if index is >= 10

    la $t7, inputBuffer #loads input buffer into $t7
    add $t7, $t7, $s0 #$t7 = input buffer + i
    lb $t8, 0($t7) #loads new character into $t8

    li $t9, 0x30 #loads '0' into $t9
    li $s4, 0x39 #loads '9' into $s4
    blt $t8, $t9, check_lowercase #if the char < '0', check lowecase range
    bgt $t8, $s4, check_lowercase #if char > '9', check lowecase range

    sub $s5, $t8, $t9 #char - '0', converts ASCII to number value
    j valid_digit #jumps to valid_digit function

check_lowercase:
    li $s6, 0x61 #loads 'a' in $s6
    blt $t8, $s6, check_uppercase #if char < 'a', checks if its an uppercase
    bgt $t8, $t4, check_uppercase #if char > lowercase cap, checks if its an uppercase

    sub $s5, $t8, $s6 #if char is lowercase $s5 = char - 'a'
    addi $s5, $s5, 10 #$s5 = 10 + (char - 'a')
    j valid_digit #jumps to valid_digit function

check_uppercase:
    li $s7, 0x41 #loads 'A' into $s7
    blt $t8, $s7, not_valid #if char < 'A', not a valid char
    bgt $t8, $t6, not_valid #if char > uppercase cap, not a valid char

    sub $s5, $t8, $s7 #s5 = char - 'A'
    addi $s5, $s5, 10 #s5 = 10 + (char - 'A')
    j valid_digit #jumps to valid digit function

not_valid:
    j update_index #skips char if not a valid char

valid_digit:
    addi $s3, $s3, 1 #adds 1 to digit counter

    li $t8, 5 #loads 5 into $t8
    blt $s0, $t8, add_first #checks if index < 5 for G of input

    add $s2, $s2, $s5 #adds digit value to the H
    j update_index #jumps to update_index function

add_first:
    add $s1, $s1, $s5 #adds digit value to the G

update_index:
    addi $s0, $s0, 1 #goes to the next character
    j loop #jumps to loop function

finish_loop:
    beq $s3, $zero, print_na #prints 'N/A' if no valid digits are found

    sub $t9, $s1, $s2 #$t9 = G - H

    li $v0, 1 #command for printing an integer
    move $a0, $t9 #moves address of $t9 into $a0 to print it
    syscall #calls print command
    j exit_program #jumps to exit_program function

print_na:
    li $v0, 4 #command for printing a string
    la $a0, outputNA #loads the address of outputNA into $a0
    syscall #calls print command

exit_program:
    li $v0, 10 #command for exiting the program
    syscall #calls exit command