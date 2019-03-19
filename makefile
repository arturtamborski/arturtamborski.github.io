run:
	bundler exec jekyll serve

debug:
	bundler exec jekyll serve --incremental

build:
	bundler exec jekyll build

install:
	bundler install --path .bundle

clean:
	rm -r _site

.PHONY: run build install clean
