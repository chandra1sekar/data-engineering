default: slides syllabus.pdf syllabus.html

weeks = $(wildcard *-*)

README.md: templates/README-template.md templates/README-template-footer.md
	@echo "---" $@ "---"
	cat templates/README-template.md > $@
	echo "# Introduction" >> $@
	echo >> $@
	cat $(wildcard 01-*)/README.md >> $@
	cat $(wildcard 02-*)/README.md >> $@
	cat $(wildcard 03-*)/README.md >> $@
	echo "# The Basics" >> $@
	echo >> $@
	cat $(wildcard 04-*)/README.md >> $@
	cat $(wildcard 05-*)/README.md >> $@
	cat $(wildcard 06-*)/README.md >> $@
	cat $(wildcard 07-*)/README.md >> $@
	cat $(wildcard 08-*)/README.md >> $@
	echo "# Streaming" >> $@
	echo >> $@
	cat $(wildcard 09-*)/README.md >> $@
	cat $(wildcard 10-*)/README.md >> $@
	cat $(wildcard 11-*)/README.md >> $@
	cat $(wildcard 12-*)/README.md >> $@
	echo "# Putting it All Together" >> $@
	echo >> $@
	cat $(wildcard 13-*)/README.md >> $@
	cat $(wildcard 14-*)/README.md >> $@
	cat templates/README-template-footer.md >> $@

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

