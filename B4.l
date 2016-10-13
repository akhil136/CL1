%{
#include<stdio.h>
#include<math.h>
#include "y.tab.h"
%}
%%
[a-zA-Z0-9] {yylval.dval=yytext[0];return NUM;}
[\t];
\n return NL;
. {return yytext[0];}
%%
