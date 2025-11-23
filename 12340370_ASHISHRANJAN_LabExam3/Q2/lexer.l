%{
    #include "y.tab.h"
    #include <string.h>
    extern void yyerror(const char *);
%}

%%


"switch"    { return SWITCH; }
"case"      { return CASE; }
"default"   { return DEFAULT; }
"int" {return INT;}
"float" {return FLOAT;}
[a-zA-Z][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }

[0-9]+ { yylval.num = atoi(yytext); return NUM; }
[0-9]+"."[0-9]+ { yylval.fnum = atof(yytext); return FNUM; }


"+" { return '+'; }
"-" { return '-'; }
"*" { return '*'; }
"/" { return '/'; }

"=="                {return EQ;}
"!"                 {return NOT;}
"<"                 {return LT;}
">"                 {return GT;}
">="                {return GE;}
"<="                {return LE;}
"!="                {return NE;}
"&&"                {return AND;}
"="                 {return ASSIGNMENT;}
"||"                {return OR;}
";"                  {return SEMICOLON;}
":"         {return COLON;}
"("             {return ROUNDLBRACKET;}
")"             {return ROUNDRBRACKET;}
"{"             {return CURLYLBRACKET;}
"}"             {return CURLYRBRACKET;}

[ \t\n]     ; //ignoring 
.           { return yytext[0]; }

%%

int yywrap() { return 1; }