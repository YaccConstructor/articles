# bibtex main
# pdflatex main.tex 
# evince main.pdf & 

pdflatex --shell-escape main.tex
bibtex main
pdflatex --shell-escape main.tex
pdflatex --shell-escape main.tex