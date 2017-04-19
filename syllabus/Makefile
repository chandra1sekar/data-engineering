
default: syllabus.pdf

%.html : %.md
	@echo "---" $@ "---"
	pandoc $< -o $@ -s -t revealjs --template=../templates/mids-revealjs-template.html --section-divs -V theme=mids -V transition=linear

syllabus.pdf: syllabus-header.md $(sort $(wildcard ../lectures/**/README.md)) syllabus-footer.md
	@echo "---" $@ "---"
	pandoc $^ -o $@ --toc

clean:
	rm -f syllabus.pdf

clobber: clean

