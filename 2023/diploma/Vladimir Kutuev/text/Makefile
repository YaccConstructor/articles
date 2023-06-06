MAIN=report
NAME=$(MAIN)
LATEX=xelatex

.PHONY: $(NAME).pdf clean depext depext-deb

all: $(NAME).pdf

FILES_TEX=$(MAIN).tex 

$(NAME).pdf: $(FILES_TEX)
	$(LATEX) $<
	bibtex $(MAIN).aux
	$(LATEX) $<
	$(LATEX) $<

clean:
	$(RM) *.bak *.out *.toc *.bcf *.bbl *.blg *.aux *.nav *.vrb *.snm *.log $(NAME).run.xml *.synctex.gz

