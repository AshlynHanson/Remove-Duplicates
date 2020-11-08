#!/bin/bash

# Ashlyn Hanson
# This program takes in a path file to a directory and checks
# if there are duplicates in the file.
# If the directory does not exist the program exits with 1.
# If there is no directory inputed the program uses the
# current working directory. The script does this by checking
# if the number of arguments inputed is equal to zero and if
# so uses the current working directory pwd
# In order to display all of the duplicate files in the
# directory the script finds all the non empty files and
# their md5sum values. Those files are piped into sort which
# sorts duplicate lines using the uniq command. The uniq
# command checks for duplicates based on the first 32 lines
# of the md5sum value. The -dD command with uniq causes only the
# duplicated lines to be displayed. So all the duplicate will be
# displayed.

if [[ -d $1 ]]
then
  directory=$1
elif [[ $# -eq 0 ]]
then
  directory=$pwd
else
  echo "Directory does not exist"
  exit 1
fi

echo "==============================================================="
echo "               Size                         File Path"
echo "==============================================================="

# finds all of the files in the given directory and its size
# by its md5sum. Those files are piped into sort and organized in
# numerical order. That is then piped into uniq which finds duplicate
# files that are next to each other consecutively. The -w32 command
# causes uniq to only compare the first 32 values. The -dD prints
# all of the duplicate values.
find $directory ! -type f -exec md5sum {} + | sort | uniq -w32 -dD

exit 0
