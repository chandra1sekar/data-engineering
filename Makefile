default: slides

DEPLOY_TARGET = elias:/opt/mirrors/box/talks/2017-02-02-data-engineering/

slides:
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture; \
	done

publish: slides
	rsync -azvP lectures $(DEPLOY_TARGET)

deploy: publish

clean:
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture $@; \
	done

