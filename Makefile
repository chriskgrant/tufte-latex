LMKFLAGS = -outdir=samples -bibtex
CLASSDIR =  $$(kpsewhich -var-value TEXMFHOME)/tex/latex/tufte-latex
DOCDIR =  $$(kpsewhich -var-value TEXMFHOME)/doc/latex/tufte-latex

# The [^tufte-*-local]*.tex pattern is used to exclude tufte local tex files
test-lua:
	latexmk $(LMKFLAGS) -lualatex -jobname=%A-lualatex [^tufte-*-local]*.tex

test-xe:
	latexmk $(LMKFLAGS) -xelatex -jobname=%A-xelatex [^tufte-*-local]*.tex

test-pdf:
	latexmk $(LMKFLAGS) -pdflatex -jobname=%A-pdflatex [^tufte-*-local]*.tex

test: test-lua test-xe test-pdf

install: test
	mkdir -p $(CLASSDIR)
	cp tufte-book.cls tufte-common.def tufte-handout.cls $(CLASSDIR)
	mkdir -p $(DOCDIR)
	cp History.txt \
		README.md \
		sample-*.tex \
		sample-*.bib \
		$(DOCDIR)
	cp samples/sample-handout-lualatex.pdf $(DOCDIR)/sample-handout.pdf
	cp samples/sample-book-lualatex.pdf $(DOCDIR)/sample-book.pdf
	texhash
