/*TITLE: Token Table Generator*/	

%{
#include<stdio.h>
int lineno = 1;

int tokencode=255;

%}

letter [a-zA-Z]
digit [0-9]
under [_]
%%

[\n]* {lineno++;}
void |
int |
char |
include |
main |
printf |
if |
for |
break |
while {printf("\n%d \t %s \t\t Keyword\t\t%d", lineno,yytext, tokencode);}

"+" |
"-" |
"*" |
"/" {printf("\n%d \t %s \t\t Binary Operator\t%d", lineno,yytext, tokencode+1);}

"=" {printf("\n%d \t %s \t\t Assignment Operator\t%d", lineno,yytext, tokencode+2);}

"==" |
"<=" |
">=" |
"<" |
">" |
"!=" {printf("\n%d \t %s \t\t Relational Operator\t%d", lineno,yytext, tokencode+3);}

";" |
"(" |
")" |
"{" |
"," |
"}" {printf("\n%d \t %s \t\t Punctuation\t\t%d", lineno,yytext, tokencode+4);}
{digit}+ {printf("\n%d \t %s \t\t Constant\t\t%d", lineno,yytext, tokencode+5);}
{letter}({letter}|{digit}|{under})* {printf("\n%d \t %s \t\t Identifier\t\t%d", lineno,yytext, tokencode+6);}
{digit}({letter}|{digit}|{under})* {printf("\n%d \t %s \t\t Error ", lineno, yytext);}
(\n)*"/*"(.|\n)*"*/" {}
(\n)*"//"(.)* {}
%%

int main(int argc, char **argv) {

FILE *fp;
fp=fopen(argv[1],"r");
yyin=fp;

printf("\nLineNo.  Lexeme  \t Token\t\tToken Code\n");
yylex();
return 1;
}

yywrap()
{}


INPUT FILE:

main()
	{
		int a,b;
		int 9c=20;
		a= 10 ;
		b= 20 ;
		a=b+a* 2 ;
		//trial
		/*multiline comment
		zjhfg*/
	}


OUTPUT:
[ccoew@localhost ~]$ lex token.l
[ccoew@localhost ~]$ gcc lex.yy.c
[ccoew@localhost ~]$ ./a.out main.c

LineNo.  Lexeme  	 Token		Token Code

2 	 main 		 Keyword		255
2 	 ( 		 Punctuation		259
2 	 ) 		 Punctuation		259	
3 	 { 		 Punctuation		259		
4 	 int 		 Keyword		255 
4 	 a 		 Identifier		261
4 	 , 		 Punctuation		259
4 	 b 		 Identifier		261
4 	 ; 		 Punctuation		259		
5 	 int 		 Keyword		255 
5 	 9c 		 Error 
5 	 = 		 Assignment Operator	257
5 	 20 		 Constant		260
5 	 ; 		 Punctuation		259		
6 	 a 		 Identifier		261
6 	 = 		 Assignment Operator	257 
6 	 10 		 Constant		260 
6 	 ; 		 Punctuation		259		
7 	 b 		 Identifier		261
7 	 = 		 Assignment Operator	257 
7 	 20 		 Constant		260 
7 	 ; 		 Punctuation		259		
8 	 a 		 Identifier		261
8 	 = 		 Assignment Operator	257
8 	 b 		 Identifier		261
8 	 + 		 Binary Operator	256
8 	 a 		 Identifier		261
8 	 * 		 Binary Operator	256 
8 	 2 		 Constant		260 
8 	 ; 		 Punctuation		259
