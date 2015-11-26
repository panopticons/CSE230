#################################################################
# Assignment #: 3
# Name: Maria Castro
# ASU email: Maria.F.Castro@asu.edu
# Course: CSE 230 MWF 1:30
# Description: This program takes in four values and performs
# calculations on them. It then prints out the results.
#################################################################

# all variables used in the program contained under data

.data
prompt1: .asciiz "Enter a value:\n"				# prompt1 is string "Enter a value:\n"
prompt2: .asciiz "Enter another value:\n"			# prompt2 is string "Enter another value:\n"
prompt3: .asciiz "Enter one more value:\n"			# prompt3 is string "Enter one more value:\n"
new: .asciiz "\n"						# new is string "\n" a new line

answer1: .asciiz "num2+num4="					# answer1 is string "num2+num4="
answer2: .asciiz "num2-num3="					# answer2 is string "num2-num3="
answer3: .asciiz "num3*num4="					# answer3 is string "num3*num4="
answer4: .asciiz "num3/num1="					# answer4 is string "num3/num1="
answer5: .asciiz "num2 mod num4="				# answer5 is string "num2 mod num4="
answer6: .asciiz "num4+(((num1 mod num2-6)/3)*num3)="		# answer6 is string "num4+(((num1 mod num2-6)/3)*num3)="

# code starts after text

.text
.globl main		# global function main is defined

# function main begins

main:
la $a0, prompt1		# address of prompt1 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

li $v0, 5		# 5 is loaded into $v0 to call read_int()
syscall			# read_int() is called

move $t0, $v0		# value entered by user into $v0 is moved to $t0 (num1)


la $a0, prompt2		# address of prompt2 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

li $v0, 5		# 5 is loaded into $v0 to call read_int()
syscall			# read_int() is called

move $t1, $v0		# value entered by user into $v0 is moved to $t1 (num2)

la $a0, prompt3		# address of prompt3 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

li $v0, 5		# 5 is loaded into $v0 to call read_int()
syscall			# read_int() is called

move $t2, $v0		# value entered by user into $v0 is moved to $t2 (num3)

la $a0, prompt3		# address of prompt3 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

li $v0, 5		# 5 is loaded into $v0 to call read_int()
syscall			# read_int() is called

move $t3, $v0		# value entered by user into $v0 is moved to $t3 (num4)

add $s0, $t1, $t3	# answer1 (num2 + num4) is stored into $s0

sub $s1, $t1, $t2	# answer2 (num2 - num3) is stored into $s1

mult $t2, $t3		# num3 * num4 is answer3
mflo $s2		# answer 3 is stored into $s2

div $t2, $t0		# num3 / num1 is answer4
mflo $s3		# answer4 is stored into $s3

div $t1, $t3		# num2 / num4 
mfhi $s4		# remainder is taken instead of quotient, resulting in num2 mod num4 being stored into $s4 as answer5

div $t0, $t1		# div operation performed on num1 and num2
mflo $t4		# remainder is stored into $t4
addi $t5, $t4, -6	# $t5 = (num1 / num2) - 6
addi $t6, $0, 3		# $t6 = 3
div $t5, $t6		# div operation on $t5 and $t6
mflo $t7		# quotient stored in $t7
mult $t7, $t2		# $t7 * num3
mflo $t8		# result stored in $t8
add $s5, $t8, $t3	# num4 + $t8 is stored into $s5 as answer6

la $a0, answer1		# address of answer1 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

add $a0, $s0, $0	# $a0 = answer1
li $v0, 1		# 1 is loaded into $v0 to call print_int()
syscall			# print_int() is called

la $a0, new		# address of new is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

la $a0, answer2		# address of answer2 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

add $a0, $s1, $0	# $a0 = answer2
li $v0, 1		# 1 is loaded into $v0 to call print_int()
syscall			# print_int() is called

la $a0, new		# address of new is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

la $a0, answer3		# address of answer3 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

add $a0, $s2, $0	# $a0 = answer3
li $v0, 1		# 1 is loaded into $v0 to call print_int()
syscall			# print_int() is called

la $a0, new		# address of new is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

la $a0, answer4		# address of answer4 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

add $a0, $s3, $0	# $a0 = answer4
li $v0, 1		# 1 is loaded into $v0 to call print_int()
syscall			# print_int() is called

la $a0, new		# address of new is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

la $a0, answer5		# address of answer5 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

add $a0, $s4, $0	# $a0 = answer5
li $v0, 1		# 1 is loaded into $v0 to call print_int()
syscall			# print_int() is called

la $a0, new		# address of new is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

la $a0, answer6		# address of answer6 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

add $a0, $s5, $0	# $a0 = answer6
li $v0, 1		# 1 is loaded into $v0 to call print_int()
syscall			# print_int() is called

la $a0, new		# address of new is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

jr $ra			# end of main