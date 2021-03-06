.PHONY : all clean chapters commands crossrefs fixme gloss html links nbspref settings tex-packages

INDEX_HTML=_book/index.html
ALL_HTML=_book/py/index.html _book/r/index.html _book/py-rse/index.html _book/r-rse/index.html
ALL_PDF=_book/py/py.pdf _book/r/r.pdf _book/py-rse/py-rse.pdf _book/r-rse/r-rse.pdf
EXTRA=climate-data data src zipfs-law

R_FILES=\
  _r.yml \
  r-index.Rmd \
  novice-goals.Rmd \
  r/intro.Rmd \
  r/getting-started.Rmd \
  r/practice.Rmd \
  r/reproducibility.Rmd \
  r/data-manipulation.Rmd \
  r/publishing.Rmd \
  r/objectives.Rmd \
  r/keypoints.Rmd

PY_FILES=\
  _py.yml \
  py-index.Rmd \
  novice-goals.Rmd \
  py/intro.Rmd \
  py/getting-started.Rmd \
  py/data-manipulation.Rmd \
  py/development.Rmd \
  py/objectives.Rmd \
  py/publishing.Rmd \
  py/keypoints.Rmd \
  py/version-control.Rmd

R_RSE_FILES=\
  _r-rse.yml \
  r-rse-index.Rmd \
  r-rse/bash-basics.Rmd \
  r-rse/bash-advanced.Rmd \
  r-rse/git-cmdline.Rmd \
  r-rse/git-advanced.Rmd \
  r-rse/style.Rmd \
  r-rse/automate.Rmd \
  r-rse/teams.Rmd \
  r-rse/project.Rmd \
  r-rse/ci.Rmd \
  r-rse/package-r.Rmd \
  r-rse/correct.Rmd \
  r-rse/publish.Rmd \
  r-rse/finale.Rmd \
  r-rse/objectives.Rmd \
  r-rse/keypoints.Rmd \
  r-rse/solutions.Rmd \
  r-rse/yaml.Rmd \
  r-rse/ssh.Rmd

PY_RSE_FILES=\
  _py-rse.yml \
  py-rse-index.Rmd \
  py-rse/bash-basics.Rmd \
  py-rse/bash-advanced.Rmd \
  py-rse/py-scripting.Rmd \
  py-rse/git-cmdline.Rmd \
  py-rse/git-advanced.Rmd \
  py-rse/automate.Rmd \
  py-rse/configuration.Rmd \
  py-rse/errors.Rmd \
  py-rse/teams.Rmd \
  py-rse/style.Rmd \
  py-rse/project.Rmd \
  py-rse/correct.Rmd \
  py-rse/ci.Rmd \
  py-rse/package-py.Rmd \
  py-rse/publish.Rmd \
  py-rse/finale.Rmd \
  py-rse/objectives.Rmd \
  py-rse/keypoints.Rmd \
  py-rse/solutions.Rmd \
  py-rse/yaml.Rmd \
  py-rse/ssh.Rmd

COMMON_FILES=\
  _common.R \
  appendix.Rmd \
  LICENSE.md \
  CONDUCT.md \
  CONTRIBUTING.md \
  gloss.md \
  references.Rmd \
  links.md \
  book.bib

ALL_FILES=${R_FILES} ${PY_FILES} ${PY_RSE_FILES} ${COMMON_FILES} ${R_RSE_FILES}

#-------------------------------------------------------------------------------

all : commands

## commands     : show all commands.
commands :
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g'

## everything   : rebuild all HTML and PDF.
everything : ${ALL_HTML} ${INDEX_HTML}

##   r          : rebuild novice R HTML and PDF.
r : _book/r/index.html _book/r/rse.pdf

##   py         : rebuild novice Python HTML and PDF.
py : _book/py/index.html _book/py/rse.pdf

##   py-rse     : rebuild RSE PY HTML and PDF.
py-rse : _book/py-rse/index.html _book/py-rse/py-rse.pdf

##   r-rse      : rebuild RSE R HTML and PDF.
r-rse : _book/r-rse/index.html _book/r-rse/r-rse.pdf

#-------------------------------------------------------------------------------

## html           : build all HTML versions.
html : ${ALL_HTML}

##   r-html       : build novice R HTML.
r-html : _book/r/index.html

##   py-html      : build novice Python HTML.
py-html : _book/py/index.html

##   py-rse-html  : build RSE PY HTML.
py-rse-html : _book/py-rse/index.html

##   r-rse-html   : build RSE R HTML.
r-rse-html : _book/r-rse/index.html

