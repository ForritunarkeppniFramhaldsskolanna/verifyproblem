#!/bin/sh -l

ls -al
#cd $GITHUB_WORKSPACE/problems
for problem in *; do
    if [[ -d $problem ]]; then
        if [ ! verifyproblem $1 ] ; then
            exit 1
        fi
    fi
done
