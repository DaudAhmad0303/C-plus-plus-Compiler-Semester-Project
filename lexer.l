%{
    #include "y.tab.h"
    #include<stdio.h>
    #include<stdlib.h> 
    #include<string.h>
    #define BUFFER_SIZE 1000
    FILE *var;
    int num_line = 1;
%}


alpha [a-zA-Z]
digit [0-9]
unary "++"|"--"

%%

^"#include"[ ]*<.+\.h>      { 
                                var = fopen("symbol table.txt","wb");
                                fprintf(var, " ");
                                fprintf(yyout,"< DIRECTIVE, %s >\n", yytext); 
                                return INCLUDE; 
                            }
"cout"                      { fprintf(yyout,"< KW, %s >\n", yytext); return COUT; }
"cin"                       { fprintf(yyout,"< KW, %s >\n", yytext); return CIN; }
"int"                       { 
                                fprintf(yyout,"< DATATYPE, %s >\n", yytext);
                                var =  fopen("symbol table.txt","a");
                                fprintf(var, "\n(%s", yytext); 
                                return INT; 
                            }
"float"                     { 
                                fprintf(yyout,"< DATATYPE, %s >\n", yytext); 
                                var =  fopen("symbol table.txt","a");
                                fprintf(var, "\n(%s", yytext); 
                                return FLOAT;
                            }
"char"                      { 
                                fprintf(yyout,"< DATATYPE, %s >\n", yytext);
                                var =  fopen("symbol table.txt","a");
                                fprintf(var, "\n(%s", yytext);  
                                return CHAR; 
                            }
"void"                      { 
                                fprintf(yyout,"< DATATYPE, %s >\n", yytext); 
                                var =  fopen("symbol table.txt","a");
                                fprintf(var, "\n(%s", yytext); 
                                return VOID; 
                            }
"return"                    { fprintf(yyout,"< KW, %s >\n", yytext); return RETURN; }
"while"	                    { fprintf(yyout,"< KW, %s >\n", yytext); return WHILE; }
"if"	                    { fprintf(yyout,"< KW, %s >\n", yytext); return IF; }
"else"	                    { fprintf(yyout,"< KW, %s >\n", yytext);return ELSE; }
"true"                      { fprintf(yyout,"< BOOLEAN, %s >\n", yytext); return TRUE; }
"false"                     { fprintf(yyout,"< BOOLEAN, %s >\n", yytext); return FALSE; }
"class"                     { fprintf(yyout,"< CLASS, %s >\n", yytext); }
[-]?{digit}+                { fprintf(yyout,"< INTEGR LITERAL, %s >\n", yytext); return NUMBER; }
[-]?{digit}+\.{digit}{1,6}  { fprintf(yyout,"< FLOAT LITERAL, %s >\n", yytext); return FLOAT_NUM; }  
({alpha}|"_")({alpha}|"_"|{digit})*     {  
                                            fprintf(yyout,"< ID, %s >\n", yytext);
                                            var=  fopen("symbol table.txt","a");
                                            fprintf(var, " ,%s)", yytext);
                                            return ID; 
                                        }
{unary}                     { fprintf(yyout,"< OP, %s >\n", yytext); return UNARY; }
"<="                        { fprintf(yyout,"< OP, %s >\n", yytext); return LE; }
">="                        { fprintf(yyout,"< OP, %s >\n", yytext); return GE; }
"=="                        { fprintf(yyout,"< OP, %s >\n", yytext); return EQ; }
"!="                        { fprintf(yyout,"< OP, %s >\n", yytext); return NE; }
">"	                        { fprintf(yyout,"< OP, %s >\n", yytext); return GT; }
"<"	                        { fprintf(yyout,"< OP, %s >\n", yytext); return LT; }
"+"                         { fprintf(yyout,"< OP, %s >\n", yytext); return ADD; }
"-"                         { fprintf(yyout,"< OP, %s >\n", yytext); return SUBTRACT; }
"/"                         { fprintf(yyout,"< OP, %s >\n", yytext); return DIVIDE; }
"*"                         { fprintf(yyout,"< OP, %s >\n", yytext); return MULTIPLY; }
";"|"("|")"|"}"|"{"|"]"|"["|"=" { fprintf(yyout,"< SYMBOL, %s >\n", yytext); }
[ \t]*                      { fprintf(yyout,"< DELIMITER, \'%s\' >\n", yytext); }
[\n]                        { num_line++; }
["].*["]                    { fprintf(yyout,"< STRING LITERAL, \"%s\" >\n", yytext); return STR; }
['].[']                     { fprintf(yyout,"< CHARACTER LITERAL, \'%s\' >\n", yytext); return CHARACTER; }
"//"(.)*"\n"                { fprintf(yyout, "< SLC: \n %s>\n", yytext); ++num_line; }
"/*"(.|\n)*"*/"             {
                                int i;
                                fprintf(yyout,"< MLC:\n");
                                for(i=0;i<strlen(yytext)-1;i++)
                                {
                                    fprintf(yyout,"%c",yytext[i]);
                                    if(yytext[i] == '\n')  {  num_line++;  }
                                }
                                fprintf(yyout,">\n");

                            }
.                           { printf("\nERROR: \'%s\' is found near line number %d.", yytext, num_line); }

%%

int yywrap() {
    return 1;
}