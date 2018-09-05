#!/bin/bash

# new-post.sh
# -----------
# Creates new post from example.md
# $* - Post title

slugify () {
    echo "$1" | iconv -t ascii//TRANSLIT | sed -r s/[~\^]+//g | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z
}

WORKDIR=./_posts
EXAMPLE=$WORKDIR/example.md

TITLE=$*
SLUG=$(slugify "$TITLE")
FILE=$WORKDIR/$(date +"%Y-%m-%d")-$SLUG.md

sed "s/title:.*/title: $TITLE/" $EXAMPLE | sed 's/\r$//g' > $FILE
vim $FILE
