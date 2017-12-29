default: instructor-notes.pdf

%.pdf: %.md
	@echo "---" $@ "---"
	pandoc --toc $^ -o $@

clean:
	rm -f instructor-notes.pdf

