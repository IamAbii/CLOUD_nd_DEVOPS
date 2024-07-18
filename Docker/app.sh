#!/bin/bash

# Welcome Script

echo "Hi Welcome to Abi's Website, I am Jarvis here for your assistance"

read -p "May I please know your name !" name
echo " Hi , $name"

echo " ****************************************************************************************************************** "

echo "Welcome to calculator program $name"

read -p "Enter the number1 " num1
read -p "Enter the number2 " num2
read -p "Enter the operator " operator

echo "First number is: $num1"
echo "Second number is: $num2"
echo "Operation: $operator"

if [[ $operator == "+" ]]
then
    echo "Great you want addition operation, so here is the sum of $num1 + $num2 = $(($num1 + $num2))"
elif [[ $operator == "-" ]]
then
    echo "Great you want subtraction operation, so here is the difference of $num1 - $num2 = $(($num1 - $num2))"
elif [[ $operator == "/" ]]
then
    if [[ $num1 -gt $num2 && $num2 -ne 0 ]]
    then
        echo "Great you want division operation, so here is the result of $num1 / $num2 = $(($num1 / $num2))"
    else
        echo "Sorry, for division num1 should be greater than num2, and num2 should not be zero. Please try again."
    fi
elif [[ $operator == "*" ]]
then
    echo "Great you want multiplication operation, so here is the product of $num1 * $num2 = $(($num1 * $num2))"
else 
    echo "Invalid operator"
fi