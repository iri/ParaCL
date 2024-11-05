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
  PLUS
  MINUS
  MUL
  DIV
  MOD
  EQ
  NEQ
  GT
  LT
  GE
  LE
  AND
  OR
  NOT
  SEMICOLON
  COMMA
  OPEN_PT
  CLOSE_PT
  OPEN_BR
  CLOSE_BR
  INPUT
  ASSIGN
  PRINT
  IF
  ELSE
  WHILE
  FUN
  RETURN
  SELF
  SYNTAX_ERROR
;

%token <int> INTVAL
%token <int> ID
%nterm <int> int_expr

%nterm 
  program
  stmt_list
  stmt
  print_stmt
  assign_stmt
  if_else_stmt
  while_stmt
  fun_call_stmt
  return_stmt
  opt_int_expr
  int_expr
;

%start program

%%

program: 
      stmt_list                                       {}
;

stmt_list: 
      stmt_list stmt                                  {}
    | %empty
;

stmt: 
      print_stmt                                      {}
    | assign_stmt                                     {}
    | if_stmt                                         {}
    | while_stmt                                      {}
    | fun_def_stmt                                    {}
    | fun_call_stmt                                   {}
;

print_stmt: 
      PRINT int_expr SEMICOLON                        {}
;

assign_stmt: 
      ID ASSIGN int_expr SEMICOLON                    {}
;

if_stmt: 
      IF OPEN_PT int_expr CLOSE_PT 
        OPEN_BR stmt_list CLOSE_BR
      opt_else                                        {}
;

opt_else: 
      ELSE 
        OPEN_BR stmt_list CLOSE_BR                    {}
    | %empty
;

while_stmt: 
      WHILE OPEN_PT int_expr CLOSE_PT 
        OPEN_BR stmt_list CLOSE_BR                    {}
;

fun_def_stmt: 
      FUN OPEN_PT formal_arg_list CLOSE_PT 
        EQ 
          OPEN_BR fun_body_stmt_list CLOSE_BR         {}
;

formal_arg_list: 
      formal_arg_list COMMA ID                        {}
    | ID                                              {}
    | %empty
;

fun_body_stmt_list: 
      fun_body_stmt_list fun_body_stmt                {}
    | %empty
;

fun_body_stmt: 
      print_stmt                                      {}
    | assign_stmt                                     {}
    | if_stmt                                         {}
    | while_stmt                                      {}
    | fun_call_stmt                                   {}
    | return_stmt                                     {}
;

fun_call_stmt: 
      ID OPEN_PT int_arg_list CLOSE_PT SEMICOLON      {}
;

int_arg_list: 
      int_arg_list COMMA int_expr                     {}
    | int_expr                                        {}
    | %empty
;

return_stmt: 
      RETURN opt_int_expr SEMICOLON                   {}
;

opt_int_expr: 
      int_expr                                        {}
    | %empty
;

fun_call_expr: 
      ID OPEN_PT int_arg_list CLOSE_PT                {}
    | SELF OPEN_PT int_arg_list CLOSE_PT              {}
;

int_expr: 
      ID ASSIGN or_expr                               {}
    | or_expr                                         {}
;

or_expr: 
      or_expr OR and_expr                             {}
    | and_expr                                        {}
;

and_expr: 
      and_expr AND cmp1_expr                          {}
    | cmp1_expr                                       {}
;

cmp1_expr: 
      cmp1_expr EQ cmp2_expr                          {}
    | cmp1_expr NEQ cmp2_expr                         {}
    | cmp2_expr                                       {}
;

cmp2_expr: 
      cmp2_expr GT arithm_expr                        {}
    | cmp2_expr LT arithm_expr                        {}
    | cmp2_expr GE arithm_expr                        {}
    | cmp2_expr LE arithm_expr                        {}
    | arithm_expr                                     {}
;

arithm_expr: 
      arithm_expr PLUS term                           {}
    | arithm_expr MINUS term                          {}
    | term                                            {}
;

term: 
      term MUL fact                                   {}
    | term DIV fact                                   {}
    | term MOD fact                                   {}
    | fact                                            {}
;

fact: 
      NOT unary_expr                                  {}
    | MINUS unary_expr                                {}
    | PLUS unary_expr                                 {}
    | unary_expr                                      {}
;

unary_expr: 
      INTVAL                                          {}
    | INPUT                                           {}
    | fun_call_expr                                   {}
    | OPEN_PT or_expr CLOSE_PT                        {}
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

