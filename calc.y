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
%token NCR NPR
%token ABS
%token COMMA
%token HELP





%right ASSIGN
%nonassoc ABS
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
		if(!$1){}
		else if ((int)$1 == $1) printf(">> %d\n", (int)$1);
		else printf(">> %.4f\n", $1);
    }
    | IDENTIFIER ASSIGN exp EDL {
        setVar($1, $3);
        if ((int)$3 == $3) printf(">> %s = %d\n", $1, (int)$3);
		else printf(">> %s = %.4f\n", $1, $3);
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
            yyerror("Division by zero"); 
            $$ = false;
        } 
        else $$ = $1 / $3;
      }
    | exp MOD exp {
        $$ = fmod($1, $3);
      }
    | exp POW exp { $$ = pow($1, $3); }
    | SUB exp %prec UMINUS { $$ = -$2; }
    | LP exp RP { $$ = $2; }
    | exp FACTORIAL {
        if ((int)$1 != $1 || $1 < 0) {
            yyerror("Invalid input for factorial"); 
            $$ = false;
        } 
        else $$ = factorial($1);
      }
    | LOG LP exp RP {
        if ($3 <= 0) {
            yyerror("Logarithm domain error"); 
            $$ = false;
        } 
        else $$ = log10($3);
      }
    | LN LP exp RP {
    	if ($3 <= 0) {
        	yyerror("Natural log domain error"); 
        	$$ = false;
    	} 
    	else $$ = log($3);
	  }

    | SQRT LP exp RP {
        if ($3 < 0) {
            yyerror("Square root domain error"); 
            $$ = false;
        } 
        else $$ = sqrt($3);
      }
    | NCR LP exp COMMA exp RP {
    	if ((int)$3 != $3 || (int)$5 != $5 || $3 < 0 || $5 < 0 || $3 < $5) {
        	yyerror("Invalid input for Combination"); 
        		$$ = false;
    	} else {
        $$ = factorial($3) / (factorial($5) * factorial($3 - $5));
    	}
	}
	| NPR LP exp COMMA exp RP {
    	if ((int)$3 != $3 || (int)$5 != $5 || $3 < 0 || $5 < 0 || $3 < $5) {
        	yyerror("Invalid input for Permutation");
        	$$ = false;
    	} else {
        	$$ = factorial($3) / factorial($3 - $5);
    	}
	}
	| ABS exp ABS {
		$$ = fabs($2);
	}

    | SIN LP exp RP { $$ = sin($3 * M_PI / 180); }
    | COS LP exp RP { $$ = cos($3 * M_PI / 180); }
    | TAN LP exp RP {
		float angle = fmod($3, 180.0);
		if (fmod(angle, 180.0) == 90.0) {
		    yyerror("Tangent domain error.");
		    $$ = false;
		} else {
		    $$ = tan($3 * M_PI / 180);
		}
		}
	| COT LP exp RP {
		float angle = fmod($3, 180.0);
		if (fmod(angle, 180.0) == 0.0) {
		    yyerror("Cotangent domain error");
		    $$ = false;
		} else {
		    $$ = 1 / tan($3 * M_PI / 180);
		}
	}
	| SEC LP exp RP {
		float angle = fmod($3, 180.0);
		if (fmod(angle, 180.0) == 90.0) {
		    yyerror("Secant domain error");
		    $$ = false;
		} else {
		    $$ = 1 / cos($3 * M_PI / 180);
		}
	}
	| COSEC LP exp RP {
		float angle = fmod($3, 180.0);
		if (fmod(angle, 180.0) == 0.0) {
		    yyerror("Cosecant domain error");
		    $$ = false;
		} else {
		    $$ = 1 / sin($3 * M_PI / 180);
		}
	}


    | ASIN LP exp RP    {
        if ($3 < -1 || $3 > 1) { 
        	yyerror("Arcsine domain error"); 
        	$$ = false; 
        }
        else $$ = asin($3) * 180 / M_PI;
    }
    | ACOS LP exp RP    {
        if ($3 < -1 || $3 > 1) { 
        	yyerror("Arccosine domain error"); 
        	$$ = false; 
        }
        else $$ = acos($3) * 180 / M_PI;
    }
    | ATAN LP exp RP    { $$ = atan($3) * 180 / M_PI; }
    | ACOT LP exp RP    {
        if ($3 == 0) { 
        	yyerror("Arccotangent domain error"); 
        	$$ = false; 
        }
        else $$ = atan(1 / $3) * 180 / M_PI;
    }
    | ASEC LP exp RP {
        if (fabs($3) < 1) { 
        	yyerror("Arcsecant domain error"); 
        	$$ = false; 
    	}
        else $$ = acos(1 / $3) * 180 / M_PI;
    }
    | ACOSEC LP exp RP  {
        if (fabs($3) < 1) { 
        	yyerror("Arccosecant domain errors"); 
        	$$ = false; 
        }
        else $$ = asin(1 / $3) * 180 / M_PI;
    }
    | HELP EDL {
		printf(">> Available Operations:\n");
		printf("   Basic -> +, -, *, /, ^, %% (mod)\n");
		printf("   Parentheses -> ( ), | | (absolute value)\n");
		printf("   Constants -> pi, e, g, ans (last result)\n");
		printf("   Trig Tuntion (deg) -> sin(x), cos(x), tan(x), cot(x), sec(x), cosec(x)\n");
		printf("   Inverse Trig -> asin(x), acos(x), atan(x), acot(x), asec(x), acosec(x) \n");
		printf("   Logarithm -> log(x) (base 10), ln(x) (base e)\n");
		printf("   Functions -> sqrt(x), ! (factorial), abs(x)\n");
		printf("   Combinatorics -> C(n,r) (Combination), P(n,r) (Permutation)\n");
		printf("   Commands -> exit, help\n");
	}

    ;

%%

int main() {
    printf("===============================================\n");
	printf("         Simple Scientific Calculator\n");
	printf("===============================================\n\n");

	printf("Type 'exit' or press Ctrl+Z (on Windows) / Ctrl+D (on Linux/Mac) to quit.\n");
	printf("Type 'help' to see the list of supported operations.\n");
	printf("-----------------------------------------------\n");
	printf(">> ");

	printf("Enter Expressions:\n");
	printf(">> ");

    yyparse();
    return 0;
}

void yyerror(char *s) {
    printf(">> ERROR: %s\n", s);
}

