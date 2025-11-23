%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);
void yyerror(const char *);

%}

%union{
    char * str;
}



%type <str>  expression



%token<str> FNUM NUM ID 


%left '+' '-'


%left '*' '/'





%%
program : Stmts  ;

Stmts: Stmts expression  {printf("\n");}  | expression  {printf("\n");};


expression : 


    expression '+' expression{
        printf("+ ");
    } 


    | expression '-' expression{
        printf("- ");
    }  


    | expression '*' expression{
        printf("* ");
    }  


    | expression '/' expression{
        printf("/ ");
    }  


    | ID {
    printf("%s ",$1);
    }


    | NUM {printf("%s ",$1);}
    
    | FNUM {printf("%s ",$1 );}
    ;

%%



int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror(argv[1]);
            return 1;
        }
        yyin = file;
    }

    if (yyparse() == 0) {
        printf("Parsing Successfull.\n");
    } else {
        printf("Parsing failed.\n");
    }

    return 0;
}

void yyerror(const char *s) {
    printf("Sematics Error: %s\n", s);
    printf("Exiting the analysis \n");
    exit(1);
} 


