MAIN=acmart-sigplanproc-template
SOURCE=$(MAIN).tex

all: clean
	pdflatex --shell-escape $(SOURCE)
	bibtex $(MAIN)
	pdflatex --shell-escape $(SOURCE)
	pdflatex --shell-escape $(SOURCE)

clean:
	rm -rf auto _* *.aux *.log *.nav *.out *.snm *.toc *~ *.blg *.bbl *.cut

cleanall: clean
	rm -rf $(MAIN).pdf