_book/r/index.html : ${R_FILES} ${COMMON_FILES} ${INDEX_HTML}
	rm -f r.Rmd
	cp r-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::gitbook', config_file='_r.yml'); warnings()"

_book/py/index.html : ${PY_FILES} ${COMMON_FILES} ${INDEX_HTML}
	rm -f py.Rmd
	cp py-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::gitbook', config_file='_py.yml'); warnings()"

_book/py-rse/index.html : ${PY_RSE_FILES} ${COMMON_FILES} ${INDEX_HTML}
	rm -f py-rse.Rmd
	cp py-rse-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::gitbook', config_file='_py-rse.yml'); warnings()"

_book/r-rse/index.html : ${R_RSE_FILES} ${COMMON_FILES} ${INDEX_HTML}
	rm -f r-rse.Rmd
	cp r-rse-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::gitbook', config_file='_r-rse.yml'); warnings()"

${INDEX_HTML} : ./_index.html
	mkdir -p _book
	cp ./_index.html ${INDEX_HTML}
	cp -r ${EXTRA} _book

#-------------------------------------------------------------------------------

## pdf          : build PDF version.
pdf : ${ALL_PDF} ${INDEX_HTML}

##   r-pdf      : build novice R PDF.
r-pdf : _book/r/r.pdf

##   py-pdf     : build novice Python PDF.
py-pdf : _book/py/py.pdf

##   py-rse-pdf : build RSE PY PDF.
py-rse-pdf : _book/py-rse/py-rse.pdf

##   r-rse-pdf  : build RSE R PDF.
r-rse-pdf : _book/r-rse/r-rse.pdf

_book/r/r.pdf : ${R_FILES} ${COMMON_FILES}
	rm -f r.Rmd
	cp r-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::pdf_book', config_file='_r.yml'); warnings()"

_book/py/py.pdf : ${PY_FILES} ${COMMON_FILES}
	rm -f py.Rmd
	cp py-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::pdf_book', config_file='_py.yml'); warnings()"

_book/py-rse/py-rse.pdf : ${PY_RSE_FILES} ${COMMON_FILES}
	rm -f py-rse.Rmd
	cp py-rse-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::pdf_book', config_file='_py-rse.yml'); warnings()"

_book/r-rse/r-rse.pdf : ${R_RSE_FILES} ${COMMON_FILES}
	rm -f r-rse.Rmd
	cp r-rse-index.Rmd index.Rmd
	Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::pdf_book', config_file='_r-rse.yml'); warnings()"


#-------------------------------------------------------------------------------

## clean        : clean up generated files.
clean :
	@rm -rf _book _bookdown_files _main.Rmd *.log index.Rmd r.Rmd py.Rmd py-rse.Rmd r-rse.Rmd
	@find . -name '*~' -exec rm {} \;

## chapters     : check consistency of chapters.
chapters :
	@make settings | bin/chapters.py _py-rse.yml PY_RSE_FILES py-rse/objectives.Rmd py-rse/keypoints.Rmd

## crossrefs    : check cross-references.
crossrefs :
	@bin/crossrefs.py "Novice R" ${R_FILES} ${COMMON_FILES}
	@bin/crossrefs.py "Novice Python" ${PY_FILES} ${COMMON_FILES}
	@bin/crossrefs.py "RSE PY" ${PY_RSE_FILES} ${COMMON_FILES}
	@bin/crossrefs.py "RSE R" ${R_RSE_FILES} ${COMMON_FILES}

## fixme        : list all the FIXME markers
fixme :
	@fgrep FIXME ${ALL_FILES}

## gloss        : check that all glossary definitions are defined and used.
gloss :
	@bin/gloss.py ./gloss.md ${ALL_FILES}

## images       : check that all images are defined and used.
images :
	@bin/images.py ./figures ${ALL_FILES}

## links        : check that all links are defined and used.
links :
	@bin/links.py ./links.md ${ALL_FILES}

## nbspref      : check that all cross-references are prefixed with a non-breaking space.
nbspref :
	@bin/nbspref.py ${ALL_FILES}

## tex-packages : install required LaTeX packages.
tex-packages :
	-tlmgr install $$(cat ./tex-packages.txt)

## settings     : echo all variable values.
settings :
	@echo ALL_HTML: ${ALL_HTML}
	@echo ALL_PDF: ${ALL_PDF}
	@echo R_FILES: ${R_FILES}
	@echo PY_FILES: ${PY_FILES}
	@echo PY_RSE_FILES: ${PY_RSE_FILES}
	@echo R_RSE_FILES: ${R_RSE_FILES}
	@echo COMMON_FILES: ${COMMON_FILES}
	@echo ALL_FILES: ${ALL_FILES}
