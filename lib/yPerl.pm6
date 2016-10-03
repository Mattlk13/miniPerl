unit module yPerl;
use yPerl::Grammar;
use yPerl::Actions;
use yPerl::AST;

our sub parse(Str $code) returns yPerl::AST::Node {
    yPerl::Grammar.parse($code, actions => yPerl::Actions).ast
}
