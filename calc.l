%{
#include "calc.tab.h"
#include <math.h>
#include <stdlib.h>
#include <string.h>
%}

%%
"exit"             { exit(0); }
[0-9]+(\.[0-9]+)?([eE][-+]?[0-9]+)? { yylval.fval = atof(yytext); return NUMBER; }
"ans"              { return ANS; }
"pi"               { yylval.fval = 3.1415926535; return NUMBER; }
"e"                { yylval.fval = 2.7182818284; return NUMBER; }
"g"                { yylval.fval = 9.80665; return NUMBER; }
"sin"              { return SIN; }
"cos"              { return COS; }
"tan"     { return TAN; }
"cot"     { return COT; }
"sec"     { return SEC; }
"cosec"   { return COSEC;}
"asin"    { return ASIN; }
"acos"    { return ACOS; }
"atan"    { return ATAN; }
"acot"    { return ACOT; }
"asec"    { return ASEC; }
"acosec"  { return ACOSEC; }
"log"              { return LOG; }
"ln"     { return LN; }
"sqrt"             { return SQRT; }

"!"                { return FACTORIAL; }
"="                { return ASSIGN; }
"%"                { return MOD; }
"+"                { return ADD; }
"-"                { return SUB; }
"*"                { return MULT; }
"/"                { return DIV; }
"^"                { return POW; }
"("                { return LP; }
")"                { return RP; }
"\n"               { return EDL; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.symbol = strdup(yytext); return IDENTIFIER; }
[ \t]+              {}
.                  { printf(">> ERROR: Unknown character '%s'\n", yytext); return ERROR; }

%%
int yywrap() { return 1; }

