unit module zPerl;
use ASTNode;
use zPerl::AST;
use yPerl::AST;

our sub parse(Str $code) returns ASTNode {
    use zPerl::Grammar;
    use zPerl::Actions;
    zPerl::Grammar.parse($code, actions => zPerl::Actions).ast
}

our proto compile($) returns ASTNode {*}

multi compile(Str $code) { compile(parse($code)) }
multi compile(ASTNode $node) { $node }
multi compile(zPerl::AST::Cons $cons) {
    yPerl::AST::Application.new:
    function => compile($cons.cdr),
    argument => compile($cons.car);
}
