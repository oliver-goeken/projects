ignorefiles='./cleanup.sh ./test_generator.sh ./testcases.txt'

for file in ./*; do
    find . -name '*_temp.txt' -exec rm {} \;
done

exit 0
