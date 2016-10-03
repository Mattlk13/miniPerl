unit module yPerl;
use yPerl::Grammar;
use yPerl::Actions;
use yPerl::AST;

our sub compile(Str $code) returns yPerl::AST::Node is export {
    yPerl::Grammar.parse($code, actions => yPerl::Actions).ast
}
