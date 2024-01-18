#!/bin/bash

# args: out_file1, out_file2, err_file, test_file
cleanup(){
    echo "rm $1" >> $4
    echo "rm $2" >> $4
    echo "rm $3" >> $4
}


#gotta create all the files before any of the funcs are called
#need diff names than just error name otherwise might overlap

# args: case1_arg1, case1_arg2, case2_arg1, case2_arg2,
#       out_file1,  out_file2,  err_file,   test_file
runandcheck(){
    echo "./calc $1 $2 > $5" >> $8

    echo "if [ $? -eq 0 ]; then" >> $8
    echo "    echo 'exit code 0 on first test case'" >> $8
    cleanup $5 $6 $7 $8
    echo "    exit 1" >> $8
    echo "fi" >> $8    

    echo "./calc $3 $4 > $6" >> $8

    echo "if [ $? -eq 0 ]; then" >> $8
    echo "    echo 'exit code 0 on second test case'" >> $8
    cleanup $5 $6 $7 $8
    echo "    exit 1" >> $8
    echo "fi" >> $8
}

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

