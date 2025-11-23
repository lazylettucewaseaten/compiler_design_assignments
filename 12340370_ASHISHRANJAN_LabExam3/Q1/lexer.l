%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"
%}  

%%
[a-zA-Z]+   		{ yylval.str  = strdup(yytext) ; return ID;}
[0-9]+"."[0-9]+ { yylval.str =strdup(yytext) ;return FNUM;}
[0-9]+         		 { yylval.str =strdup(yytext) ;return NUM;}


[ \t]+          ;   
\n              ;  


.               { return yytext[0]; }
%%



int yywrap(){
    return 1;
}
