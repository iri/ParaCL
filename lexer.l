%option c++

%x COMMENT

%{
    #include "grammar.tab.hh"
%}

WS      [ \t\n\r\v]+
DIGIT   [0-9]
ALPHA  [a-zA-Z_]

%%

"//"		            BEGIN(COMMENT);
<COMMENT>[^\n]*         /* skip */
<COMMENT>\n	            BEGIN(INITIAL);

{WS}                    /* skip blanks, tabs, newlines */
"+"                     {std::cout << "PLUS "; return yy::parser::token_type::PLUS;}
"-"                     {std::cout << "MINUS "; return yy::parser::token_type::MINUS;}
"="                     {std::cout << "ASSIGN "; return yy::parser::token_type::ASSIGN;}
";"                     {std::cout << "SEMICOL "; return yy::parser::token_type::SEMICOL;}
"?"                     {std::cout << "INPUT "; return yy::parser::token_type::INPUT;}
{DIGIT}+                {std::cout << "NUMBER "; return yy::parser::token_type::NUMBER;}
{ALPHA}({ALPHA}|{DIGIT})*    {std::cout << "ID "; return yy::parser::token_type::ID;}
.			            {std::cout << "ERR "; return yy::parser::token_type::ERR;}

%%

// == END ==

