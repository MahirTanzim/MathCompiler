%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include <string.h>
    #include <stdbool.h>

    void yyerror(const char *s);
    int yylex();

    typedef struct {
        char* name;
        float value;
    } Variable;

    #define MAX_VARS 100
    Variable varTable[MAX_VARS];
    int varCount = 0;

    float getVar(char* name) {
        for (int i = 0; i < varCount; ++i) {
            if (strcmp(varTable[i].name, name) == 0)
                return varTable[i].value;
        }
        printf(">> ERROR: Undefined variable '%s'\n", name);
        return false;
    }

    void setVar(char* name, float value) {
        for (int i = 0; i < varCount; ++i) {
            if (strcmp(varTable[i].name, name) == 0) {
                varTable[i].value = value;
                return;
            }
        }
        varTable[varCount].name = strdup(name);
        varTable[varCount].value = value;
        varCount++;
    }
%}

%union {
    float fval;
    char* symbol;
}

%token EDL ERROR
%token<fval> NUMBER
%token<symbol> IDENTIFIER

%token ADD SUB MULT DIV POW ASSIGN
%token LP RP SIN COS LOG SQRT

%type<fval> exp line

%right ASSIGN
%left ADD SUB
%left MULT DIV
%right POW
%right UMINUS

%%

input:
    | input  line
;

line:
    exp EDL    {
		if($1 == false) {}
		      else if ((int)$1 == $1) 
		          printf(">> %d\n", (int)$1); 
		      else 
		          printf(">> %.2f\n", $1); 
    }
    | IDENTIFIER ASSIGN exp EDL {
        setVar($1, $3);
        printf(">> %s = %.2f\n", $1, $3);
    }
    | ERROR EDL { yyerror("Invalid character"); yyerrok; }
    | error EDL { yyerror("Syntax error"); yyerrok; }
    
;

exp:
      NUMBER               { $$ = $1; }
    | IDENTIFIER           { $$ = getVar($1); }
    | exp ADD exp          { $$ = $1 + $3; }
    | exp SUB exp          { $$ = $1 - $3; }
    | exp MULT exp         { $$ = $1 * $3; }
    | exp DIV exp          { 
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = false;
        } else {
            $$ = $1 / $3;
        }
    }
    | exp POW exp          { $$ = pow($1, $3); }
    | SUB exp %prec UMINUS { $$ = -$2; }
    | LP exp RP            { $$ = $2; }
    | SIN LP exp RP        { $$ = sin($3); }
    | COS LP exp RP        { $$ = cos($3); }
    | LOG LP exp RP        {
        if ($3 <= 0) {
            yyerror("Log of non-positive number");
            $$ = false;
        } else $$ = log10($3);
    }
    | SQRT LP exp RP       {
        if ($3 < 0) {
            yyerror("Square root of negative number");
            $$ = false;
        } else $$ = sqrt($3);
    }
;

%%

int main() {
    printf("Welcome to Scientific Calculator!\n");
    printf(">> ");
    yyparse();
    return 0;
}

void yyerror(const char* s) {
    printf(">> ERROR: %s\n", s);
}

