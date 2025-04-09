%{
	
%}

%union {
	int num;
	char symbol;
	float fval
}

%token EDL
%token<fval> NUMBER
%type<fval> exp
%token ADD
%token SUB
%token MULT
%token DIV
%token LP
%token RP

%left ADD SUB
%left MULT DIV
%right UMINUS
%%

input: 
|	line input
;
line:
	exp EDL{  if ((int)$1 == $1) printf("%d\n", (int)$1); else printf("%.2f\n", $1) ;}
	|EDL;

exp: 
	NUMBER { $$ = $1; } 
	| exp ADD exp{ $$ = $1 + $3;}
	| exp SUB exp{ $$ = $1 - $3;}
	| exp MULT exp{$$ = $1 * $3;}
	| exp DIV exp{ if($3 == 0) {printf("Error: Can't Divide by Zero\n");} $$ = $1 / $3;}
	| SUB exp %prec UMINUS { $$ = -$2;} 
	| LP exp RP  { $$ = $2; }

%%

int main(){
	printf("Enter an expression:\n");
	return yyparse();

	
}

yyerror(char* s){
	printf("ERROR: %s\n", s);
	return 0;
}
