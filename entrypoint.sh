#!/bin/sh -l

pwd
ls -al
cd $GITHUB_WORKSPACE
pwd
ls -al
for problem in *; do
    if [[ -d $problem ]]; then
        if [ ! verifyproblem $1 ] ; then
            exit 1
        fi
    fi
done
