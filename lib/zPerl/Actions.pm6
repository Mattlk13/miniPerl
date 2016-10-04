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
=finish
yPerl::AST::Application.new(
function => yPerl::AST::Application.new(
    function => yPerl::AST::Abstraction.new(
        parameter => yPerl::AST::Variable,
        expression => yPerl::AST::Variable.new(name => "c")
    ),
    argument => yPerl::AST::Abstraction.new(
        parameter => yPerl::AST::Variable.new(name => "b"), expression => ASTNode)
),
argument => yPerl::AST::Variable.new(name => "a")
)
