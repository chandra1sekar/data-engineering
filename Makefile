default: slides

DEPLOY_TARGET = "mark.mims@ischool.berkeley.edu:~/public_html/course-development/2017-mids-w205/"
MEDIA_TARGET = "elias:/opt/mirrors/box/course-development/2017-mids-w205/raw-media/lectures/"

slides:
	$(MAKE) -C syllabus;
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture; \
	done
	@for tutorial in tutorials/*; do \
	  $(MAKE) -C $$tutorial; \
	done

pdfs:
	@for lecture in lectures/*; do \
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
	rsync -azvP syllabus $(DEPLOY_TARGET)
	rsync -azvP templates $(DEPLOY_TARGET)
	rsync -azvP tutorials $(DEPLOY_TARGET)
	rsync -azvP --exclude=tmp captures/ $(MEDIA_TARGET)

deploy: publish

capture:
	bin/start-capture.sh

clean:
	$(MAKE) -C syllabus $@;
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture $@; \
	done
	@for tutorial in tutorials/*; do \
	  $(MAKE) -C $$tutorial $@; \
	done

