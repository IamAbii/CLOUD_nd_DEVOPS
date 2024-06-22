#!/bin/bash


# Welcome Script

echo "Hi Welcome to Abi's Website, I am Jarvis here for your assistance"

read -p "May I please know your name :)  " name

echo "Hi $name"

echo " ****************************************************************************************************************** "

echo  "Welcome to calculator program $name "

read -p " Please help us with the first number " num1

read -p " okay great, now give us the second number " num2

read -p " May I know what calculator operation you want to perform in + , - , * , / " operator


if [[ $operator == + ]]
then
	echo "Great you want addition operation, so here is the sum of $num1 + $num2 = $(($num1 + $num2)) "
elif [[ $operator == - ]]
then
	echo "Great you want substraction operation, so here is the difference of $num1 - $num2 = $(($num1 - $num2)) "

elif [[ $operator == / ]]
then
	if [[ $num1 -gt $num2 ]]
	then
		echo "Great you want division operation, so here is the remainder of $num1 / $num2 = $(($num1 / $num2)) "
	else
		echo "Sorry sir, num1 should be greater than num2, please try again.... BYE, Thankyou visit us again :) "
	fi

elif [[ $operator == * ]]
then
	echo "Great you want multiplication operation, so here is the product of $num1 * $num2 = $(($num1 * $num2)) "


else 
	echo "Invalid operator"
fi



