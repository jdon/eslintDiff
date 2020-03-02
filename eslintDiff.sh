#!/bin/bash
files=""
fileCount=0
branchName=$(git symbolic-ref --short -q HEAD)
compareBranch="master"

echo "Comparing branch: $branchName to $compareBranch"

for file in $(git diff --name-only $branchName $(git merge-base $branchName $compareBranch) | grep -E '\.(js)$')
do
	if test -f "$file"; then
		files+="$file "
		fileCount=$(( $fileCount + 1 ))
	fi
done

if [ "$fileCount" -gt "0" ]; then
	echo "Liniting $fileCount files:"
	echo $files
	eslint $files
else
	echo "No file changes found"
	exit 0
fi