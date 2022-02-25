#!/bin/bash -l
set -e
cd $GITHUB_WORKSPACE
cd problems
git diff --name-only HEAD^ HEAD > _changed_files
grep "^problems/" _changed_files | awk -F/ '{ print $2 }' | sort -u > _changed_problems
for problem in $(cat _changed_problems); do
    if [[ -d $problem ]]; then
        verifyproblem $problem 2>&1 | tee output
        if [ ! -z "$(grep '^ERROR' output)" ] ; then
            exit 1
        fi
        rm output
    fi
done
