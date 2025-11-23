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
char* cur_switch_val; 
char* cur_switch_exit;

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

%token INT FLOAT SWITCH COLON CASE BOOL STRING VOID  ROUNDLBRACKET ROUNDRBRACKET SEMICOLON FOR BOOLEAN 
%token  MULTIPLITIVE ADDITIVE RELATIONAL EQUALITY AND OR ASSIGNMENT NEW CURLYRBRACKET  CURLYLBRACKET
%token CLASS COMMA NEWARRAY UNARY DEFAULT RETURN BREAK IF ELSE DO WHILE SQUARERBRACKET DOT SQUARELBRACKET
%token NOT LT GT LE GE EQ NE
%token MAIN TRUELIT FALSELIT
%token<str> ID
%token<num>NUM
%token<fnum>FNUM
%type<b>booleanExp
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
%type<str>OperatorExp OperatorOperand OperatorTerm   Expression ExpressionMain type AssignExp BooleanExp OptionalExp Statement
%type<str>Lvalue  RelationalExp   case_item  idlist  SwitchStmt   
%nonassoc IF_WITHOUT_ELSE
%nonassoc ELSE


%%

program : FuncMain ;

FuncMain :  Stmts 
	
VarDecl:
       type idlist  SEMICOLON {}
       ;

idlist : idlist COMMA ID {
    Symbol* sym=lookupSymbol($3);
            if(sym!=NULL){
                printf("Error: Variable '%s' is  already declared!\n",$3);
                exit(1);
            }
     insertSymbol($3,$<str>0,0);
        $$=$3;
}
|
ID{
    Symbol* sym=lookupSymbol($1);
            if(sym!=NULL){
                printf("Error: Variable '%s' is  already declared!\n",$1);
                exit(1);
            }
     insertSymbol($1,$<str>0,0);
        $$=$1;
};




type : INT {$$=strdup("int");} | FLOAT {$$=strdup("float");} ;

ExpressionMain:
    Expression{$$=$1;}
    |
    AssignExp{$$=$1;};
Expression:
    OperatorExp{$$=$1;} //shyd ni hoga 
    |
    BooleanExp{$$=$1;};

OptionalExp: 
	ExpressionMain{$$=$1;};

Lvalue:
      ID{
        Symbol* sym=lookupSymbol($1);
        if(sym==NULL){
             printf("Error: Variable '%s' not declared!\n",$1);
            exit(1);
        }
        $$=$1;
      }
      ;
AssignExp:
	Lvalue ASSIGNMENT ExpressionMain{
        printf("%s=%s\n",$1,$3);
    };
     
OperatorExp: 
    OperatorExp '+' OperatorTerm{
        char *temp=new_temp();
        printf("%s=%s+%s\n",temp,$1,$3);
        $$=temp;
    }
    |
    OperatorExp '-' OperatorTerm{
        char *temp=new_temp();
        printf("%s=%s-%s\n",temp,$1,$3);
        $$=temp;
    }
    | OperatorTerm{
        $$=$1;
    }
    ;

OperatorTerm: 
    OperatorTerm '*' OperatorOperand{
        char *temp=new_temp();
        printf("%s=%s*%s\n",temp,$1,$3);
        $$=temp;
    }
    |
    OperatorTerm '/' OperatorOperand{
        char *temp=new_temp();
        printf("%s=%s/%s\n",temp,$1,$3);
        $$=temp;
    }

    |
    OperatorOperand{
        $$=$1;
    }
    ;

OperatorOperand://another input
    ROUNDLBRACKET OperatorExp ROUNDRBRACKET {
        $$=$2;
    }
    |
    '-' OperatorOperand %prec UMINUS{
        char *temp=new_temp();
        printf("%s=-%s\n",temp,$2);
        $$=temp;
    }
    |
    NUM {
        char *temp=(char*)malloc(20);
        sprintf(temp,"%d",$1);
        $$=temp;
    }
    |
    FNUM {
        char *temp=(char*)malloc(20);
        sprintf(temp,"%.2f",$1);
        $$=temp;
    }
    |
    ID{
        Symbol* sym=lookupSymbol($1);
        if(sym==NULL){
             printf("Error: Variable '%s' not declared!\n",$1);
            exit(1);
        }
        $$=$1;
    }
    |
    ID SQUARELBRACKET NUM SQUARERBRACKET {
        Symbol* sym=lookupSymbol($1);
        if(sym==NULL){
             printf("Error: Variable '%s' not declared!\n",$1);
            exit(1);
        }
        $$=$1;
    }
    ;

BooleanExp :
    booleanExp{
        
    }
booleanExp:
    booleanExp OR booleanExp {
        char *temp=new_temp();
        printf("%s=%s||%s\n",temp,$1.place,$3.place);
        $$.place=temp;
        $$.code="";
    }
    |booleanExp AND booleanExp {
        char *temp=new_temp();
        printf("%s=%s&&%s\n",temp,$1.place,$3.place);
        $$.place=temp;
        $$.code="";
    }
    |NOT booleanExp %prec UNOT{
        char *temp=new_temp();
        printf("%s=!%s\n",temp,$2.place);
        $$.place=temp;
        $$.code="";
    }
    |TRUELIT{
        $$.place=strdup("true");
        $$.code="";
    }
    |FALSELIT{
            $$.place=strdup("false");
        $$.code="";
    }
    | ROUNDLBRACKET booleanExp ROUNDRBRACKET { 
        $$=$2;
    }
    | RelationalExp {
        $$.place=$1;
        $$.code="";
    };

RelationalExp:
    OperatorExp LT OperatorExp{
        char *temp=new_temp();
        printf("%s=%s<%s\n",temp,$1,$3);
        $$=temp;
    }   
    |
    OperatorExp GT OperatorExp{
        char *temp=new_temp();
        printf("%s=%s>%s\n",temp,$1,$3);
        $$=temp;
    }
    |
    OperatorExp LE OperatorExp{
        char *temp=new_temp();
        printf("%s=%s<=%s\n",temp,$1,$3);
        $$=temp;
    }
    |
    OperatorExp GE OperatorExp{
        char *temp=new_temp();
        printf("%s=%s>=%s\n",temp,$1,$3);
        $$=temp;
    }
    |
    OperatorExp EQ OperatorExp{
        char *temp=new_temp();
        printf("%s=%s==%s\n",temp,$1,$3);
        $$=temp;
    }

    |
    OperatorExp NE OperatorExp{
        char *temp=new_temp();
        printf("%s=%s!=%s\n",temp,$1,$3);
        $$=temp;
    }  
    ;



Stmts :   Statement Stmts |  VarDecl Stmts | ;

Statement : OptionalExp SEMICOLON   { 
    $$=$1;
} |
SwitchStmt {$$=$1;}


SwitchStmt: SWITCH ROUNDLBRACKET Expression ROUNDRBRACKET {
    cur_switch_val=$3;
    cur_switch_exit=new_label();
}
CURLYLBRACKET case_list CURLYRBRACKET {
    printf("%s : \n",cur_switch_exit);
}
;
case_list : case_list case_item | case_item;
case_item:
CASE NUM COLON {
     char* lnext = new_label();

        printf("if %s != %d goto %s\n", cur_switch_val, $2, lnext);
        $<str>$ = lnext; 
}
ExpressionMain SEMICOLON
{
    printf("goto %s\n", cur_switch_exit);
    printf("%s:\n", $<str>4); // Place the "next" label here
}
| 
DEFAULT COLON {
         char* lnext = new_label();

        printf("default  :  \n");
        $<str>$ = lnext; 
}
ExpressionMain SEMICOLON{

}

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






