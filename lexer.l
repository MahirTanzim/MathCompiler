%{
	#include "parser.tab.h"
%}


%%
[0-9]+ { yylval.num = atoi(yytext); return NUMBER; }
"+" {return ADD;}
"-" {return SUB;}
"*" {return MULT;}
"/" {return DIV;}
\n {return EDL;}
.  {}
%%



yywrap(){}

