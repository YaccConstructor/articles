.PHONY: 
.SUFFIXES: .fmt .pdf
ENGINE ?= pdflatex
MAIN = mainrus

all: $(MAIN).pdf
clean::
	latexmk -C $(MAIN).pdf -f
$(MAIN).fmt: $(MAIN).tex ../preamble.tex
	$(ENGINE) -synctex=1 -ini -jobname="$(@:.fmt=)" "&$(ENGINE)" mylatexformat.ltx $<
$(MAIN).pdf: $(MAIN).tex  $(MAIN).fmt
	$(ENGINE) -synctex=1 -fmt=$(<:.tex=.fmt) $<
	$(ENGINE) -synctex=1 -fmt=$(<:.tex=.fmt) $<

clean::
	@$(RM) -r _minted*
	@$(RM) *.aux *.bbl *.blg *.brf *.dvi *.log *.nav *.out *.snm *.toc *.vrb *.synctex.gz
	@$(RM) *.pdf *.fmt

DEBS += texlive-font-utils
DEBS += texlive-plain-generic
DEBS += lmodern # nicer fonts
DEBS += fonts-linuxlibertine

debs:
	sudo apt install -y $(DEBS)

