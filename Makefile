default: build

DEPLOY_TARGET = elias:/opt/mirrors/box/talks/2017-02-02-data-engineering/

build:
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture; \
	done

publish: build
	rsync -azvP lectures $(DEPLOY_TARGET)

deploy: publish

clean:
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture $@; \
	done

