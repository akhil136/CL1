%{
#include<stdio.h>
#include "y.tab.h"
%}
%%
[ \t\n]		;
main		{return MAIN;}
int|float|char|long {return DT; }
if		{return IF;}
else		{return ELSE;}
while		{return WHILE;}
for		{return FOR;}
[0-9]+ 		{return NUMBER;}
[_A-Za-z]*	{return ID;}
\<|\>|\=\=|\>\=|\<\=	{return RELOP;}
. 		{return yytext[0];}

%%


