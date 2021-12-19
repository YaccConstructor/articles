
MAIN=main
SOURCE=$(MAIN).tex

all: clean
	pdflatex -interaction=nonstopmode --shell-escape $(SOURCE)
	bibtex $(MAIN)
	pdflatex -interaction=nonstopmode --shell-escape $(SOURCE)
	pdflatex -interaction=nonstopmode --shell-escape $(SOURCE)

clean:
	rm -rf auto _* *.aux *.log *.nav *.out *.snm *.toc *~ *.blg *.bbl *.cut *.dvi *.xcp *.fdb_latexmk *.fls *.vrb

cleanall: clean
	rm -rf $(MAIN).pdf

latex: clean
	latex --shell-escape $(SOURCE)
	bibtex $(MAIN)
	latex --shell-escape $(SOURCE)
	latex --shell-escape $(SOURCE)
