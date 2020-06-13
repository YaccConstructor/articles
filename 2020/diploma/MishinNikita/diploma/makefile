MAIN=diploma
SOURCE=$(MAIN).tex

all: clean
	lualatex --shell-escape $(SOURCE)
	bibtex $(MAIN)
	lualatex --shell-escape $(SOURCE)
	lualatex --shell-escape $(SOURCE)

clean:
	rm -rf auto _* *.aux *.log *.nav *.out *.snm *.toc *~ *.blg *.bbl

cleanall: clean
	rm -rf $(MAIN).pdf
