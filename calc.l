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
[ \t] {}  
.  {return ERROR; }  
%%

yywrap(){

}
