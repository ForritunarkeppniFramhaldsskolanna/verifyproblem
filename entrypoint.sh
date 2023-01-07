#!/bin/bash -l
set -e
cd $GITHUB_WORKSPACE
cd problems
result=0
for problem in $(cat ../CHANGED_PROBLEMS); do
    if [[ -d $problem ]]; then
        verifyproblem $problem 2>&1 | tee output
        groupcount=$(ls -l $problem/data/secret | grep ^d | wc -l)
        if ! ./check_verifyproblem_output.py $problem $groupcount ; then
            result=1
        fi
        rm output
        if ! problem2pdf $problem ; then
            echo "::error title=Error generating pdf for problem $problem::"
            result=1
        fi
    fi
done
exit $result
