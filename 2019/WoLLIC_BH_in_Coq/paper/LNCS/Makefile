MAKE = make

.PHONY: all clean diff

MAIN = main

ALL = ${MAIN}.pdf

all: ${ALL}


TEX  := $(shell find .    -name '*.tex')
BIB  := $(shell find .    -name '*.bib')

${MAIN}.pdf: ${TEX} ${BIB}
	latexmk -pdf ${MAIN}.tex

EXTS  = *~ *.aux *.backup *.blg *.log *.out *.lof *.loa *.lot *.toc *.bbl *.bak *.texshop *.dvi *.fdb_latexmk
TRASH := $(foreach ext,${EXTS},$(shell find . -name '${ext}'))

clean:
	@echo Cleaning  ${EXTS} ${ALL}...
	@rm -f ${TRASH} ${ALL}


BASE ?= $(shell git rev-parse --short HEAD^)
HEAD ?= $(shell git rev-parse --short HEAD)

diff:
	# --prepare 'sed -ibak -e "/badpattern/d" *.tex'
	git latexdiff --main ${MAIN}.tex --latexmk  ${BASE} ${HEAD} -o diff-${HEAD}-to-${BASE}.pdf --append-textcmd=todo --append-textcmd=change --ignore-latex-errors
