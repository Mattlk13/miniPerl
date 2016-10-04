unit module zPerl::AST;
use ASTNode;
use yPerl::AST;

our class Cons does ASTNode {
    has ASTNode ($.car, $.cdr);
    method gist { "({$!car.gist}, {$!cdr.gist})" }
}
