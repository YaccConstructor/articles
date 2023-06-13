MAIN=presentation
NAME=$(MAIN)
LATEX=pdflatex
OPTIONS=--shell-escape

.PHONY: $(NAME).pdf clean depext depext-deb

all: $(NAME).pdf

FILES_TEX=$(MAIN).tex

$(NAME).pdf: $(FILES_TEX)
	$(LATEX) $(OPTIONS) $<
	$(LATEX) $(OPTIONS) $<

clean:
	$(RM) *.bak *.out *.toc *.bcf *.bbl *.blg *.aux *.nav *.vrb *.snm *.log $(NAME).run.xml *.synctex.gz

