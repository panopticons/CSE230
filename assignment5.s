#################################################################
# Assignment #: 5
# Name: Maria Castro
# ASU email: Maria.F.Castro@asu.edu
# Course: CSE 230 MWF 1:30
# Description: This program reads in two integers and calculates
# the sum of the numbers between them.
#################################################################

.data
numbers_len:         .word     14 								# array of size 14
numbers:             .word     11, 24, 3, -6, 14, -18, 21, 45, 12, -27, 35, -7, 44, -28		# array called numbers being initialized

prompt: .asciiz "Enter an integer: \n"								# prompt is string "Enter an integer: \n"	
prompt1: .asciiz "Enter another integer: \n"							# prompt1 is string "Enter another integer: \n"
result: .asciiz "The sum of numbers that are inbetween: "					# result is string "The sum of numbers that are inbetween: "

.text
.globl main			# global function main

main:
la $a0, prompt			# address of prompt is loaded into $a0
li $v0, 4 			# 4 is loaded into $v0 to call print_string()
syscall				# print_string() is called

li $v0, 5			# 5 is loaded into $v0 to call read_int()
syscall				# read_int() is called

move $s0, $v0			# user entered integer ($v0) is placed into $s0 (num1)

la $a0, prompt1			# address of prompt1 is loaded into $a0
li $v0, 4 			# 4 is loaded into $v0 to call print_string()
syscall				# print_string() is called

li $v0, 5			# 5 is loaded into $v0 to call read_int()
syscall				# read_int() is called

move $s1, $v0			# user entered integer ($v0) is placed into $s1 (num2)

if:
slt $t0, $s0, $s1		# if $s0 < $s1, $t0 = 1
beq $t0, $0, else		# branch to else if $t0 = 0
add $s2, $0, $s0		# $s2 (min) = num1
add $s3, $0, $s1		# $s3 (max) = num2
j next				# jump to next

else:
add $s2, $0, $s1		# $s2 = num2
add $s3, $0, $s0		# $s3 = num1

next:
li $t1, 0			# ($t1) i = 0
li $s4, 0			# $s4 (sum) = 0
la $s5, numbers			# base address of array "numbers" is loaded into $s5
lw $s6, numbers_len		# $s6 = numbers_len = 14

loop:
slt $t0, $t1, $s6		# if $t1 < $s6, $t0 = 0
beq $t0, $0, loop_end		# branch to loop_end if $t0 = 0
sll $t3, $t1, 2			# $t3 (offset) = $t1 * 4
add $t3, $t3, $s5		# $t3 = $t3 + $s5
lw $t3, 0($t3)			# $t3 = numbers[i]

blt $t3, $s2, else1		# if $t3 < $s2, go to else1
bgt $t3, $s3, else1		# if $t3 > $s3, go to else1

add $s4, $s4, $t3		# $s4 = $s4 + $t3

else1:
addi $t1, $t1, 1		# $t1 = $t1 + 1 = i++

j loop				# jump to loop

loop_end:
la $a0, result			# address of result is loaded into $a0
li $v0, 4			# 4 is loaded into $v0 to call print_string()
syscall				# print_string() is called

move $a0, $s4			# $a0 = $s4
li $v0, 1			# 1 is loaded into $v0 to call print_int()
syscall				# print_int() is called

jr $ra				# return