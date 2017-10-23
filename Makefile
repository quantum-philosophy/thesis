all:
	latexmk -pvc -xelatex thesis.tex

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
	latexmk -xelatex thesis.tex
	mv thesis.pdf thesis.pdf_
	git checkout gh-pages
	mv thesis.pdf_ thesis.pdf
	git add thesis.pdf
	git commit --amend --message 'Update the thesis'
	git push --force
	git checkout master

.PHONY: all clean publish
