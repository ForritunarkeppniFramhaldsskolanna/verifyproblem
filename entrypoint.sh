#!/bin/bash -l
set -e
cd $GITHUB_WORKSPACE
cd problems
for problem in *; do
    if [[ -d $problem ]]; then
        ln -s $problem/input_validators $problem/input_format_validators # Remove this when docker image is updated
        verifyproblem $problem 2>&1 | tee output
        if [ ! -z "$(grep '^ERROR' output)" ] ; then
            exit 1
        fi
        rm output
    fi
done
