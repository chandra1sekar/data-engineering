default: slides syllabus.pdf syllabus.html

DEPLOY_TARGET = "mark.mims@ischool.berkeley.edu:~/public_html/course-development/2017-mids-w205/"
MEDIA_TARGET = "elias:/opt/mirrors/box/course-development/2017-mids-w205/raw-media/lectures/"
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
	@for tutorial in tutorials/*; do \
	  $(MAKE) -C $$tutorial; \
	done

pdfs:
	@for lecture in $(weeks); do \
	  $(MAKE) -C $$lecture $@; \
	done
	@for tutorial in tutorials/*; do \
	  $(MAKE) -C $$tutorial $@; \
	done

publish: slides
	rsync -azvP activities $(DEPLOY_TARGET)
	rsync -azvP lectures $(DEPLOY_TARGET)
	rsync -azvP media $(DEPLOY_TARGET)
	rsync -azvP readings $(DEPLOY_TARGET)
	rsync -azvP templates $(DEPLOY_TARGET)
	rsync -azvP tutorials $(DEPLOY_TARGET)
	#rsync -azvP --exclude=tmp captures/ $(MEDIA_TARGET)

deploy: publish

capture:
	bin/start-capture.sh

clean:
	@for lecture in $(weeks); do \
	  $(MAKE) -C $$lecture $@; \
	done
	@for tutorial in tutorials/*; do \
	  $(MAKE) -C $$tutorial $@; \
	done
	rm -f syllabus.pdf
	rm -f syllabus.html

