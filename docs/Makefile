# Minimal makefile for Sphinx documentation

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option. $(O) is meant as a shortcut for $(SPHINXOPTS).
%:
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

clean:
	@rm -rf $(BUILDDIR)/*

html: clean
	@$(SPHINXBUILD) -b html $(SOURCEDIR)/ $(BUILDDIR)/html
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

# Publish docs to github pages.
GHPAGES = gh-pages
DOCSDIR = $(shell pwd)
TMPDIR  = $(DOCSDIR)/$(GHPAGES)
exists = `git show-ref --quiet refs/heads/master`

#ifeq (exists, 0)
#ifeq ($(git show-ref --quiet refs/heads/master), master)
#ifeq ($(git show-ref --verify --quiet refs/heads/master2), 0)
#ifdef ($(git rev-parse --verify master),0)
#ifdef $(git branch --list master | grep master)
#ifdef $(shell git show-ref --quiet refs/heads/master)
	#
	#@echo $(DOCSDIR)
	#@echo $(git rev-parse --verify master)
	#@echo $(git branch --list $(GHPAGES) | grep $(GHPAGES))
	#@echo $(git branch --list master | grep master)


# проверяем есть ли локальная ветка gh-pages, если нет создаём
# если есть, удаляем старый контент
# копируем из docs/build/html в ветку gh-pages
# проверяем есть ли удалённая ветка gh-pages, если нет создаём
# пушим из локального в удалённый репозиторий
gh-deploy: #html ## deploy docs to github pages
ifeq ($(shell git ls-remote --heads . $(GHPAGES) | wc -l), 1)
	@echo "Local branch $(GHPAGES) exist"
else
	@echo "Local branch $(GHPAGES) does not exist"
	git checkout --orphan $(GHPAGES)
	ls -la |awk '{print $9}' |grep -v git |xargs -I _ rm -rf ./_
	git rm -rf .
	git commit --allow-empty -m "$(GHPAGES) init"
	#git push -u origin $(GHPAGES)
endif

ifeq ($(shell git ls-remote --heads origin $(GHPAGES) | wc -l), 0)
	@echo "Remote branch $(GHPAGES) does not exist"
endif
	#git push -u origin $(GHPAGES)



#ifndef $(TMPDIR)
#	@echo "gh-pages is empty"
#endif

# ifneq ($(wildcard $(GHPAGES)),)
# 	@echo "Found gh-pages"
# 	@rm -rf $(TMPDIR)
# else
# 	@echo "Did not find gh-pages"
# endif
# 	@cp -r . $(TMPDIR)

# 	git branch -D $(GHPAGES)
# 	git checkout --orphan $(GHPAGES)
# 	git reset
# 	git rm --cached -r
# 	git commit --allow-empty -m "gh-pages init"
# 	git push -u origin $(GHPAGES)

#	@cp -r $(DOCSDIR)/$(BUILDDIR)/html/* .
#	git add -A
#	git commit -m "published docs to gh-pages"
#	git push origin :gh-pages
#	git push origin gh-pages
#	@rm -rf "$TMP_DIR"
