JEKYLL=jekyll
BIBTEX2YAML=bibtex2yaml.rb
BIO_DIR=$(HOME)/projects/bio/cv

.PHONY: build clean serve publications

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
	# remove first line
	# :bibtext_key: .* -> (nothing)
	# :bibtex_type: inproceedings -> :type: conference
	# :organization: -> :conference:
	# :author: -> :authors:
	# :key: -> key:

serve:
	$(JEKYLL) serve

clean:
	rm -rf _site
