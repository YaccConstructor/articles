.PHONY: presentation.pdf clean

all: presentation.pdf

MAIN_TEX=presentation.tex

presentation.pdf: $(MAIN_TEX)
	pdflatex $<
	pdflatex $<

clean:
	$(RM) *.bak *.out *.aux *.bbl *.blg *.log *.nav *.snm *.toc presentaion.pdf 

