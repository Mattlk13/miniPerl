unit class yPerl::Actions;
use ASTNode;
use yPerl::AST;

method TOP($/) returns ASTNode { make $<term>.ast }

method variable($/) returns yPerl::AST::Variable {
    make yPerl::AST::Variable.new: :name(~$<ident>)
}
method abstraction($/) returns yPerl::AST::Abstraction {
    make yPerl::AST::Abstraction.new: 
    |(:parameter($<parameter>.ast) if $<parameter>),
    |(:expression($<expression>.ast) if $<expression>),
    ;
}
method call($/) returns ASTNode { make $<term> ?? $<term>.ast !! ASTNode }

method term($/) returns ASTNode {
    my $function = ($<variable> || $<abstraction>).ast;
    make $function unless $<call>;
    make reduce -> $t, $s {
        yPerl::AST::Application.new:
        function => $t,
        argument => $s.ast
    }, $function, |$<call>[]
}

