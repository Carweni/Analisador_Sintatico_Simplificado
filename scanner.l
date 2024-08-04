%option noyywrap
%{
#include "y.tab.h"
#include <stdio.h>

int line = 1;
int comment = 0;
%}

LET "let"
IF "if"
THEN "then"
ELSE "else"
GOTO "go to"
OF "of"
READ "read"
PRINT "print"
END "end"
ATRIB ":="
COLON ":"
DOTCOM ";"
VIRG ","
PLUS "+"
MINUS "-"
TIMES "*"
DIV "/"
EQUAL "="
MORE ">"
LESS "<"
LBRAC "{"
RBRAC "}"
LPAR "("
RPAR ")"
NUM [0-9]+
ID [a-zA-Z][a-zA-Z0-9]*

%%
{LET}       { if (!comment) return LET; }
{IF}        { if (!comment) return IF; }
{THEN}      { if (!comment) return THEN; }
{ELSE}      { if (!comment) return ELSE; }
{GOTO}      { if (!comment) return GOTO; }
{OF}        { if (!comment) return OF; }
{READ}      { if (!comment) return READ; }
{PRINT}     { if (!comment) return PRINT; }
{END}       { if (!comment) return END; }
{ATRIB}     { if (!comment) return ATRIB; }
{COLON}     { if (!comment) return COLON; }
{DOTCOM}    { if (!comment) return DOTCOM; }
{VIRG}      { if (!comment) return VIRG; }
{PLUS}      { if (!comment) return PLUS; }
{MINUS}     { if (!comment) return MINUS; }
{TIMES}     { if (!comment) return TIMES; }
{DIV}       { if (!comment) return DIV; }
{EQUAL}     { if (!comment) return EQUAL; }
{MORE}      { if (!comment) return MORE; }
{LESS}      { if (!comment) return LESS; }
{LBRAC}     { comment = 1; }
{RBRAC}     { comment = 0; }
{LPAR}      { if (!comment) return LPAR; }
{RPAR}      { if (!comment) return RPAR; }
{NUM}       { if (!comment) return NUM; }
{ID}        { if (!comment) return ID; }
\n          { if (!comment) line++; }
[ \t]       ;
.           ;

%%
