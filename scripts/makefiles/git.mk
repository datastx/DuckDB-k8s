# git.mk: Makefile for Git operations

# Get the current branch name
BRANCH_NAME := $(shell git rev-parse --abbrev-ref HEAD)

.PHONY: push

push:
	@if [ "$(BRANCH_NAME)" = "main" ]; then \
		echo "You are on the main branch. Use git push directly if you really need to push."; \
		exit 1; \
	elif git ls-remote --exit-code --heads origin $(BRANCH_NAME) >/dev/null 2>&1; then \
		echo "Branch exists on remote. Pushing normally."; \
		git push; \
	else \
		echo "Branch doesn't exist on remote. Setting upstream and pushing."; \
		git push --set-upstream origin $(BRANCH_NAME); \
	fi


delete-local-branches:
	@echo "Cleaning local branches except main..."
	git branch | grep -v "main" | xargs git branch -D