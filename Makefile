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

All: $(doc_pdf) $(doc_html)

$(doc_pdf): $(pdf_sources)
	lualatex $<

$(doc_html): $(html_sources)
	make4ht -c $(tex4ht_cfg) -lm draft -a debug -f html5+dvisvgm_hashes $< "svg"

