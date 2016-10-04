use yPerl::Actions;
unit class zPerl::Actions is yPerl::Actions;
use ASTNode;
use zPerl::AST;

method TOP($/) {
    my @terms = $<term>[].reverse;
    make @terms == 1 ?? @terms[0].ast but ASTNode !!
    reduce -> $a, $b {
        zPerl::AST::Cons.new:
        car => $b.ast,
        cdr => $a
    }, @terms[0].ast, |@terms[1..*];
}
