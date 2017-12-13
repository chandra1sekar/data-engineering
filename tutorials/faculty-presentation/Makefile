
slides = $(wildcard *-*.md)
default: $(slides:.md=.html)
pdfs: $(slides:.md=.pdf)

%.html : %.md
	@echo "---" $@ "---"
	pandoc $< -o $@ -s -t revealjs --template=../../templates/mids-revealjs-template.html --section-divs -V theme=mids -V transition=linear -V revealjs-url="http://people.ischool.berkeley.edu/~mark.mims/course-development/2017-mids-w205/templates/reveal.js/"
	#pandoc $< -o $@ -s -t revealjs --template=../../templates/mids-revealjs-template.html -V theme=mids -V transition=linear -V revealjs-url="http://people.ischool.berkeley.edu/~mark.mims/course-development/2017-mids-w205/templates/reveal.js/"

%.svg : %.dot
	@echo "---" $@ "---"
	dot -T svg $< -o $@ 

%.pdf : %.html
	@echo "---" $@ "---"
	phantomjs ../../lib/decktape/decktape.js $< $@

clean:
	rm -f *.html
	rm -f *.pdf

clobber: clean

