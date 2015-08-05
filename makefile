## source file to be passed in
source = *

## set up names for the output files
sparse = $(patsubst %.Rmd, %Short, $(source))
sparseRmd = $(sparse).Rmd
verbose = $(patsubst %.Rmd, %Long, $(source))
verboseRmd = $(verbose).Rmd

all: verbose_all sparse_all

#### Verbose Content (verbose versions)
verbose_all: verbose_source verbose_knit verbose_doc_html verbose_doc_pdf\
	verbose_slides_pdf verbose_slides_html
verbose_source: $(source)
	gpp -H -D verbose=1 -o $(verboseRmd) $(source)
verbose_knit: verbose_source
	Rscript -e "require(knitr); knit(as.character(quote($(verboseRmd))))"
verbose_doc_html: verbose_source
	echo $(verboseRmd)
	Rscript -e "require(knitr); knit2html(as.character(quote($(verboseRmd))))"
verbose_doc_pdf: verbose_knit
	pandoc -o $(verbose).pdf $(verbose).md
verbose_slides_pdf: verbose_knit
	pandoc -t beamer -o $(verbose)Slides.pdf $(verbose).md
verbose_slides_html: verbose_knit
	pandoc -s -t slidy -o $(verbose)Slides.html $(verbose).md

#### Sparse (sparse)
sparse_all: sparse_source sparse_knit sparse_doc_html sparse_doc_pdf\
	sparse_slides_pdf sparse_slides_html
sparse_source: $(source)
	gpp -H -o $(sparseRmd) $(source)
sparse_knit: sparse_source
	Rscript -e "require(knitr); knit(as.character(quote($(sparseRmd))))"
sparse_doc_html: sparse_source
	echo $(sparseRmd)
	Rscript -e "require(knitr); knit2html(as.character(quote($(sparseRmd))))"
sparse_doc_pdf: sparse_knit
	pandoc -o $(sparse).pdf $(sparse).md
sparse_slides_pdf: sparse_knit
	pandoc -t beamer -o $(sparse)Slides.pdf $(sparse).md
sparse_slides_html: sparse_knit
	pandoc -s -t slidy -o $(sparse)Slides.html $(sparse).md


