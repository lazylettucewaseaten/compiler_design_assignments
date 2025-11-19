%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol.h"

extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);

int temp_count=0;
int label_count=0;

char* new_temp(){
    char *temp=(char*)malloc(10);
    sprintf(temp,"t%d",temp_count++);
    return temp;
}

char* new_label(){
    char *label=(char*)malloc(10);
    sprintf(label,"L%d",label_count++);
    return label;
}

%}

%union {
    int num;
    float fnum;
    char *str;
    struct {
        char* place;
        char* code;
    } b;
}

%token INT FLOAT BOOL STRING VOID  ROUNDLBRACKET ROUNDRBRACKET SEMICOLON FOR BOOLEAN 
%token  MULTIPLITIVE ADDITIVE RELATIONAL EQUALITY AND OR ASSIGNMENT NEW CURLYRBRACKET  CURLYLBRACKET
%token CLASS COMMA NEWARRAY UNARY RETURN BREAK IF ELSE DO WHILE SQUARERBRACKET DOT SQUARELBRACKET
%token NOT LT GT LE GE EQ NE
%token MAIN TRUELIT FALSELIT
%token<str> IDENTIFIER
%token<num>NUMBER
%token<fnum>FNUMBER

%token '+' '-' '*' '/'

%start program


%left DOT SQUARELBRACKET SQUARERBRACKET

%left UNARY
%left MULTIPLITIVE
%left ADDITIVE
%left RELATIONAL
%left EQUALITY
%left OR
%left AND
%left ASSIGNMENT

%right UMINUS
%right UNOT
%type<b> booleanExp
%type<b> OperatorExp OperatorOperand OperatorTerm Expression ExpressionMain AssignExp BooleanExp OptionalExp Statement
%type<b> Lvalue RelationalExp ConditionalStmt LoopStmt StmtBlock WhileStmt
%type<str> type
%nonassoc IF_WITHOUT_ELSE
%nonassoc ELSE


%%

program : FuncMain ;

FuncMain : VOID MAIN ROUNDLBRACKET ROUNDRBRACKET StmtBlock
	

VarDecl:
       type IDENTIFIER SEMICOLON {
            Symbol* sym=lookupSymbol($2);
            if(sym!=NULL){
                printf("Error: Variable '%s' is  already declared!\n",$2);
                exit(1);
            }
            insertSymbol($2,$1,0);
       }
       |
       IDENTIFIER NEWARRAY ROUNDLBRACKET  NUMBER  COMMA type ROUNDRBRACKET SEMICOLON{
        Symbol* sym=lookupSymbol($1);
        if(sym!=NULL){
            printf("Error: Variable '%s' is  already declared!\n",$1);
            exit(1);
        }
       	insertSymbol($1,$<str>0,0);	
       }
       ;



type : INT {$$=strdup("int");} | FLOAT {$$=strdup("float");} ;

ExpressionMain:
    Expression{$$=$1;}
    |
    AssignExp{$$=$1;};
Expression:
    OperatorExp{$$=$1;}
    |
    BooleanExp{$$=$1;};

OptionalExp: 
	ExpressionMain{$$=$1;}
	
	;
//last me karunga
	
Lvalue:
      IDENTIFIER{
        Symbol* sym=lookupSymbol($1);
        if(sym==NULL){
             printf("Error: Variable '%s' not declared!\n",$1);
            exit(1);
        }
        $$.place = $1;
        $$.code = strdup("");
      }
    //   |
    //   Expression DOT IDENTIFIER{

    //   }
    //   |
    //   Expression SQUARELBRACKET Expression SQUARERBRACKET{


    //   } removed for now 
      ;
