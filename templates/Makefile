
slides = $(wildcard *-*.md)
default: $(slides:.md=.html)
pdfs: $(slides:.md=.pdf)


%.html : %.md
	@echo "---" $@ "---"
	pandoc $< -o $@ -s -t revealjs --template=../templates/mids-revealjs-template.html --section-divs -V theme=mids -V transition=linear

%-videos.html : %-videos.md
	@echo "---" $@ "(with hosted links)---"
	$(eval hosted_revealjs_url := "http://people.ischool.berkeley.edu/~mark.mims/course-development/2017-mids-w205/templates/reveal.js/")
	pandoc $< -o $@ -s -t revealjs --template=../templates/mids-revealjs-template.html --section-divs -V theme=mids -V transition=linear -V revealjs-url=$(hosted_revealjs_url)

%.svg : %.dot
	@echo "---" $@ "---"
	dot -T svg $< -o $@ 

%.pdf : %.html
	@echo "---" $@ "---"
	phantomjs ~/lib/decktape/decktape.js $< $@

clean:
	rm -f *.html
	rm -f *.pdf

clobber: clean

