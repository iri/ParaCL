%option c++

%x COMMENT

%{
    #include "grammar.tab.hh"
%}

WS          [ \t\n\r\v]+
DIG         [0-9]
ALP         [a-zA-Z_]

%%

"//"		            BEGIN(COMMENT);
<COMMENT>[^\n]*         /* skip */
<COMMENT>\n	            BEGIN(INITIAL);

{WS}                    /* skip blanks, tabs, newlines */

[-+]?{DIG}+             {return yy::parser::token_type::INTVAL;}
{ALP}({ALP}|{DIG})*     {return yy::parser::token_type::ID;}

"+"                     {return yy::parser::token_type::PLUS;}
"-"                     {return yy::parser::token_type::MINUS;}
"*"                     {return yy::parser::token_type::MUL;}
"/"                     {return yy::parser::token_type::DIV;}
"%"                     {return yy::parser::token_type::MOD;}

"=="                    {return yy::parser::token_type::EQ;}
"!="                    {return yy::parser::token_type::NOT_EQ;}
">"                     {return yy::parser::token_type::GT;}
"<"                     {return yy::parser::token_type::LT;}
">="                    {return yy::parser::token_type::GE;}
"<="                    {return yy::parser::token_type::LE;}

"&&"                    {return yy::parser::token_type::AND;}
"||"                    {return yy::parser::token_type::OR;}
"!"                     {return yy::parser::token_type::NOT;}

";"                     {return yy::parser::token_type::SEMICOLON;}
","                     {return yy::parser::token_type::COMMA;}
"("                     {return yy::parser::token_type::OPEN_PT;}
")"                     {return yy::parser::token_type::CLOSE_PT;}
"{"                     {return yy::parser::token_type::OPEN_BR;}
"}"                     {return yy::parser::token_type::CLOSE_BR;}
":"                     {return yy::parser::token_type::COLON;}

"?"                     {return yy::parser::token_type::INPUT;}
"="                     {return yy::parser::token_type::ASSIGN;}
"print"                 {return yy::parser::token_type::PRINT;}
"if"                    {return yy::parser::token_type::IF;}
"else"                  {return yy::parser::token_type::ELSE;}
"while"                 {return yy::parser::token_type::WHILE;}
"func"                  {return yy::parser::token_type::FUNC;}
"return"                {return yy::parser::token_type::RETURN;}
"self"                  {return yy::parser::token_type::SELF;}

.			            {return yy::parser::token_type::SYNTAX_ERROR;}

%%


// == END ==