AssignExp:
	Lvalue ASSIGNMENT ExpressionMain{
        char line[100];
        sprintf(line, "%s = %s\n", $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($3.code) + 100);
        strcpy(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
        $$.place = $1.place;
    };
      
OperatorExp:
    OperatorExp '+' OperatorTerm{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s + %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    |
    OperatorExp '-' OperatorTerm{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s - %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    | OperatorTerm{
        $$ = $1;
    }
    ;

OperatorTerm: 
    OperatorTerm '*' OperatorOperand{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s * %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    |
    OperatorTerm '/' OperatorOperand{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s / %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }

    |
    OperatorOperand{
        $$ = $1;
    }
    ;

OperatorOperand:
    ROUNDLBRACKET OperatorExp ROUNDRBRACKET {
        $$ = $2;
    }
    |
    '-' OperatorOperand %prec UMINUS{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = -%s\n", $$.place, $2.place);
        char* code_buffer = (char*)malloc(strlen($2.code) + 100);
        strcpy(code_buffer, $2.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    |
    NUMBER {
        char* num_str = (char*)malloc(20);
        sprintf(num_str, "%d", $1);
        $$.place = num_str;
        $$.code = strdup("");
    }
    |
    FNUMBER {
        char* fnum_str = (char*)malloc(20);
        sprintf(fnum_str, "%.2f", $1);
        $$.place = fnum_str;
        $$.code = strdup("");
    }
    |
    IDENTIFIER{
        Symbol* sym=lookupSymbol($1);
        if(sym==NULL){
             printf("Error: Variable '%s' not declared!\n",$1);
            exit(1);
        }
        $$.place = $1;
        $$.code = strdup("");
    }
    ;

BooleanExp :
    booleanExp{
        $$ = $1;
    };
booleanExp:
    booleanExp OR booleanExp {
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s || %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    |booleanExp AND booleanExp {
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s && %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    |NOT booleanExp %prec UNOT{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = !%s\n", $$.place, $2.place);
        char* code_buffer = (char*)malloc(strlen($2.code) + 100);
        strcpy(code_buffer, $2.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    |TRUELIT{
        $$.place = strdup("1");
        $$.code = strdup("");
    }
    |FALSELIT{
        $$.place = strdup("0");
        $$.code = strdup("");
    }
    | ROUNDLBRACKET booleanExp ROUNDRBRACKET { 
        $$ = $2;
    }
    | RelationalExp {
        $$ = $1;
    };

RelationalExp:
    OperatorExp LT OperatorExp{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s < %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }   
    |
    OperatorExp GT OperatorExp{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s > %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    |
    OperatorExp LE OperatorExp{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s <= %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    |
    OperatorExp GE OperatorExp{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s >= %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    |
    OperatorExp EQ OperatorExp{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s == %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }
    |
    OperatorExp NE OperatorExp{
        $$.place = new_temp();
        char line[100];
        sprintf(line, "%s = %s != %s\n", $$.place, $1.place, $3.place);
        char* code_buffer = (char*)malloc(strlen($1.code) + strlen($3.code) + 100);
        strcpy(code_buffer, $1.code);
        strcat(code_buffer, $3.code);
        strcat(code_buffer, line);
        $$.code = code_buffer;
    }  
    ;


StmtBlock: CURLYLBRACKET Stmts CURLYRBRACKET {};

Stmts :   Statement Stmts |  VarDecl Stmts | ;

Statement : OptionalExp SEMICOLON   { 
    if ($1.code) printf("%s", $1.code);
    $$ = $1;
} 
|
ConditionalStmt {
    if ($1.code) printf("%s", $1.code);
    $$ = $1;
}
| LoopStmt  {$$=$1;}
| StmtBlock {$$=$1;}
;


ConditionalStmt: IF ROUNDLBRACKET booleanExp ROUNDRBRACKET Statement %prec IF_WITHOUT_ELSE   {
    char* l1 = new_label();
    char* l2 = new_label();
    char* final_code = (char*)malloc(strlen($3.code) + strlen($5.code) + 200);
    sprintf(final_code,
        "%s"          
        "if_false %s goto %s\n"
        "%s"          
        "goto %s\n"
        "%s:\n"
        "%s:\n",
        $3.code, $3.place, l1, $5.code, l2, l1, l2
    );
    $$.code = final_code;
    $$.place = NULL;
}
| IF ROUNDLBRACKET booleanExp ROUNDRBRACKET Statement ELSE Statement    {
    char* l1 = new_label();
    char* l2 = new_label();
    char* l3 = new_label();
    char* final_code = (char*)malloc(strlen($3.code) + strlen($5.code) + strlen($7.code) + 200);
    sprintf(final_code,
        "%s"
        "if_false %s goto %s\n"
        "%s"
        "goto %s\n"
        "%s:\n"
        "%s"
        "%s:\n",
        $3.code, $3.place, l1, $5.code, l2, l1, $7.code, l2
    );
    $$.code = final_code;
    $$.place = NULL;
}
;
               
LoopStmt : WhileStmt  {
    $$=$1;
};


WhileStmt: WHILE ROUNDLBRACKET OptionalExp ROUNDRBRACKET Statement {

};

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







