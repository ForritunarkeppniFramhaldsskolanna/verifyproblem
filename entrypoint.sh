#!/bin/bash -l
set -e
cd $GITHUB_WORKSPACE
cd problems
result=0
for problem in $(cat ../CHANGED_PROBLEMS); do
    if [[ -d $problem ]]; then
        verifyproblem $problem 2>&1 | tee output
        while read -r line ; do
            echo "::error title=Error while verifying problem $problem::$line"
            result=1
        done < <(grep '^ERROR' output)
        while read -r line ; do
            echo "::warning title=Warning while verifying problem $problem::$line"
        done < <(grep '^WARNING' output)
        rm output
        if ! problem2pdf $problem ; then
            echo "::error title=Error generating pdf for problem $problem::"
            result=1
        fi
    fi
done
exit $result
