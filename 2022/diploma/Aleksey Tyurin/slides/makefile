MAIN=main
SOURCE=$(MAIN).tex

all: 
	pdflatex --shell-escape $(SOURCE)

clean:
	rm -rf auto _* *.aux *.log *.nav *.out *.snm *.toc *~ *.blg *.bbl *.vrb

cleanall: clean
	rm -rf $(MAIN).pdf
