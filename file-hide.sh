#!/bin/bash

# Utility to recursively hide files.
#
# This adds the names of matching files into a .hidden file
# so that the file manager doesn't list them.
#
# Usage:
#
# hide '*.pyc'

# List all matching files, while ignoring some folders
find .                                 \
    -type f                            \
    -iname "$1"                        \
    ! -path '*/.git/*'                 \
    ! -path '*/env/*'                  \
    ! -path '*/node_modules/*'         \
| while read file; do

    basename="$(basename "$file")"
    hidden="$(dirname "$file")"/.hidden

    echo "$basename" >> "$hidden"

    # This keeps the .hidden file sorted
    # with redundant entries removed
    sort -u "$hidden" -o "$hidden"
done
