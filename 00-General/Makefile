
#slides = $(wildcard *-*.md)
#default: $(slides:.md=.html)
#pdfs: $(slides:.md=.pdf)
default:

%.html : %.md
	@echo "---" $@ "---"
	pandoc $< -o $@ -s -t revealjs --template=../templates/mids-revealjs-template.html --section-divs -V theme=mids -V transition=linear

%.svg : %.dot
	@echo "---" $@ "---"
	dot -T svg $< -o $@ 

%.pdf : %.html
	@echo "---" $@ "---"
	phantomjs ../lib/decktape/decktape.js $< $@

clean:
	rm -f *.html
	rm -f *.pdf

clobber: clean

