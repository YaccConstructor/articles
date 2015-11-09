pdflatex --shell-escape IEEEConference.tex
bibtex IEEEConference.aux
pdflatex --shell-escape IEEEConference.tex
start IEEEConference.pdf