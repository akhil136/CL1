
%{
#include<stdio.h>
int yylex(void);
char r1[20],r2[20],r3[20],l[20],rr1[20],rr2[20],rr3[20],ll[20];
char w,x,y,z;
int k=0,i,j,p=0,flag[20],pk[20];
%}

%union
{
    char dval;
}
%token <dval> NUM
%token <dval> NL
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS
%type <dval> S
%type <dval> E
%%
S : N '=' E LINE {}
  | {
    for(i=0;i<20;i++)      
        pk[i]=flag[i]=0;

    /*    r1[],r2[],r3[] are the arrays used to store character 
                          on RHS of '=' of 3 address generated code.
          l[] array used for storing LHS character of expression  
                         of 3 address generated code.                

          rr1[],rr2[],rr3[] are the arrays used to store character
                         on RHS of '=' of optimized code.
          ll[] array used for storing LHS character of expression 
                         of optimized code.                 

          pk[] is array for replacement in optimization.
           flag[] is array used to check whether RHS of expression
                         is repeated or not.
        
          w,x,y,z are the characters used for elliminating Dead 
                         code generation in optimized code.

    */
for(i=0;i<k;i++)
{
    for(j=i+1;j<k;j++)
    {
      if(r1[i]==r1[j] && r2[i]==r2[j] && r3[i]==r3[j] && flag[j]!=1)
         {
            flag[j]=1;
            pk[j]=i;
         }
      }
}
for(i=0;i<k;i++)
{
   if(flag[i]!=1)
    {
        x=rr1[p]=r1[i];
        y=rr2[p]=r2[i];
        z=rr3[p]=r3[i];
        ll[p]=l[i];
        p++;
    }
    else
    {
        rr1[p]='\0';
        rr2[p]='\0';
        rr3[p]='\0';
        ll[p]='\0';
        p++;
      }
}

for(i=0;i<p;i++)
{
  if(flag[i]==1)
   {
     for(j=0;j<p;j++)
    {
      if(rr1[j]==l[i])
      rr1[j]=l[pk[i]];
      if(rr3[j]==l[i])
      z=rr3[j]=l[pk[i]];
     }
   }
}
    
printf("\n Optimized Code is => ");
for(i=0;i<p-1;i++)
{
   if(ll[i]!='\0' || rr1[i]!='\0' || rr2[i]!='\0' || rr3[i]!='\0')
    {
      printf("\n %C=%C%C%C",ll[i],rr1[i],rr2[i],rr3[i]);
    }
}
 printf("\n %C=%C%C%C",w,x,y,z);
}
  ;
N : NUM {w=l[k]=$1;}
  ;
LINE : NL S {}
     | {}
     ;
E : NUM {$$=$1;}
  | E '+' E {r1[k]=$1;r2[k]='+';r3[k]=$3;k++;}
  | E '-' E {r1[k]=$1;r2[k]='-';r3[k]=$3;k++;}
  | E '*' E {r1[k]=$1;r2[k]='*';r3[k]=$3;k++;}
  | E '/' E {r1[k]=$1;r2[k]='/';r3[k]=$3;k++;}
  ;
%%
FILE *yyin;


main()
{
FILE *fpInput;
FILE *fpOut;

fpInput=fopen("ip.txt","r");
if(fpInput=='\0')    
{
    printf("file read error");
}

fpOut=fopen("a14op.txt","w");
if(fpOut=='\0')
{
printf("file creation error");
//exit(0);
}
yyin=fpInput;
yyparse();
fcloseall();
}

yyerror(char *msg)

{
    printf("%s\n",msg);
}

yywrap()
{
return 1;
}
