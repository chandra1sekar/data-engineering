
default:
	#pandoc slides.md -o slides.html -s -t revealjs --incremental --section-divs -V theme=svds -V transition=linear
	pandoc slides.md -o slides.html -s -t revealjs --section-divs -V theme=svds -V transition=linear

clean:
	rm -f slides.html

clobber: clean

