Noaghea Marian-Florentin 333CC

Am inceput tema de la urmatoarea sursa: https://gist.github.com/justjkk/436828/
de unde am luat partea cu definirea {NUMBER}, {CHARS}.
Pe urma m-am gandit ca aceasta parcurgere a jsonului este una de tip DFS, am 
ajuns la conluzia ca trebuie sa folosesc o stiva. Fisierul Stack.h este luat din
laboratoarele de structuri de date.
M-am gandit ca in principiu la intalnirea unui "{" trebuie sa fac un push pe stiva,
iar la intalnirea unui "}" trebuie sa fac un pop. Daca voi fi intr-un array de obiecte
atunci voi concatena indexul la care ma aflu in adancime la numele nodului parintele(varful stivei)
Am avut variante ale codului in care am vrut sa folosesc 2 stive, una pentru nodurile simple 
si alta pentru cand intalneam un vector de obiecte, cea de-a doua stiva era folositoare 
putand parcurge in adancime si stiind la ce index sa ma intorc cand voi face pop, insa am 
intampinat dificultati in implementare.
In cele din urma acest program functioneaza atata vreme cat nu se intalnesc arrayuri
de obiecte in arrayuri de obiecte.

Pentru radacina am ales sa ii pun si un nume "root".
Comentariile din cod exprima intocmai gandirea pe care am descris-o mai sus.
Inputurile de la 1 la 4 sunt din enunt, celelalte inputuri sunt adaugate de mine.