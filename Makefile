all:
	latexmk -pvc -xelatex thesis.tex

clean:
	rm -f {,**/}*.aux
	rm -f {,**/}*.bbl
	rm -f {,**/}*.bcf
	rm -f {,**/}*.blg
	rm -f {,**/}*.fdb_latexmk
	rm -f {,**/}*.fls
	rm -f {,**/}*.lof
	rm -f {,**/}*.log
	rm -f {,**/}*.lot
	rm -f {,**/}*.out
	rm -f {,**/}*.run.xml
	rm -f {,**/}*.toc

.PHONY: all clean
