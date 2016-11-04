#!/bin/bash

# If this script fails you may have carriage returns at the end of each line. Try:
# sed -i -e 's/^M//g' batch.sh
# ... where you can create the ^M character by typing control-v control-m
# Then of course:
# chmod +x batch.sh

# Relies on some pandoc filters:
# https://github.com/tomduck/pandoc-fignos
# https://github.com/jgm/pandoc-citeproc
# You can probably install them with:
# pip install pandoc-fignos
# apt-get install pandoc-citeproc

# Also relies on xelatex which you can probably install with
# apt-get install texlive-xetex

# You may wish to install some nice fonts, see
# https://wiki.debian.org/SubstitutingCalibriAndCambriaFonts
# In summary try this:
# apt-get install fonts-crosextra-carlito

# Rough workflow:
# cd /tmp
# git clone https://github.com/me/my-gitbook.git gitbook
# cp /path/to/render-gitbook.sh /tmp/gitbook
# cd gitbook
# ./render-gitbook.sh

# FIXME Should be stipulated as an argument, not hard-coded
# declare wd="/tmp/gitbook"

# # Download a nice citation style if one doesn't already exist
# if [ ! -f $wd/gitbook_citation_style.csl ]; then
#   wget https://raw.githubusercontent.com/citation-style-language/styles/master/harvard-imperial-college-london.csl -O- > $wd/gitbook_citation_style.csl
# fi

# Edit the citation style if you like.
# For example, look for <citation> and remove brackets in the prefix and suffix.

# FIXME use $wd in redirect
# cat $wd/SUMMARY.md | perl -ne 's/^.+\((.+)\)$/\/tmp\/gitbook\/$1/msg; s/^\#.*$//msg; s/\s+/ /msg; //; print;' > /tmp/gitbook/gitbook_file_list.txt
cat ./SUMMARY.md | perl -ne 's/^.+\((.+)\)$/\/chapters\/\/$1/msg; s/^\#.*$//msg; s/\s+/ /msg; //; print;' > ./gitbook_file_list.txt


declare gitbook_files=`cat ./gitbook_file_list.txt`

# echo Running pandoc PDF...
# eval "pandoc \
#   --latex-engine=xelatex \
#   -H $wd/gitbook_tex_header.tex \
#   --csl $wd/gitbook_citation_style.csl \
#   --filter pandoc-fignos \
#   --filter pandoc-citeproc \
#   --bibliography $wd/references.bib \
#   -s \
#   "$gitbook_files$" \
#   -o gitbook_output.pdf"


# # For consistent output I prefer to generate a Word doc, then use Word to generate a PDF.

# echo Running pandoc docx...
# eval "pandoc \
#   --csl $wd/gitbook_citation_style.csl \
#   --bibliography $wd/references.bib \
#   -s \
#   "$gitbook_files$" \
#   -o gitbook_output.docx"
