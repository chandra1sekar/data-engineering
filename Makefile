default: slides

DEPLOY_TARGET = "mark.mims@ischool.berkeley.edu:~/public_html/course-development/2017-mids-w205/"
MEDIA_TARGET = "elias:/opt/mirrors/box/course-development/2017-mids-w205/raw-media/lectures/"

slides:
	$(MAKE) -C syllabus;
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture; \
	done

pdfs:
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture $@; \
	done

publish: slides
	rsync -azvP lectures $(DEPLOY_TARGET)
	rsync -azvP media $(DEPLOY_TARGET)
	rsync -azvP syllabus $(DEPLOY_TARGET)
	rsync -azvP --exclude=tmp captures/ $(MEDIA_TARGET)

deploy: publish

capture:
	bin/start-capture.sh

clean:
	$(MAKE) -C syllabus $@;
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture $@; \
	done

