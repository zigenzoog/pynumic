
upgrade: ## upgrade pip
	python -m pip install --upgrade pip

lint: ## lint
	mypy src --ignore-missing-imports
	flake8 src --ignore=$(shell cat .flakeignore)
	black src

clean: ## clean
	poetry cache clear pypi --all
	@rm -rf .pytest_cache/ .mypy_cache/ junit/ build/ dist/
	@find . -not -path './.venv*' -path '*/__pycache__*' -delete
	@find . -not -path './.venv*' -path '*/*.egg-info*' -delete

update: ## update poetry
	poetry update
	poetry self update

check: ## check poetry
	poetry check

build: ## build project
	poetry build

publish: build ## publish project
	poetry publish

# Publish docs to github pages.
GHPAGES  = gh-pages
BUILDDIR = docs/build

# проверяем есть ли локальная ветка gh-pages, если нет создаём
# если есть, удаляем старый контент
# копируем из docs/build/html в ветку gh-pages
# проверяем есть ли удалённая ветка gh-pages, если нет создаём
# пушим из локального в удалённый репозиторий

list:
#	${MAKE} -C docs html
#ifdef $(shell pwd)/docs/build/html/
#ifeq ($(wildcard $(shell pwd)/docs/build/html), 0)
#	@echo $(shell find docs/build -name "html2")
ifneq ($(shell find docs/build -name "html"),)
	@echo "html exist"
else
	@echo "html does not exist"
endif

gh-deploy: ## deploy docs to github pages
	${MAKE} -C docs html
ifeq ($(shell git ls-remote --heads . $(GHPAGES) | wc -l), 1)
	@echo "Local branch $(GHPAGES) exist"
	@echo
else
	@echo "Local branch $(GHPAGES) does not exist"
	@echo
	@git checkout --orphan $(GHPAGES)
	@git rm -rf $(shell ls | grep -E -v "Makefile|docs|.git*")
	@mv $(BUILDDIR)/html/* .
	@git rm -rf docs
	@git add .
	@git commit --allow-empty -m "$(GHPAGES)"
	@git push origin $(GHPAGES)
	@git switch master
endif

ifeq ($(shell git ls-remote --heads origin $(GHPAGES) | wc -l), 1)
	@echo "Remote branch $(GHPAGES) exist"
	@echo
else
	@echo "Remote branch $(GHPAGES) does not exist"
	@echo
endif

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
