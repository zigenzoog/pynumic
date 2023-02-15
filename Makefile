
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
GH_PAGES   = gh-pages
DOCS_DIR   = docs
SOURCE_DIR = $(DOCS_DIR)/source
BUILD_DIR  = $(DOCS_DIR)/build

list:
	@sleep .5
	@ls -A | grep -vE "Makefile|docs|.git\b|.idea|.fleet|.vscode"

html: ## build html docs
	make -C $(DOCS_DIR) html

gh-deploy: html ## deploy docs to github pages
ifeq ($(shell git ls-remote --heads . $(GH_PAGES) | wc -l), 1)
	@echo "--- Local branch $(GH_PAGES) exist."
	@echo
	@git branch -D $(GH_PAGES)
	@echo "--- Deleted branch $(GH_PAGES)."
endif
	@echo "--- Local branch $(GH_PAGES) does not exist."
	@echo
	@git checkout --orphan $(GH_PAGES)
	@echo "--- Created orphan branch $(GH_PAGES)."
	@sleep 2
	@git rm -rf $(shell ls -A | grep -vE "Makefile|docs|.git\b|.idea|.fleet|.vscode")
	@echo "--- Removed contents of branch $(GH_PAGES)."
	@mv -f $(BUILD_DIR)/html/{.[!.],}* $(DOCS_DIR)/.gitignore $(DOCS_DIR)/README.md .
	@echo "--- Moved contents from docs to root of branch $(GH_PAGES)."
	@git rm -rf docs
	@echo "--- Removed docs of branch $(GH_PAGES)."
	@git add .
	@git commit --allow-empty -m "$(GH_PAGES)"
	@git push -f origin $(GH_PAGES)
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
