MAIN=presentation
SOURCE=$(MAIN).tex

.PHONY: clean all
all: clean
	pdflatex -interaction=nonstopmode --shell-escape $(SOURCE)
	pdflatex -interaction=nonstopmode --shell-escape $(SOURCE)

clean:
	$(RM) auto _* *.aux *.log *.nav *.out *.snm *.toc *~ *.blg *.bbl *.cut *.dvi *.xcp *.fdb_latexmk *.fls *.vrb

cleanall: clean
	$(RM) $(MAIN).pdf
