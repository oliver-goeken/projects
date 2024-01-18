#!/bin/bash

case1_arg1=""
case1_arg2=""
case2_arg1=""
case2_arg2=""
err_message=""

counter=0

# while loop found from:
# https://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash
while IFS='' read line; do
    for word in $line; do
        if [ $counter -eq 0 ]; then
            case1_arg1=$word
        fi
        if [ $counter -eq 1 ]; then
            case1_arg2=$word
        fi
        if [ $counter -eq 2 ]; then
            case2_arg1=$word
        fi
        if [ $counter -eq 3 ]; then
            case2_arg2=$word
        fi
        if [ $counter -eq 4 ]; then
            err_message=$word
            counter=-1
        fi
        counter=$((counter+1))
    done

    filename="${err_message}_temp.txt"

    echo $case1_arg1 $case1_arg2 $case2_arg1 $case2_arg2 $err_message > $filename
    
done < testcases.txt

