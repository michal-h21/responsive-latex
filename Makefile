pkg_name   = responsive
sty_file   = $(pkg_name).sty
doc_root   = $(pkg_name)-doc
doc_source = $(doc_root).tex
doc_pdf    = $(doc_root).pdf

$(doc_pdf): $(doc_source) $(sty_file)
	lualatex $<
