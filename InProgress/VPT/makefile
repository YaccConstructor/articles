MAIN=sparseLinearAlgebraDistillation
SOURCE=$(MAIN).tex
CC=pdflatex
FLAGS=--shell-escape

all:
	make compile
	bibtex $(MAIN)
	make compile
	make compile

compile:
	$(CC) $(FLAGS) $(SOURCE)

clean:
	rm -rf *.aux *.log *.out *.blg *.bbl *.pag *~ auto 
