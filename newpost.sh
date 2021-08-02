#!/bin/bash
set -euo pipefail
title="${1}"
if [ -z "${title}" ]; then
	echo "Usage: ${0} 'title'"
	exit 1
fi

path="post/$(date -j '+%Y/%m/%d')/${title}.md"
git fetch origin -p
git switch -c "feature/${title}" origin/main
hugo new "${path}"
open "content/${path}"
