
default:
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture $@; \
	done

clean:
	@for lecture in lectures/*; do \
	  $(MAKE) -C $$lecture $@; \
	done

