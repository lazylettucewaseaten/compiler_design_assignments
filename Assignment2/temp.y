%{
#include<stdio.h>
#include<stdlib.h>
%}

%token INT DOUBLE BOOL STRING VOID IDENTIFIER 

%%
declaration: VarDecl | FuncDecl | ClassDecl;

VarDecl:
       type IDENTIFIER
       {
       printf("valid variable declaration\n");
       }
       |
       IDENTIFIER NEWARRAY ROUNDLBRACKET  INTEGER  COMMA type ROUNDRBRACKET SEMICOLON
       {
       printf("valid new array declaration\n");
       }
       
       ;
	   //integer hoga ya kya hoga

FuncDecl:
	type IDENTIFIER ROUNDLBRACKET formalParameters ROUNDRBRACKET StmtBlock 
	{
	printf("valid function declaration\n");
	}
	;
	
ClassDecl:
	CLASS IDENTIFIER CURLYLBRACKET field ASTERIK CURLYRBRACKET
	{
	printf("valid class declration\n");
	}
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


Statement : Expression | IfStmt | WhileStmt | ForStmt | BreakStmt | ReturnStmt | StmtBlock;

StmtBlock:

WhileStmt:

ForStmt:

ReturnStmt:

BreakStmt:

%%

//untracket  ,stmtblock,

void main(){
	printf("Enter your code\n");
	yyparse();
}


void yyerror(){
	flag=1;
	printf("\nSyntax Error\n");
}
