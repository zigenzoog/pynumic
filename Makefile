
upgrade: ## upgrade pip
	python -m pip install --upgrade pip

lint: ## lint
	mypy src --ignore-missing-imports
	flake8 src --ignore=$(shell cat .flakeignore)
	black src
	pylint src

clean: ## clean
	poetry cache clear pypi --all
	@rm -rf .pytest_cache/ .mypy_cache/ junit/ build/ dist/
	@find . -not -path "./.venv*" -path "*/__pycache__*" -delete
	@find . -not -path "./.venv*" -path "*/*.egg-info*" -delete

poetry.update: ## update poetry
	poetry update
	poetry self update

poetry.check: ## check poetry
	poetry check

poetry.build: ## build project
	poetry build

poetry.publish: poetry.build ## publish project
	poetry publish

# Publish docs to github pages.
GHPAGES  = gh-pages
BUILDDIR = docs/build

gh-deploy: ## deploy docs to github pages
	${MAKE} -f ./docs/Makefile html
ifeq ($(shell git ls-remote --heads . $(GHPAGES) | wc -l), 1)
	@echo "Local branch $(GHPAGES) exist."
	@echo
	@git switch $(GHPAGES)
	@git checkout master $(BUILDDIR)/html/*
else
	@echo "Local branch $(GHPAGES) does not exist."
	@echo
	@git checkout --orphan $(GHPAGES)
	@git rm -rf $(shell ls | grep -E -v "Makefile|docs|.git*|.idea")
	@mv $(BUILDDIR)/html/* .
	@git rm -rf docs
endif
	@git add .
	@git commit --allow-empty -m "$(GHPAGES)"
	@git push origin $(GHPAGES)
	@git switch master

set-url: ## git remote set-url origin git@github.com:login/repo.git
	git remote set-url origin git@github.com:zigenzoog/pynumic.git

.PHONY: help clean build update publish
help:
	@awk '                                             \
		BEGIN {FS = ":.*?## "}                         \
		/^[a-zA-Z_-]+:.*?## /                          \
		{printf "\033[36m%-24s\033[0m %s\n", $$1, $$2} \
	'                                                  \
	$(MAKEFILE_LIST)

.DEFAULT_GOAL := help
