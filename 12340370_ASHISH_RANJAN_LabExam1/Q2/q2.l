%{
#include<stdio.h>
%}

%%
"MOV" {printf("OPCODE : %s\n",yytext);}
"ADD" {printf("OPCODE : %s\n",yytext);}
"SUB" {printf("OPCODE : %s\n",yytext);}
"MUL" {printf("OPCODE : %s\n",yytext);}
"DIV" {printf("OPCODE : %s\n",yytext);}
"LOAD" {printf("OPCODE : %s\n",yytext);}
"STORE" {printf("OPCODE : %s\n",yytext);}
"JMP" {printf("OPCODE : %s\n",yytext);}
"CMP" {printf("OPCODE : %s\n",yytext);}
"HALT" {printf("OPCODE : %s\n",yytext);}

[A-Z]+ {printf("LABEL : %s\n",yytext);}
R[0-9]{1} {printf("REGISTER : %s\n",yytext);}
#[-]?[0-9]+ {printf("IMMEDIATE : %s\n",yytext);}
,|: {printf("DELIMITER : %s\n",yytext);}
;[^\n]* {printf("DELIMITER : ;\n");}

[ \t\n] {}
[A-Z]*[a-z]+|[0-9]+[^ \n]*|[a-z][^ \n]* {printf("ERRORS : %s\n",yytext);}
. {printf("ERRORS : %s\n",yytext);}

%%

int main(int argc,char *argv[]){
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            printf("Cannot open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }
	yylex();
    if (argc > 1) {
        fclose(yyin);
    }
	return 0;
}

int yywrap(){
	return 1;
}
