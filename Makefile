TITLE ?= untitled
TODAY = $(shell date '+%Y/%m/%d')

content/post/$(TODAY)/$(TITLE).md:
	git fetch origin main
	git switch -C 'feature/$@' FETCH_HEAD
	hugo new '$(@:content/%=%)'
