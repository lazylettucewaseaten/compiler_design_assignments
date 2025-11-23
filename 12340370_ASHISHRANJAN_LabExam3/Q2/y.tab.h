/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
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
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT = 258,
    FLOAT = 259,
    SWITCH = 260,
    COLON = 261,
    CASE = 262,
    BOOL = 263,
    STRING = 264,
    VOID = 265,
    ROUNDLBRACKET = 266,
    ROUNDRBRACKET = 267,
    SEMICOLON = 268,
    FOR = 269,
    BOOLEAN = 270,
    MULTIPLITIVE = 271,
    ADDITIVE = 272,
    RELATIONAL = 273,
    EQUALITY = 274,
    AND = 275,
    OR = 276,
    ASSIGNMENT = 277,
    NEW = 278,
    CURLYRBRACKET = 279,
    CURLYLBRACKET = 280,
    CLASS = 281,
    COMMA = 282,
    NEWARRAY = 283,
    UNARY = 284,
    DEFAULT = 285,
    RETURN = 286,
    BREAK = 287,
    IF = 288,
    ELSE = 289,
    DO = 290,
    WHILE = 291,
    SQUARERBRACKET = 292,
    DOT = 293,
    SQUARELBRACKET = 294,
    NOT = 295,
    LT = 296,
    GT = 297,
    LE = 298,
    GE = 299,
    EQ = 300,
    NE = 301,
    MAIN = 302,
    TRUELIT = 303,
    FALSELIT = 304,
    ID = 305,
    NUM = 306,
    FNUM = 307,
    UMINUS = 308,
    UNOT = 309,
    IF_WITHOUT_ELSE = 310
  };
#endif
/* Tokens.  */
#define INT 258
#define FLOAT 259
#define SWITCH 260
#define COLON 261
#define CASE 262
#define BOOL 263
#define STRING 264
#define VOID 265
#define ROUNDLBRACKET 266
#define ROUNDRBRACKET 267
#define SEMICOLON 268
#define FOR 269
#define BOOLEAN 270
#define MULTIPLITIVE 271
#define ADDITIVE 272
#define RELATIONAL 273
#define EQUALITY 274
#define AND 275
#define OR 276
#define ASSIGNMENT 277
#define NEW 278
#define CURLYRBRACKET 279
#define CURLYLBRACKET 280
#define CLASS 281
#define COMMA 282
#define NEWARRAY 283
#define UNARY 284
#define DEFAULT 285
#define RETURN 286
#define BREAK 287
#define IF 288
#define ELSE 289
#define DO 290
#define WHILE 291
#define SQUARERBRACKET 292
#define DOT 293
#define SQUARELBRACKET 294
#define NOT 295
#define LT 296
#define GT 297
#define LE 298
#define GE 299
#define EQ 300
#define NE 301
#define MAIN 302
#define TRUELIT 303
#define FALSELIT 304
#define ID 305
#define NUM 306
#define FNUM 307
#define UMINUS 308
#define UNOT 309
#define IF_WITHOUT_ELSE 310

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 31 "parser.y"

    int num;
    float fnum;
    char *str;
    struct {
        char* place;
        char* code;
    } b;

#line 177 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
