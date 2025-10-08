%{
#include<stdio.h>
#include<ctype.h>    

%}
%%
"void"             {return toupper(yytext);}
"int"               {return toupper(yytext);}
"double"                {return toupper(yytext);}
"bool"                  {return toupper(yytext);}
"string"                    {return toupper(yytext);}
"extends"                   {return toupper(yytext);}
"implements"                    {return toupper(yytext);}
"for"                   {return toupper(yytext);}
"while"                 {return toupper(yytext);}
"ReadInteger"                   {return toupper(yytext);}
"ReadLine"                  {return toupper(yytext);}
"class"                 {return toupper(yytext);}
"interface"                     {return toupper(yytext);}
"if"                    {return toupper(yytext);}
"else"                  {return toupper(yytext);}
"return"                    {return toupper(yytext);}
"null"                  {return toupper(yytext);}
"this"                  {return toupper(yytext);}
"break"                     {return toupper(yytext);}
"New"                   {return toupper(yytext);}
"NewArray"                  {return toupper(yytext);}
"Print"                 {return toupper(yytext);}
"main"                  {return toupper(yytext);}


("true"|"false") {return BOOLEAN;}

[0-9]+|0[xX][a-fA-F0-9]+ {return INTEGER;}
 
[0-9]+\.[0-9]+([Ee][+-]?[0-9]+)? {return DVALUE;} 

\.[0-9]+([Ee][-+]?[0-9]+)? {printf("(%s) is not a valid double as there should be a number before the dot\n", yytext);} 



[a-zA-Z][a-zA-Z0-9_]*      {if(strlen(yytext)<=31) return IDENTIFIER;
    else{
        printf("Too long identifier not permitted more than 31 %s\n",yytext);
    }
    }


[_][a-zA-Z0-9_]* {printf("(%s) this is not a valid identifier \n", yytext);} 

\"[^\n\"]*\" {return STRING;}
"."|"[]"      {return M_A_ACCESS;}
"!"|"unary -"       {return UNARY;}
"*"|"/"|"%"         {return MULTIPLITIVE;}
"+"|"-"             {return ADDITIVE;}
"<="|">="|"<"|">"   {return RELATIONAL;}
"=="|"!="           {return EQUALITY;}
"&&"                {return AND;}
"="                 {return ASSIGNMENT;}
"||"                {return OR;}
";"                  {return SEMICOLON;}
","                    {return COMMA;}
"("             {return ROUNDLBRACKET;}
")"             {return ROUNDRBRACKET;}
"{"             {return CURLYLBRACKET;}
"}"             {return CURLYRBRACKET;}

"//"[^\n]* {printf("Single Line Comments : %s\n",yytext);}

"/*"([^*]|\*+[^*/])*\*+"/"  { printf("Multiline Comment: %s\n", yytext);}

[ \n\t]+               

   
%%


int yywrap(){
    return 1;
}
int main(){
    yylex();
    return 0;
}


//our assignment made by bhomia and ranjan