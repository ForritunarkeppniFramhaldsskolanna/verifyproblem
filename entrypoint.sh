#!/bin/bash -l
set -e
cd $GITHUB_WORKSPACE
cd problems
result=0
for problem in $(cat ../CHANGED_PROBLEMS); do
    if [[ -d $problem ]]; then
        verifyproblem $problem -l info 2>&1 | tee output
        groupcount=$(ls -l $problem/data/secret | grep ^d | wc -l)
        if ! pypy3 /check_verifyproblem_output.py $problem $groupcount < output; then
            result=1
        fi
        rm output
        for lang in "is" "en"; do
            if ! problem2pdf $problem -l $lang -o $problem.$lang.pdf; then
                echo "::error title=Error generating pdf for problem $problem::"
                result=1
            fi
        done
    fi
done
exit $result
