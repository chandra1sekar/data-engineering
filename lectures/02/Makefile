
default: slides.html

%.html : %.md
	@echo "---" $@ "---"
	pandoc $< -o $@ -s -t revealjs --section-divs -V theme=black -V transition=linear

clean:
	rm -f slides.html

clobber: clean

