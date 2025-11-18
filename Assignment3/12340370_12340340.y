%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol.h"

extern int yylex();
extern int yyparse();

extern FILE* yyin;
%}

%union {
    int num;
    float fnum;
    char *str;
}

%token INT FLOAT BOOL STRING VOID  ROUNDLBRACKET ROUNDRBRACKET SEMICOLON FOR BOOLEAN 
%token  MULTIPLITIVE ADDITIVE RELATIONAL EQUALITY AND OR ASSIGNMENT NEW CURLYRBRACKET  CURLYLBRACKET
%token CLASS COMMA NEWARRAY UNARY RETURN BREAK IF ELSE DO WHILE SQUARERBRACKET DOT SQUARELBRACKET

%token MAIN
%token<str> IDENTIFIER
%token<num>NUMBER
%token<fnum>FNUMBER
%type <str> type OperatorExp Expression
%type<str> UnaryExp MultiplicativeExp AdditiveExp RelationalExp EqualityExp AndExp OrExp OperatorExp Operand OptionalExp Lvalue
%start program

%left DOT SQUARELBRACKET SQUARERBRACKET

%left UNARY
%left MULTIPLITIVE
%left ADDITIVE
%left RELATIONAL
%left EQUALITY
%left AND
%left OR
%left ASSIGNMENT



%nonassoc IF_WITHOUT_ELSE
%nonassoc ELSE


%%

program : FuncMain ;

FuncMain : VOID MAIN ROUNDLBRACKET ROUNDRBRACKET StmtBlock
	

VarDecl:
       type IDENTIFIER SEMICOLON 
       |
       IDENTIFIER NEWARRAY ROUNDLBRACKET  NUMBER  COMMA type ROUNDRBRACKET SEMICOLON
       ;



	

type : INT | FLOAT ;

Expression:
	OperatorExp
	|
	AssignExp
	;

OptionalExp: 
	Expression
	|
	;

AssignExp:
	Lvalue ASSIGNMENT Expression;
	
Lvalue:
      IDENTIFIER
      |
      Expression DOT IDENTIFIER
      |
      Expression SQUARELBRACKET Expression SQUARERBRACKET
      ;
      



OperatorExp:
    OrExp
    ;

OrExp:
    AndExp
    | OrExp OR AndExp
    ;

AndExp:
    EqualityExp
    | AndExp AND EqualityExp
    ;

EqualityExp:
    RelationalExp
    | EqualityExp EQUALITY RelationalExp
    ;

RelationalExp:
    AdditiveExp
    | RelationalExp RELATIONAL AdditiveExp
    ;

AdditiveExp:
    MultiplicativeExp
    | AdditiveExp ADDITIVE MultiplicativeExp
    ;

MultiplicativeExp:
    UnaryExp
    | MultiplicativeExp MULTIPLITIVE UnaryExp
    ;

UnaryExp:
    Operand
    | UNARY UnaryExp
    ;
       
Operand: 
    IDENTIFIER
    | FLOAT
    | NUMBER
    | ROUNDLBRACKET OperatorExp ROUNDRBRACKET 
    ;



StmtBlock: CURLYLBRACKET Stmts CURLYRBRACKET;

Stmts :   Statement Stmts |  VarDecl Stmts | ;

Statement : OptionalExp SEMICOLON |ConditionalStmt | LoopStmt | StmtBlock;


ConditionalStmt: IF ROUNDLBRACKET OptionalExp ROUNDRBRACKET Statement %prec IF_WITHOUT_ELSE   
               | IF ROUNDLBRACKET OptionalExp ROUNDRBRACKET Statement ELSE Statement
               ;
               
LoopStmt : WhileStmt  ;



WhileStmt: WHILE ROUNDLBRACKET OptionalExp ROUNDRBRACKET Statement ;


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
    printf("Error: %s\n", s);
    printf("Exiting the analysis \n");
    exit(1);
} 







