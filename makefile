# $Id: makefile 37 2020-02-25 09:06:02Z rishi $

file=Thesis

default: all

all: pdf out 
	make pdf
	make biber
	make pdf
	make pdf

out:
	if  [ -f $(file).out ] ; then cp $(file).out tmp.out; fi ;
	sed 's/BOOKMARK/dtxmark/g;' tmp.out > x.out; mv x.out tmp.out ;

pdf:
	xelatex $(file)

biber:
	bibtex $(file)

index:
	makeindex -s gind.ist -o $(file).ind $(file).idx 

changes:
	makeindex -s gglo.ist -o $(file).gls $(file).glo

xview:
	xpdf -z 200 $(file).pdf &>/dev/null

view:
	open -a 'Adobe Reader.app' $(file).pdf

ins:
	latex $(file).ins 

diff:
	diff $(file).sty ../$(file).sty |less

copy:
	cp $(file).sty ../

clean:
	rm *.dvi *.toc *.aux *.log *.out \
    *.bbl *.blg *.brf *.bcf *-blx.bib *.run.xml \
    *.cb *.ind *.idx *.ilg *.inx \
    *.synctex.gz *~ *.fls *.fdb_latexmk .*.lb spellTmp
