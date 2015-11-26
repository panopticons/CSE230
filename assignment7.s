#################################################################
# Assignment #: 7
# Name: Maria Castro
# ASU email: Maria.F.Castro@asu.edu
# Course: CSE 230 MWF 1:30
# Description: The program asks the user to enter an integer 
# n to pass onto function1. The result from function1 is then 
# printed.
#################################################################

.data
prompt: .asciiz "Enter an integer: \n"
solution: .asciiz "The solution is: "

.text
.globl main

############################################################################
# Procedure main
# Description: main function. the program is executed
# parameters: none
# return value: none
# registers to be used: $a0, $v0
############################################################################

main:
la $a0, prompt				# address of prompt is loaded into $a0
li $v0, 4				# 4 is loaded into $v0 to call print_string()
syscall					# print_string() is called

li $v0, 5				# 5 is loaded into $v0 to call read_int()
syscall					# read_int() is called

addi $sp, $sp, -4			# stack pointer is moved down
sw $ra, 0($sp)				# return address for main is saved

move $a0, $v0				# $a0 = $v0

jal function1				# function1 is called

lw $ra, 0($sp)				# return address for main is copied back
addi $sp, $sp, 4			# stack pointer is moved up

move $t0, $v0				# $t0 = $v0

la $a0, solution			# address of solution is loaded into $a0
li $v0, 4				# 4 is loaded into $v0 to call print_string()
syscall					# print_string() is called

move $a0, $t0				# $a0 = $t0
li $v0, 1				# 1 is loaded into $v0 to call print_int()
syscall					# print_int() is called

jr $ra					# return

############################################################################
# Procedure function1
# Description: takes in user entered number and 
# parameters: $a0 = n
# return value: $v0 = 4*function1(n-1) - n*function1(n-3);
# registers to be used: $s0-$s2
############################################################################
function1:
addi $sp, $sp, -4			# stack pointer is moved down
sw $ra, 0($sp)				# return address for function1 is saved

if: 
bgt $a0, 3, else			# if $a0 > 3, go to else
addi $v0, $a0, -5			# $v0 = $a0 - 5
j end					# jump to end

else:
addi $a0, $a0, -1			# $a0 = $a0 - 1		n = n - 1
jal function1				# function1 is called
move $s1, $v0				# $s1 = $v0
addi $a0, $a0, -3			# $a0 = $a0 - 3		n = n - 3
jal function1				# function1 is called
move $s2, $v0				# $s2 = $v0

sll $s1, $s1, 2				# $s1 = $s1 * 4		4 * function1(n - 1)
mult $a0, $s2				# $a0 * $s2		n * function1(n - 3)	
mfhi $s3				# result of $a0 * $s2 stored in $s3
sub $v0, $s1, $s3			# $v0 = $s1 - $s3

end:
lw $ra, 0($sp)				# return address for main is copied back
addi $sp, $sp, 4			# stack pointer is moved up
jr $ra					# return
