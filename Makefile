default: slides syllabus.pdf syllabus.html

weeks = $(wildcard *-*)

README.md: templates/README-template.md templates/README-template-footer.md $(wildcard *-*/README.md)
	@echo "---" $@ "---"
	cat templates/README-template.md \
		templates/README-template-section-1.md \
		$(wildcard 01-*)/README.md \
		$(wildcard 02-*)/README.md \
		$(wildcard 03-*)/README.md \
		templates/README-template-section-2.md \
		$(wildcard 04-*)/README.md \
		$(wildcard 05-*)/README.md \
		$(wildcard 06-*)/README.md \
		$(wildcard 07-*)/README.md \
		$(wildcard 08-*)/README.md \
		templates/README-template-section-3.md \
		$(wildcard 09-*)/README.md \
		$(wildcard 10-*)/README.md \
		$(wildcard 11-*)/README.md \
		$(wildcard 12-*)/README.md \
		templates/README-template-section-4.md \
		$(wildcard 13-*)/README.md \
		$(wildcard 14-*)/README.md \
		templates/README-template-footer.md > $@

syllabus.html: README.md
	@echo "---" $@ "---"
	pandoc $^ -o $@ -s --section-divs

syllabus.pdf: README.md
	@echo "---" $@ "---"
	pandoc $^ -o $@

slides:
	@for week in $(weeks); do \
	  $(MAKE) -C $$week; \
	done

pdfs:
	@for week in $(weeks); do \
	  $(MAKE) -C $$week $@; \
	done

clean:
	@for week in $(weeks); do \
	  $(MAKE) -C $$week $@; \
	done
	rm -f syllabus.pdf
	rm -f syllabus.html

