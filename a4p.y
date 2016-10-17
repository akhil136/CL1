%{
#include<stdio.h>
#include<stdlib.h>
extern FILE *yyin;
%}

%token MAIN DO IF WHILE ELSE FOR ID NUMBER DT RELOP;
%left '+' '-'
%left '*' '/'
%start program
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE


%%

program: MAIN '('')' '{' slist '}' 	{printf("Program is valid\n");}
	;

slist: vstmt s
	;

vstmt: varlist vstmt
	|
	;

varlist: DT vardecl ';'			{printf("Valid declaration\n");}
	;

vardecl: ID ',' vardecl
	| ID
	;

s: 	stmt s
	|
	;


stmt:	 ID '=' expr ';'		{printf("Vlaid Statement\n");}
	| expr ';'			{printf("Valid Statemnt\n");}
	| forstat
	| whiles
	| ifstat
	;


expr: 	expr '+' expr 				{}
	| expr '-' expr 			{}
	| expr '*' expr 			{}
	| expr '/' expr 			{}
	| ID					{}
	;

ifstat: IF '(' condition ')' '{' stmt '}'  %prec LOWER_THAN_ELSE {printf("Valid IFFF\n");}
	| IF '('condition')' '{' stmt '}' ELSE '{' stmt '}'		{printf("Valid IFFFFELSEEEEEE\n");}

condition: expr RELOP expr 
	;

forstat: FOR '(' assignment ';' condition ';' incdec ')' '{' stmt '}' {printf("Valid FORRRRRR\n");}
	;

assignment: ID '=' expr 			{}
	| ID '=' NUMBER				{}
	;

incdec: ID '+''+'				{}
	| ID '-''-'				{}
	;

whiles: WHILE '(' condition ')' '{' stmt '}'
	;
%%

int main()
{
FILE *fp=fopen("cc.c","r");
yyin=fp;
if(!yyparse())
{
	printf("PRogrma sucecful\n");
}
else
	printf("Prgram unsuccessful");
}

void yyerror()
{
printf("Syntax error\n");
}

int yywrap()
{
return 1;
}
