#!/bin/bash -l

cd $GITHUB_WORKSPACE
cd problems
for problem in *; do
    if [[ -d $problem ]]; then
        if [ ! verifyproblem $1 ] ; then
            exit 1
        fi
    fi
done
