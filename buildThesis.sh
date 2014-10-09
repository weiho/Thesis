rm thesisMain.aux 
rm thesisMain.bbl

latex thesisMain.tex
bibtex thesisMain
latex thesisMain.tex
latex thesisMain.tex
dvipdf thesisMain.dvi
