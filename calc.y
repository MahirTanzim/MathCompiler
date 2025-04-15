%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include <string.h>
    #include <stdbool.h>
    
	void yyerror(char *s);
	extern int yylex();
	float last_result = 0;

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
        return 0;
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
    
	float factorial(float n) {
		if (n < 0) return -1;
		if (n == 0 || n == 1) return 1;
		float result = 1;
		for (int i = 2; i <= (int)n; i++) result *= i;
		return result;
	}
%}

%union {
    float fval;
    char* symbol;
}

%token EDL ERROR
%token<fval> NUMBER
%token<fval> ANS
%type<fval> exp line
%token ASSIGN
%token<symbol> IDENTIFIER
%token ADD SUB MULT DIV POW MOD FACTORIAL
%token SIN COS  TAN COT SEC COSEC
%token ASIN ACOS ATAN ACOT ASEC ACOSEC
%token LOG LN SQRT
%token LP RP

%right ASSIGN
%left ADD SUB
%left MULT DIV MOD
%right POW
%right UMINUS
%right FACTORIAL

%%

input:
    | line { printf(">> "); } input
    ;

line:
    exp EDL {
		last_result = $1;
		if ((int)$1 == $1) printf(">> %d\n", (int)$1);
		else printf(">> %.4f\n", $1);
    }
    | IDENTIFIER ASSIGN exp EDL {
        setVar($1, $3);
        printf(">> %s = %.2f\n", $1, $3);
    }
    | ERROR EDL { yyerror("Invalid character"); }
    | error EDL { yyerror("Syntax error"); }
    ;

exp:
      NUMBER { $$ = $1; }
    | ANS    { $$ = last_result; }
    | IDENTIFIER  { $$ = getVar($1); }
    | exp ADD exp { $$ = $1 + $3; }
    | exp SUB exp { $$ = $1 - $3; }
    | exp MULT exp { $$ = $1 * $3; }
    | exp DIV exp {
        if ($3 == 0) {
            yyerror("Division by zero"); $$ = 0;
        } else $$ = $1 / $3;
      }
    | exp MOD exp {
        $$ = fmod($1, $3);
      }
    | exp POW exp { $$ = pow($1, $3); }
    | SUB exp %prec UMINUS { $$ = -$2; }
    | LP exp RP { $$ = $2; }
    | exp FACTORIAL {
        if ((int)$1 != $1 || $1 < 0) {
            yyerror("Invalid input for factorial"); $$ = 0;
        } else $$ = factorial($1);
      }
    | LOG LP exp RP {
        if ($3 <= 0) {
            yyerror("Logarithm domain error"); $$ = 0;
        } else $$ = log10($3);
      }
    | LN LP exp RP {
    	if ($3 <= 0) {
        	yyerror("Natural log domain error"); $$ = 0;
    	} else $$ = log($3);
	  }

    | SQRT LP exp RP {
        if ($3 < 0) {
            yyerror("Square root domain error"); $$ = 0;
        } else $$ = sqrt($3);
      }
    | SIN LP exp RP { $$ = sin($3 * M_PI / 180); }
    | COS LP exp RP { $$ = cos($3 * M_PI / 180); }
    | TAN LP exp RP {
    float angle = fmod($3, 180.0);
    if (fmod(angle, 180.0) == 90.0) {
        yyerror("Tangent domain error.");
        $$ = 0;
    } else {
        $$ = tan($3 * M_PI / 180);
    }
}
| COT LP exp RP {
    float angle = fmod($3, 180.0);
    if (fmod(angle, 180.0) == 0.0) {
        yyerror("Cotangent domain error");
        $$ = 0;
    } else {
        $$ = 1 / tan($3 * M_PI / 180);
    }
}
| SEC LP exp RP {
    float angle = fmod($3, 180.0);
    if (fmod(angle, 180.0) == 90.0) {
        yyerror("Secant domain error");
        $$ = 0;
    } else {
        $$ = 1 / cos($3 * M_PI / 180);
    }
}
| COSEC LP exp RP {
    float angle = fmod($3, 180.0);
    if (fmod(angle, 180.0) == 0.0) {
        yyerror("Cosecant domain error");
        $$ = 0;
    } else {
        $$ = 1 / sin($3 * M_PI / 180);
    }
}


    | ASIN LP exp RP    {
        if ($3 < -1 || $3 > 1) { yyerror("Arcsine domain error"); $$ = 0; }
        else $$ = asin($3) * 180 / M_PI;
    }
    | ACOS LP exp RP    {
        if ($3 < -1 || $3 > 1) { yyerror("Arccosine domain error"); $$ = 0; }
        else $$ = acos($3) * 180 / M_PI;
    }
    | ATAN LP exp RP    { $$ = atan($3) * 180 / M_PI; }
    | ACOT LP exp RP    {
        if ($3 == 0) { yyerror("Arccotangent domain error"); $$ = 0; }
        else $$ = atan(1 / $3) * 180 / M_PI;
    }
    | ASEC LP exp RP    {
        if (fabs($3) < 1) { yyerror("Arcsecant domain error"); $$ = 0; }
        else $$ = acos(1 / $3) * 180 / M_PI;
    }
    | ACOSEC LP exp RP  {
        if (fabs($3) < 1) { yyerror("Arccosecant domain errors"); $$ = 0; }
        else $$ = asin(1 / $3) * 180 / M_PI;
    }
    ;

%%

int main() {
    printf("Welcome to Enhanced Scientific Calculator!\n>> ");
    yyparse();
    return 0;
}

void yyerror(char *s) {
    printf(">> ERROR: %s\n", s);
}

