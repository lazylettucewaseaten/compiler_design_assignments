%{
#include<stdio.h>
%}


%%
[0][^\n]  {printf("INVALID : %s\n",yytext);}
[1-2][0-9]{2}[0-1][0-9]{3}[0] {printf("PHD_STUDENT : %s\n",yytext);}
[1-2][0-9]{2}[2-3][0-9]{3}[0] {printf("MASTER_STUDENT : %s\n",yytext);}
[1-2][0-9]{2}[4-9][0-9]{3}[0] {printf("UG_STUDENT : %s\n",yytext);}
[3][0-9]{2}[0-9]{4}[0] {printf("EMPL_REG : %s\n",yytext);}
[3][0-9]{2}[0-9]{4}[1-9] {printf("EMPL_REG_DEP : %s\n",yytext);}
[4][0-9]{2}[0-9]{4}[0] {printf("EMPL_CON : %s\n",yytext);}
[4][0-9]{2}[0-9]{4}[1-9] {printf("EMPL_CON_DEP : %s\n",yytext);}

[5-9]{1}[0-9]{2}[0-9]{4}[0-9] {printf("OTHER : %s\n",yytext);}

[a-zA-Z]+[^ \n]* {printf("INVALID : %s\n",yytext);}
[ \t\n] {}
[0-9]{9,} {printf("INVALID : %s\n",yytext);}
[^ \n\t]+ {printf("INVALID : %s\n",yytext);}
%%


int main(int argc,char * argv[]){
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