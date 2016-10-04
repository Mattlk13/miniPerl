unit module yPerl::AST;
use ASTNode;

our class Variable    does ASTNode {
    has Str $.name handles <gist> where /^^<.ident>$$/;
}
our class Abstraction does ASTNode {
    has Variable $.parameter;
    has ASTNode  $.expression;
    multi method gist { "λ{$!parameter.gist if $!parameter}.({$!expression.gist if $!expression})" }
}
our class Application does ASTNode {
    has ASTNode ($.function, $.argument);
    multi method gist {
        "({$!function.gist} {$!argument.gist})"
    }
}
