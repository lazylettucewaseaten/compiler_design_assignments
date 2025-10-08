%{
#include<stdio.h>
#include<stdlib.h>
%}

%token INT DOUBLE BOOL STRING VOID IDENTIFIER MAIN
%start program

%%

program :  declarations ;

declarations : declarations declaration  |FuncMain	;


declaration: VarDecl | FuncDecl | ClassDecl;

FuncMain : VOID MAIN ROUNDLBRACKET ROUNDRBRACKET StmtBlock
	

VarDecl:
       type IDENTIFIER
       |
       IDENTIFIER NEWARRAY ROUNDLBRACKET  INTEGER  COMMA type ROUNDRBRACKET SEMICOLON
       ;
	   //integer hoga ya kya hoga

FuncDecl:
	type IDENTIFIER ROUNDLBRACKET formalParameters ROUNDRBRACKET StmtBlock 
	;
	
ClassDecl:
	CLASS IDENTIFIER CURLYLBRACKET field ASTERIK CURLYRBRACKET
	;
	
field: VarDecl | FuncDecl;
type : INT | DOUBLE | BOOL | STRING | VOID ;
formalParameters: | type IDENTIFIER;


Expression:
	OperatorExp
	|
	AssignExp
	|  
	CallExp
	|
	NewExp
	;
	
NewExp:
      NEW ROUNDLBRACKET IDENTIFIER ROUNDRBRACKET;

AssignExp:
	Lvalue ASSIGNMENT Expression;
	
Lvalue:
      IDENTIFIER
      |
      Expression "." IDENTIFIER
      |
      Expression "[" Expression "]"
      ;
      
CallExp:
	IDENTIFIER ROUNDLBRACKET ActualParameters ROUNDRBRACKET 
	|
	Expression "." IDENTIFIER ROUNDLBRACKET ActualParameters ROUNDRBRACKET 
	;

ActualParameters:
		Expression ActualParameters 
		|
		COMMA ActualParameters 
		|
		;
OperatorExp:
	   Operand
	   |
	   OperatorExp Operators OperatorExp 
	   |
	   ROUNDLBRACKET OperatorExp ROUNDRBRACKET
	   ;
	   
	   
Operators: MULTIPLITIVE | ADDITIVE | RELATIONAL | EQUALITY | AND | OR ;

Operand: 
	UNARY IDENTIFIER |
	UNARY INTEGER|
	IDENTIFER|
	INTEGER
	;
	
//ma access later

%%

//untracket  , formalparamer,stmtblock,

void main(){
	printf("Enter your code\n");
	yyparse();
}


void yyerror(){
	flag=1;
	printf("\nSyntax Error\n");
}
