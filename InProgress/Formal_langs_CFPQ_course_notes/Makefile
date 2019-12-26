LATEX = pdflatex -synctex=1 -interaction=nonstopmode
BIB = bibtex
MAIN = Formal_lang_CFPQ_course_notes
all:
	$(LATEX) $(MAIN).tex
	$(BIB) $(MAIN)
	$(LATEX) $(MAIN).tex
	$(LATEX) $(MAIN).tex

clean:
	$(RM) -rf *.aux *.bbl *.log *.blg* *.out *.toc

