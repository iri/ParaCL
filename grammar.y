%language "c++"

%skeleton "lalr1.cc"
%defines
%define api.value.type variant
%param {
  yy::NumDriver* driver
}

%code requires
{
  #include <iostream>
  #include <string>
  #include <utility>

  // forward decl of argument to parser
  namespace yy { 
    class NumDriver; 
  }
}

%code
{
  #include "numdriver.hpp"
  namespace yy {
    parser::token_type yylex(parser::semantic_type* yylval, NumDriver* driver);
  }
}

%token
  ASSIGN   "="
  SEMICOL  ";"
  INPUT    "?"
  MINUS   "-"
  PLUS    "+"
  ERR
;

%token <int> NUMBER
%token <int> ID
%nterm <int> expr

%left '+' '-'

%start program

%%

program: stmt_list
;

stmt_list: stmt SEMICOL {std::cout << std::endl; } stmt_list 
      | %empty
;

stmt: assign_stmt   { }
    | eq_stmt       { }
;

assign_stmt: ID ASSIGN INPUT       { }

eq_stmt: expr       { }
;

expr: expr PLUS NUMBER        { $$ = $1 + $3; }
    | expr MINUS NUMBER       { $$ = $1 - $3; }
    | NUMBER                  { $$ = $1; }
;

%%

namespace yy {

parser::token_type yylex(parser::semantic_type* yylval,                         
                         NumDriver* driver)
{
  return driver->yylex(yylval);
}

void parser::error(const std::string&){}
}

