DOCUMENTS := exhibit history thesis

all: thesis

${DOCUMENTS}:
	latexmk -pvc -xelatex $@.tex

clean:
	rm -f {,**/}*.aux
	rm -f {,**/}*.bbl
	rm -f {,**/}*.bcf
	rm -f {,**/}*.blg
	rm -f {,**/}*.dbx
	rm -f {,**/}*.fdb_latexmk
	rm -f {,**/}*.fls
	rm -f {,**/}*.loa
	rm -f {,**/}*.lof
	rm -f {,**/}*.log
	rm -f {,**/}*.lot
	rm -f {,**/}*.out
	rm -f {,**/}*.run.xml
	rm -f {,**/}*.toc
	rm -f {,**/}*.xdv

publish:
	for name in ${DOCUMENTS}; do       \
		latexmk -xelatex $${name}.tex; \
		mv $${name}.pdf _$${name}.pdf; \
	done
	git checkout gh-pages
	for name in ${DOCUMENTS}; do       \
		mv _$${name}.pdf $${name}.pdf; \
		git add $${name}.pdf;          \
	done
	git commit --amend --message 'Update the thesis'
	git push --force
	git checkout master

.PHONY: all clean publish ${DOCUMENTS}
