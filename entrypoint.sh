#!/bin/bash -l
set -e
cd $GITHUB_WORKSPACE
cd problems
for problem in $(cat ../CHANGED_PROBLEMS); do
    if [[ -d $problem ]]; then
        verifyproblem $problem 2>&1 | tee output
        if [ ! -z "$(grep '^ERROR' output)" ] ; then
            exit 1
        fi
        rm output
    fi
done
