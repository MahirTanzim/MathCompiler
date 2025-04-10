%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>  
    
    void yyerror(char *s);
    extern int yylex();
    
    

%}

%union {
    int num;
    char symbol;

    float fval;
}


/* initializing tokens */
%token EDL ERROR
%token<fval> NUMBER
%type<fval> exp
%token ADD
%token SUB
%token MULT
%token DIV
%token POW  
%token LP
%token RP

/* setting up the lowest to higest precedence */

%left ADD SUB
%left MULT DIV
%right POW  
%right UMINUS

%%


input: 
|   line input
;

line:
    exp EDL { if ((int)$1 == $1) printf("%d\n", (int)$1); else printf("%.2f\n", $1); }
    | ERROR { yyerror("Invalid character"); }
    | EDL;

exp: 
    NUMBER { $$ = $1; } 
    | exp ADD exp { $$ = $1 + $3; }
    | exp SUB exp { $$ = $1 - $3; }
    | exp MULT exp { $$ = $1 * $3; }
    | exp DIV exp { 
        if($3 == 0) {
            yyerror("Division by zero");
            $$ = 0; 
        } else {
            $$ = $1 / $3;
        }
    }
    | exp POW exp { $$ = pow($1, $3); }  
    | SUB exp %prec UMINUS { $$ = -$2; } 
    | LP exp RP { $$ = $2; }


%%



int main(){
    printf("Enter an expression:\n");

    return yyparse();
}

void yyerror(char* s){

    printf("ERROR : %s\n", s);
    return;
}
