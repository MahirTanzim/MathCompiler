%{
    #include "calc.tab.h"


%}



%%
[0-9]+ {yylval.fval = atof(yytext); return NUMBER;}
[0-9]+"."[0-9]+ { yylval.fval = atof(yytext); return NUMBER; }
"+" {return ADD;}
"-" {return SUB;}
"*" {return MULT;}
"/" { return DIV;}
"^" { return POW;}  
\n  { return EDL;}
"(" { return LP;}
")" {return RP;}
"sin" { return SIN; }
"cos" { return COS; }
"log" { return LOG; }
"sqrt" { return SQRT; }
"pi" { yylval.fval = 3.1415926535; return NUMBER; }
"e"  { yylval.fval = 2.7182818284; return NUMBER; }
[ \t] {}  
.  {return ERROR; }  
"exit" { exit(0); }
%%

int yywrap() {
    return 1;
}

