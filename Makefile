# Noaghea Marian-Floreintin 333CC
build:
	$flex lex.l
	$gcc lex.yy.c

run:
	./a.out < input6.in
clean:
	rm lex.yy.c a.out
