#################################################################
# Assignment #: 2
# Name: Maria Castro
# ASU email: Maria.F.Castro@asu.edu
# Course: CSE 230 MWF 1:30
# Description: This program takes in two values and then returns
# both in addition to their addition and subtraction results
#################################################################

# variables used declared under data section

.data
text1: .asciiz "num1 is: "		# text1 is string "num1 is: "
text2: .asciiz "num2 is: "		# text2 is string "num2 is: "
text3: .asciiz "num1+num2 = "		# text3 is string "num1+num2 = "
text4: .asciiz "num1-num2 = "		# text4 is string "num1-num2 = "
new: .asciiz "\n"			# new is a new line: \n"

# code starts after text

.text
.globl main				# global function main is defined

# function main starts

main:

addi $t0, $0, 0xC462	# $t0 = 0xC462 (50274 in binary)
addi $t1, $0, 0xCB7	# $t1 = 0xCB7

add $s0, $t0, $t1	# $s0 = $t0 - $t1
sub $s1, $t0, $t1	# $s1 = $t0 - $t1

la $a0, text1		# address of text1 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

add $a0, $0, $t0	# a0 = $t0
li $v0, 1		# 1 is loaded into $v0 to call print_int()
syscall			# print_int() is called

la $a0, new		# address of new is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

la $a0, text2		# address of text2 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

add $a0, $0, $t1	# a0 = $t1
li $v0, 1		# 1 is loaded into $v0 to call print_int()
syscall			# print_int() is called

la $a0, new		# address of new is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

la $a0, text3		# address of text3 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

add $a0, $0, $s0	# a0 = $s0
li $v0, 1		# 1 is loaded into $v0 to call print_int()
syscall			# print_int() is called

la $a0, new		# address of new is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

la $a0, text4		# address of text4 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

add $a0, $0, $s1	# a0 = $s1
li $v0, 1		# 1 is loaded into $v0 to call print_int()
syscall			# print_int() is called

la $a0, new		# address of new is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

jr $ra			# end of main