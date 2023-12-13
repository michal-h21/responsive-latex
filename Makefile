.PHONY: build

pkg_name   = responsive
sty_file   = $(pkg_name).sty
doc_root   = $(pkg_name)-doc
doc_source = $(doc_root).tex
doc_pdf    = $(doc_root).pdf
doc_html   = $(doc_root).html
tex4ht_cfg = $(doc_root).cfg
pdf_sources = $(doc_source) $(sty_file)
html_sources = $(pdf_sources) $(tex4ht_cfg)
all_sources = $(html_sources) $(sty_file)
build_dir = build
build_dest = $(build_dir)/$(pkg_name)
build_readme = $(build_dest)/README
readme_ctan = readme-ctan.txt

All: $(doc_pdf) $(doc_html)

ifeq ($(strip $(shell git rev-parse --is-inside-work-tree 2>/dev/null)),true)
	VERSION:= $(shell git --no-pager describe --abbrev=0 --tags --always )
	DATE:= $(firstword $(shell git --no-pager show --date=short --format="%ad" --name-only))
	YEAR:= $(shell date '+%Y')
endif


$(doc_pdf): $(pdf_sources)
	lualatex "\def\version{${VERSION}}\def\gitdate{${DATE}}\input{$<}"
	lualatex "\def\version{${VERSION}}\def\gitdate{${DATE}}\input{$<}"

$(doc_html): $(html_sources)
	make4ht -c $(tex4ht_cfg) -lm draft -a debug -f html5+dvisvgm_hashes $< "svg,fonts"

REPLACE_VERSION = sed -e "s/{{version}}/${VERSION}/" | sed -e "s/{{year}}/${YEAR}/"

build: $(doc_pdf)
	@rm -rf $(build_dir)
	mkdir -p $(build_dest)
	cp $(pdf_sources) $(build_dest)
	cp $(doc_pdf) $(build_dest)
	cat $(readme_ctan) | $(REPLACE_VERSION) > $(build_readme)
	cd $(build_dir) && zip -r $(pkg_name).zip $(pkg_name)
	
	
