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

clean-deps:
	rm -r .bundle

.PHONY: run debug build install clean clean-deps
