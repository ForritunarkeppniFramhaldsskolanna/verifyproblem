#!/bin/bash -l
set -e
GITHUB_WORKSPACE=/home/tagl/FK2022
cd $GITHUB_WORKSPACE
cd problems
if [ -z ${CHANGED_PROBLEMS+x} ]; then PROBLEMS=*; else PROBLEMS=$CHANGED_PROBLEMS; fi
echo $PROBLEMS
for problem in $PROBLEMS; do
    if [[ -d $problem ]]; then
        verifyproblem $problem 2>&1 | tee output
        if [ ! -z "$(grep '^ERROR' output)" ] ; then
            exit 1
        fi
        rm output
    fi
done
