
slides = $(wildcard *-*.md)
default: $(slides:.md=.html)

%.html : %.md
	@echo "---" $@ "---"
	pandoc $< -o $@ -s -t revealjs --template=../../templates/mids-revealjs-template.html --section-divs -V theme=mids -V transition=linear

%.svg : %.dot
	@echo "---" $@ "---"
	dot -T svg $< -o $@ 

clean:
	rm -f *.html

clobber: clean

