 /*Noaghea Marian-Florentin 333CC */
%{
    #include<stdio.h>
    #include"Stack.h"
    #include <string.h>

    Stack* stack;
    char yylval[50];
    char lastLabel[50];
    char lastArray[50];

    int numere = 0;
	int siruri = 0;
	int booleeni = 0;
	int liste = 0;
	int obiecte = 0;
	int null = 0;

    int i = 0;

    int firsAcolada = 0;

%}

DIGIT1to9 [1-9]
DIGIT [0-9]
DIGITS {DIGIT}+
INT {DIGIT}|{DIGIT1to9}{DIGITS}|-{DIGIT}|-{DIGIT1to9}{DIGITS}
FRAC [.]{DIGITS}
EXP {E}{DIGITS}
E [eE][+-]?
HEX_DIGIT [0-9a-f]
NUMBER {INT}|{INT}{FRAC}|{INT}{EXP}|{INT}{FRAC}{EXP}
UNESCAPEDCHAR [ -!#-\[\]-~]
ESCAPEDCHAR \\["\\bfnrt/]
UNICODECHAR \\u{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}
CHAR {UNESCAPEDCHAR}|{ESCAPEDCHAR}|{UNICODECHAR}
CHARS {CHAR}+
DBL_QUOTE ["]

%%

{DBL_QUOTE}{DBL_QUOTE} |
{DBL_QUOTE}{CHARS}{DBL_QUOTE} {
    strcpy(yylval, yytext);
    strcpy(lastLabel, yylval);
};

 /* este un sir */
:\ {DBL_QUOTE}{DBL_QUOTE} |
:\ {DBL_QUOTE}{CHARS}{DBL_QUOTE} {
    strcpy(yylval, yytext);
    // updatez varful stivei, acesta contine siruri
    Node nod = top(stack);
    nod.siruri = 1;
    pop(stack);
    push(stack, nod);
};

 /* este o lista*/
\[.\] {
    strcpy(yylval, yytext);
    // updatez varful stivei
    Node nod = top(stack);
    nod.liste = 1;
    pop(stack);
    push(stack, nod);
}

 /* este un incepu de obiect dintr-un array de obiecte */
\[[ \t\n]+\{ {

    strcpy(yylval, yytext);
    strcpy(lastArray, lastLabel);

    // updatez varful stivei
    Node nod = top(stack);
    nod.liste = 1;
    nod.index = 0;
    pop(stack);
    push(stack, nod);

    Node n = createNode();
    i = 0;
    liste = 1;

    Node parent_n = top(stack);

    if (!strcmp(lastLabel, "")) {
        // daca arrayul nu are un label atunci inseamna ca 
        // rooot-ul este un array
        strcpy(n.nume, "root");
        char str[5];
        sprintf(str, "[%d]", i);
        strcat(n.nume, str);
    } else {
        // altfel concatenez la numele nodului din varful stivei
        // numele obiectului curent si indexul acestuia
        strcpy(n.nume, parent_n.nume);
        strcat(n.nume, "->");
        strcat(n.nume, lastLabel);
        char str[5];
        sprintf(str, "[%d]", i);
        strcat(n.nume, str);
    }

    push(stack, n);

};

 /* este un incepu de obiect*/
\{ {
    if (((top(stack).liste == 0))) {
        Node nod = top(stack);
        nod.obiecte = 1;
        pop(stack);
        push(stack, nod);
    }

    strcpy(yylval, yytext);
    obiecte = 1;
    // updatez varful stivei
    Node n = createNode();
    Node parent_n = top(stack);
    
    // la fel ca mai sus vad daca este root sau 
    // concatenez mai departe
    if (!strcmp(lastLabel, "")) {
        strcpy(n.nume, "root");
    } else {
        strcpy(n.nume, parent_n.nume);
        strcat(n.nume, "->");
        strcat(n.nume, lastLabel);
    }

    push(stack, n);
};

 /* este un sfarsit de obiect dintr-un array de obiecte */
\}, {
    char str[5];
    i++;
    // ii concatenez ultimului label indexul urmator
    sprintf(str, "[%d]", i);
    strcpy(lastLabel, lastArray);
    strcat(lastLabel, str);

    // printez ce contine obiectul terminat
    printf("%s contine ", top(stack).nume);
    if (top(stack).numere == 1) printf("NUMERE, ");
    if (top(stack).siruri== 1) printf("SIRURI, ");
    if (top(stack).booleeni== 1) printf("BOOLEENI, ");
    if (top(stack).liste== 1) printf("LISTE, ");
    if (top(stack).obiecte== 1) printf("OBIECTE, ");
    if (top(stack).null== 1) printf("NULL, ");
    printf("\n");
    pop(stack);

    
};

 /* este un sfarsit obiect printez ce contine */
\} { 
    if(!isStackEmpty(stack)) {
    printf("%s contine ", top(stack).nume);
    if (top(stack).numere == 1) printf("NUMERE, ");
    if (top(stack).siruri== 1) printf("SIRURI, ");
    if (top(stack).booleeni== 1) printf("BOOLEENI, ");
    if (top(stack).liste== 1) printf("LISTE, ");
    if (top(stack).obiecte== 1) printf("OBIECTE, ");
    if (top(stack).null== 1) printf("NULL, ");
    printf("\n");
    pop(stack);
    }

};


 /* este un numar, updatez varful stivei */
:\ {NUMBER} {  
    strcpy(yylval, yytext);
    Node nod = top(stack);
    nod.numere = 1;
    pop(stack);
    push(stack, nod);
};

 /* este un null, updatez varful stivei */
:\ null {
   strcpy(yylval, yytext);
    Node nod = top(stack);
    nod.null = 1;
    pop(stack);
    push(stack, nod);
};


 /* este un array, updatez varful stivei */
\[ {
    strcpy(yylval, yytext);
    // updatez varful stivei
    Node nod = top(stack);
    nod.liste = 1;
    pop(stack);
    push(stack, nod);
};

 /* este un bool, updatez varful stivei */
:\ true |
:\ false {
   strcpy(yylval, yytext);
    // updatez varful stivei
    Node nod = top(stack);
    nod.booleeni = 1;
    pop(stack);
    push(stack, nod);
};

 /* sar peste orice null, boolean sau numar dintr-un array*/
null |
true |
false |
{NUMBER} {

};

, {

};

: {

};

 /* ignore whitespace */
[ \t\n]+ 
\] {
    if (strncmp(top(stack).nume, "root", 4)) {
        pop(stack);
    } 
}

%%
int yywrap(){}


int main(int argc, char **argv) {
stack = createStack();
yylex();

return 0;
}