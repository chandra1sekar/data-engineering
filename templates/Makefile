
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

#%.pdf : %.html
#@echo "---" $@ "---"
#bin/phantomjs decktape.js http://people.ischool.berkeley.edu/~mark.mims/course-development/2017-mids-w205/lectures/05-Storing-Data-II/5.1.2-Hadoop.html /tmp/5.1.2-Hadoop-3.pdf
# this works best on osx atm (font probs on ubuntu)
