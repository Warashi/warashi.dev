#!/bin/sh
set -eo pipefail
title="${1}"
if [ -z "${title}" ]; then
	echo "Usage: ${0} 'title'"
	exit 1
fi

path="post/$(date -j '+%Y/%m/%d')/${title}.md"
git fetch origin -p
git checkout origin/source
git checkout -b feature/${title}
hugo new ${path}
open content/${path}
