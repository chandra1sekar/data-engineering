
slides = $(wildcard *-*.md)
default: $(slides:.md=.html)
pdfs: $(slides:.md=.pdf)


%.html : %.md
	@echo "---" $@ "---"
	docker run --rm -t -v `pwd`:/source -v `python -c 'import os, sys; print os.path.realpath("images")'`:/source/images -v `python -c 'import os, sys; print os.path.realpath("reveal.js")'`:/source/reveal.js midsw205/pandoc:2.0.6 $< -o $@ -s -t revealjs --template=/templates/mids-revealjs-template.html --section-divs -V theme=mids -V transition=linear

%-videos.html : %-videos.md
	@echo "---" $@ "(with hosted links)---"
	$(eval hosted_revealjs_url := "http://people.ischool.berkeley.edu/~mark.mims/course-development/2017-mids-w205/templates/reveal.js/")
	docker run --rm -t -v `pwd`:/source -v `python -c 'import os, sys; print os.path.realpath("images")'`:/source/images -v `python -c 'import os, sys; print os.path.realpath("reveal.js")'`:/source/reveal.js midsw205/pandoc:2.0.6 $< -o $@ -s -t revealjs --template=/templates/mids-revealjs-template.html --section-divs -V theme=mids -V transition=linear -V revealjs-url=$(hosted_revealjs_url)

%.svg : %.dot
	@echo "---" $@ "---"
	dot -T svg $< -o $@ 

%.pdf : %.html
	@echo "---" $@ "---"
	docker run --rm -t -v `pwd`:/slides -v `python -c 'import os, sys; print os.path.realpath("images")'`:/slides/images -v `python -c 'import os, sys; print os.path.realpath("reveal.js")'`:/slides/reveal.js astefanutti/decktape:2.8.3 -s '1920x1080' $< $@

clean:
	rm -f *.html
	rm -f *.pdf

clobber: clean

