%{
    #include "calc.tab.h"
    #include <stdlib.h>
    #include <string.h>
%}

%%

[0-9]+"."[0-9]+       { yylval.fval = atof(yytext); return NUMBER; }
[0-9]+                { yylval.fval = atof(yytext); return NUMBER; }

"+"                   { return ADD; }
"-"                   { return SUB; }
"*"                   { return MULT; }
"/"                   { return DIV; }
"^"                   { return POW; }
"="                   { return ASSIGN; }

"("                   { return LP; }
")"                   { return RP; }

"sin"                 { return SIN; }
"cos"                 { return COS; }
"log"                 { return LOG; }
"sqrt"                { return SQRT; }

"pi"                  { yylval.fval = 3.1415926535; return NUMBER; }
"e"                   { yylval.fval = 2.7182818284; return NUMBER; }

[a-zA-Z_][a-zA-Z0-9_]* { yylval.symbol = strdup(yytext); return IDENTIFIER; }

\n                    { return EDL; }
[ \t]+                

.                     { return ERROR; }
"exit"                { exit(0); }

%%

int yywrap() {
    return 1;
}

