exercises: e1 e2 e3 e4

e1:
	if [ ! -d out ]; then mkdir out; fi;
	gcc -Wall -fopenmp -o out/encaja-e1 src/encaja-e1.c

e2:
	if [ ! -d out ]; then mkdir out; fi;
	gcc -Wall -fopenmp -o out/encaja-e2-pJ src/encaja-e2-pJ.c
	gcc -Wall -fopenmp -o out/encaja-e2-pX src/encaja-e2-pX.c

e3:
	if [ ! -d out ]; then mkdir out; fi;
	gcc -Wall -fopenmp -o out/encaja-e3 src/encaja-e3.c

e4:
	if [ ! -d out ]; then mkdir out; fi;
	gcc -Wall -fopenmp -o out/encaja-e4-pJ src/encaja-e4-pJ.c
	gcc -Wall -fopenmp -o out/encaja-e4-pX src/encaja-e4-pX.c

tex:
	cd pdf; \
		pdflatex -synctex=1 -interaction=nonstopmode report.tex > /dev/null

texv:
	cd pdf; \
		pdflatex -synctex=1 -interaction=nonstopmode report.tex

clean:
	rm -rf out
	rm -f pdf/report.{aux,log,out,synctex.gz}
