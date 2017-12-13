default: slides syllabus.pdf syllabus.html

weeks = $(wildcard *-*)

syllabus.html: README.md
	@echo "---" $@ "---"
	pandoc $^ -o $@ -s --section-divs

syllabus.pdf: README.md
	@echo "---" $@ "---"
	pandoc $^ -o $@

slides:
	@for lecture in $(weeks); do \
	  $(MAKE) -C $$lecture; \
	done

pdfs:
	@for lecture in $(weeks); do \
	  $(MAKE) -C $$lecture $@; \
	done

clean:
	@for lecture in $(weeks); do \
	  $(MAKE) -C $$lecture $@; \
	done
	rm -f syllabus.pdf
	rm -f syllabus.html

