%{
#include "calc.tab.h"
#include <math.h>
#include <stdlib.h>
#include <string.h>
%}

%%
"exit"             { exit(0); }
"help"      { return HELP; }
[0-9]+(\.[0-9]+)?([eE][-+]?[0-9]+)? { yylval.fval = atof(yytext); return NUMBER; }
"ans" { return ANS; }
"pi" { yylval.fval = 3.1415926535; return NUMBER; }
"e" { yylval.fval = 2.7182818284; return NUMBER; }
"g" { yylval.fval = 9.80665; return NUMBER; }
"pi"   { yylval.fval = 3.1415926535; return NUMBER; }
"e"    { yylval.fval = 2.7182818284; return NUMBER; }
"g"    { yylval.fval = 9.80665; return NUMBER; }
"c"    { yylval.fval = 299792458; return NUMBER; }
"h"    { yylval.fval = 6.62607015e-34; return NUMBER; }
"G"    { yylval.fval = 6.67430e-11; return NUMBER; }
"Na"   { yylval.fval = 6.02214076e23; return NUMBER; }
"sin" { return SIN; }
"cos" { return COS; }
"tan" { return TAN; }
"cot" { return COT; }
"sec" { return SEC; }
"cosec" { return COSEC;}
"asin" { return ASIN; }
"acos" { return ACOS; }
"atan"  { return ATAN; }
"acot" { return ACOT; }
"asec" { return ASEC; }
"acosec"  { return ACOSEC; }
"log" { return LOG; }
"ln"  { return LN; }
"sqrt" { return SQRT; }
"C" { return NCR; }
"P" { return NPR; }
"|" { return ABS; }
"!" { return FACTORIAL; }
"=" { return ASSIGN; }
"%" { return MOD; }
"+" { return ADD; }
"-" { return SUB; }
"*" { return MULT; }
"/" { return DIV; }
"^" { return POW; }
"(" { return LP; }
")" { return RP; }
"," { return COMMA; }
"\n" { return EDL; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.symbol = strdup(yytext); return IDENTIFIER; }
[ \t]+ {}
. { printfreturn ERROR; }

%%
int yywrap() { return 1; }

