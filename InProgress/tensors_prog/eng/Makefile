.PHONY: celan clean all might might-weasel might-passive might-dups

MAIN=main
.PHONY: $(MAIN).pdf clean

all: $(MAIN).pdf

OCANREN_TEX=$(MAIN).tex

COMPILER=pdflatex -interaction=nonstopmode -jobname=$(MAIN)

$(MAIN).pdf: $(OCANREN_TEX)
	$(COMPILER) -shell-escape -ini "&pdflatex" mylatexformat.ltx $<
	$(COMPILER) $<
	$(COMPILER) $<

celan: clean
clean:
	$(RM) -f *.synctex.gz *.bak *.fmt *.out *.aux *.bbl *.blg *.log *.fdb_latexmk *.fls $(MAIN).pdf *~


might: might-weasel might-passive might-dups
might-weasel:	
	echo "weasel words: "
	sh ../bin/weasel *.tex
	echo

might-passive:	
	echo "passive voice: "
	sh ../bin/passive *.tex
	echo

might-dups:	
	echo "duplicates: "
	perl ../bin/dups *.tex
	echo

DEBS += texlive-font-utils
DEBS += texlive-plain-generic 
DEBS += lmodern # nicer fonts
DEBS += texlive-publishers # ACM-Reference-Format.bst

debs:
	sudo apt install -y $(DEBS)

