# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

import os
import sys

from pynumic.__version__ import __version__

sys.path.insert(0, os.path.abspath('../src'))

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'PyNumic'
project_copyright = '2023, Oleg Alexandrov'
author = 'Oleg Alexandrov'
version = __version__
release = __version__

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.coverage',
    'sphinx.ext.viewcode',
    'sphinx.ext.duration',
    'sphinx.ext.doctest',
    'sphinx.ext.autosummary',
    'sphinx.ext.githubpages'
]
templates_path = ['_templates']
exclude_patterns = [
    'build',
    'Thumbs.db',
    '.DS_Store'
]
source_suffix = {
    '.rst': 'restructuredtext',
    '.txt': 'restructuredtext',
    '.md': 'markdown'
}
autosummary_generate = True
todo_include_todos = False
master_doc = 'index'

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_baseurl = ''  # https://zigenzoog.github.io/pynumic
html_static_path = ['_static']
html_theme = 'classic'
html_theme_options = {
    'github_button': True,
    'github_banner': False,
    'github_type':   'star&v=2',
    'github_user':   'zigenzoog',
    'github_repo':   'pynumic'
}
html_title = project + ' - Simple neural network library'
html_short_title = project
html_show_copyright = False
html_show_sphinx = False
