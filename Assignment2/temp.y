%{
#include<stdio.h>
#include<stdlib.h>
%}

%token INT DOUBLE BOOL STRING VOID  MAIN ROUNDLBRACKET ROUNDRBRACKET SEMICOLON FOR BOOLEAN
%token IDENTIFIER MULTIPLITIVE ADDITIVE RELATIONAL EQUALITY AND OR ASSIGNMENT NEW CURLYRBRACKET '*' CURLYLBRACKET
%token CLASS INTEGER COMMA NEWARRAY UNARY RETURN BREAK IF ELSE DO WHILE SQUARERBRACKET DOT SQUARELBRACKET
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


%%

program :  declarations FuncMain declarations ;


declarations : declarations finalstmt | finalstmt;

finalstmt: declaration | ;


declaration: VarDecl | FuncDecl | ClassDecl  ;

FuncMain : VOID MAIN ROUNDLBRACKET ROUNDRBRACKET StmtBlock
	

VarDecl:
       type IDENTIFIER SEMICOLON 
       |
       IDENTIFIER NEWARRAY ROUNDLBRACKET  INTEGER  COMMA type ROUNDRBRACKET SEMICOLON
       ;

FuncDecl:
	type IDENTIFIER ROUNDLBRACKET formalParameters ROUNDRBRACKET StmtBlock 
	;
	
ClassDecl:
	CLASS IDENTIFIER CURLYLBRACKET field '*' CURLYRBRACKET
	;
	
field: VarDecl | FuncDecl;
type : INT | DOUBLE | BOOL | STRING | VOID ;

formalParameters: formalParameters list | list;

list :  | type IDENTIFIER ;

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
      Expression DOT IDENTIFIER
      |
      Expression SQUARELBRACKET Expression SQUARERBRACKET
      ;
      
CallExp:
	IDENTIFIER ROUNDLBRACKET ActualParameters ROUNDRBRACKET 
	|
	Expression DOT IDENTIFIER ROUNDLBRACKET ActualParameters ROUNDRBRACKET 
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
	IDENTIFIER|
	INTEGER
	;
	


Statement : Expression |ConditionalStmt | LoopStmt | OtherStmt| StmtBlock;

StmtBlock: CURLYLBRACKET Stmts CURLYRBRACKET;

Stmts :  Stmts Statement | Stmts VarDecl | ;



ConditionalStmt : IfStmt | IfElseStmt;

LoopStmt : WhileStmt | ForStmt | DoWhileStmt;

OtherStmt : ReturnStmt | BreakStmt

WhileStmt: WHILE ROUNDLBRACKET Expression ROUNDRBRACKET Statement ;

DoWhileStmt: DO Statement WHILE ROUNDLBRACKET Expression ROUNDRBRACKET SEMICOLON ;

ForStmt: FOR ROUNDLBRACKET Expression SEMICOLON Expression SEMICOLON Expression SEMICOLON ROUNDRBRACKET Statement ;

BreakStmt:BREAK SEMICOLON ;

ReturnStmt : RETURN Expression SEMICOLON ;

IfStmt: IF ROUNDLBRACKET Expression ROUNDRBRACKET Statement ;
IfElseStmt: IF ROUNDLBRACKET Expression ROUNDRBRACKET ELSE Statement ;
%%


void main(){
	printf("Enter your code\n");
	yyparse();
}


void yyerror(const char *s) {
    printf("Error: %s\n", s);
}
