%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<ctype.h> 
    int yylex(void);
    extern FILE * yyin;
    extern FILE * yyout;
    int yywrap();
    int yyerror();
    int state = 1;

%}

%token VOID CHARACTER COUT CIN INT FLOAT CHAR WHILE IF ELSE TRUE FALSE NUMBER FLOAT_NUM ID LE GE EQ NE GT LT STR ADD MULTIPLY DIVIDE SUBTRACT UNARY INCLUDE RETURN
%left '&'
%left '+' '-'
%left '*' '/' '%'
%left UNARY

%%

program: headers main '(' ')' '{' body return '}'
;

headers: headers headers
| INCLUDE
;

main: datatype ID
;

datatype: INT 
| FLOAT 
| CHAR
| VOID
;

body: WHILE '(' condition ')' '{' body '}'
| IF '(' condition ')' '{' body '}' else
| statement ';'                         { }
| body body                             { }
| COUT '<<' STR ';'                     { }
| CIN '>>' ID ';'
;

else: ELSE '{' body '}'
|
;

condition: value relop value 
| TRUE 
| FALSE
;

statement: datatype ' ' ID init
| ID '=' expression 
| ID relop expression
| ID UNARY 
| UNARY ID
;

init: '=' value 
|
;

expression: expression arithmetic expression
| value
| '(' expression ')'
;

arithmetic: ADD 
| SUBTRACT 
| MULTIPLY
| DIVIDE
;

relop: LT
| GT
| LE
| GE
| EQ
| NE
;

value: NUMBER
| FLOAT_NUM
| CHARACTER
| ID
;

return: RETURN value ';' 
|
;

%%

int main(void){
    int temp = 0;
    yyin = fopen("input.c","r");
    yyout = fopen("output.txt","w");
    while(yylex()){
        yyparse();
    }
    printf("Input has been read and Output has been wrote to the file\n");
    if(state)
    { 
        printf("Parsing Successful\n"); 
    }
    else
    {
        printf("Parsing Failed\n"); 
    }
    return 0;
}

int yyerror() {
    
    return 0;
}