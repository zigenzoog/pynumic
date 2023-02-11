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

gh-deploy: #html
	@echo $(DOCSDIR)
	@echo $(TMPDIR)
#ifndef $(TMPDIR)
#	@echo "gh-pages is empty"
#endif

ifneq ($(wildcard $(GHPAGES)),)
	@echo "Found gh-pages"
	@rm -rf $(TMPDIR)
else
	@echo "Did not find gh-pages"
endif
	@cp -r . $(TMPDIR)
#	@rm -rf $(TMPDIR)
#	@cp -r . $(TMPDIR)
#	git branch -D gh-pages
#	git checkout --orphan gh-pages
#	@cp -r $(DOCSDIR)/$(BUILDDIR)/html/* .
#	git add -A
#	git commit -m "published docs to gh-pages"
#	git push origin :gh-pages
#	git push origin gh-pages
#	@rm -rf "$TMP_DIR"
