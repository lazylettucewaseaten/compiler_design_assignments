/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    INT = 258,                     /* INT  */
    DOUBLE = 259,                  /* DOUBLE  */
    BOOL = 260,                    /* BOOL  */
    STRING = 261,                  /* STRING  */
    VOID = 262,                    /* VOID  */
    MAIN = 263,                    /* MAIN  */
    ROUNDLBRACKET = 264,           /* ROUNDLBRACKET  */
    ROUNDRBRACKET = 265,           /* ROUNDRBRACKET  */
    SEMICOLON = 266,               /* SEMICOLON  */
    FOR = 267,                     /* FOR  */
    BOOLEAN = 268,                 /* BOOLEAN  */
    IDENTIFIER = 269,              /* IDENTIFIER  */
    MULTIPLITIVE = 270,            /* MULTIPLITIVE  */
    ADDITIVE = 271,                /* ADDITIVE  */
    RELATIONAL = 272,              /* RELATIONAL  */
    EQUALITY = 273,                /* EQUALITY  */
    AND = 274,                     /* AND  */
    OR = 275,                      /* OR  */
    ASSIGNMENT = 276,              /* ASSIGNMENT  */
    NEW = 277,                     /* NEW  */
    CURLYRBRACKET = 278,           /* CURLYRBRACKET  */
    CURLYLBRACKET = 279,           /* CURLYLBRACKET  */
    CLASS = 280,                   /* CLASS  */
    INTEGER = 281,                 /* INTEGER  */
    COMMA = 282,                   /* COMMA  */
    NEWARRAY = 283,                /* NEWARRAY  */
    UNARY = 284,                   /* UNARY  */
    RETURN = 285,                  /* RETURN  */
    BREAK = 286,                   /* BREAK  */
    IF = 287,                      /* IF  */
    ELSE = 288,                    /* ELSE  */
    DO = 289,                      /* DO  */
    WHILE = 290,                   /* WHILE  */
    SQUARERBRACKET = 291,          /* SQUARERBRACKET  */
    DOT = 292,                     /* DOT  */
    SQUARELBRACKET = 293           /* SQUARELBRACKET  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define INT 258
#define DOUBLE 259
#define BOOL 260
#define STRING 261
#define VOID 262
#define MAIN 263
#define ROUNDLBRACKET 264
#define ROUNDRBRACKET 265
#define SEMICOLON 266
#define FOR 267
#define BOOLEAN 268
#define IDENTIFIER 269
#define MULTIPLITIVE 270
#define ADDITIVE 271
#define RELATIONAL 272
#define EQUALITY 273
#define AND 274
#define OR 275
#define ASSIGNMENT 276
#define NEW 277
#define CURLYRBRACKET 278
#define CURLYLBRACKET 279
#define CLASS 280
#define INTEGER 281
#define COMMA 282
#define NEWARRAY 283
#define UNARY 284
#define RETURN 285
#define BREAK 286
#define IF 287
#define ELSE 288
#define DO 289
#define WHILE 290
#define SQUARERBRACKET 291
#define DOT 292
#define SQUARELBRACKET 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
