%{
%}

%union {
	int num;
	
}

%token EDL
%token<num> NUMBER
%type<num> exp
%token ADD
%token SUB
%token MULT
%token DIV

%left ADD SUB
%left MULT DIV
%%

input: 
|	line input
;
line:
	exp EDL{  printf("%d\n", $1) ;}
	|EDL;

exp: 
	NUMBER { $$ = $1; } 
	| exp ADD exp{ $$ = $1 + $3;}
	| exp SUB exp{ $$ = $1 - $3;}
	| exp MULT exp{ $$ = $1 * $3;}
	| exp DIV exp{ $$ = $1 / $3;};

%%

int main(){

	yyparse();
	
	return 0;
	
}

yyerror(char* s){
	printf("ERROR: %s\n", s);
	return 0;
}
