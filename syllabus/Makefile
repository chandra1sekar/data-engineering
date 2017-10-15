
default: syllabus.pdf syllabus.html

syllabus.html: syllabus-header.md slides.md syllabus-footer.md
	@echo "---" $@ "---"
	pandoc $^ -o $@ --toc -s --section-divs

syllabus.pdf: syllabus-header.md slides.md syllabus-footer.md
	@echo "---" $@ "---"
	pandoc $^ -o $@ --toc

clean:
	rm -f syllabus.pdf
	rm -f syllabus.html

clobber: clean

