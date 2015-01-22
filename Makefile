JEKYLL=jekyll
BIBTEX2YAML=bibtex2yaml.rb
BIO_DIR=$(HOME)/projects/bio/cv

.PHONY: all build clean serve open publications

all: publications

build:
	$(JEKYLL) build

publications:
	$(BIBTEX2YAML) $(BIO_DIR)/mgalloy-citations.bib \
	  | sed -e '/^--/d' \
	  | sed -e 's/ :bibtex_key: .*//g' \
	  | sed -e 's/:bibtex_type: :/:type: /g' \
	  | sed -e 's/:type: inproceedings/:type: conference/g' \
	  | sed -e 's/:organization:/:conference:/g' \
	  | sed -e 's/:author:/:authors:/g' \
	  | sed -e 's/:\(.*\):/\1:/g' \
	  | sed -e 's/{//g' \
	  | sed -e 's/}//g' \
	  > _data/publications.yml

serve:
	$(JEKYLL) serve --baseurl ''

open:
	open http://localhost:4000

clean:
	rm -rf _site
