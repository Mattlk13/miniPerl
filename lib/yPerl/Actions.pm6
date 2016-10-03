unit class yPerl::Actions;
use yPerl::AST;

method TOP($/) returns yPerl::AST::Node { make $<term>.ast }

method variable($/) returns yPerl::AST::Variable { make yPerl::AST::Variable.new: :name(~$<ident>) }
method abstraction($/) returns yPerl::AST::Abstraction {
    make yPerl::AST::Abstraction.new: 
    |(:parameter($<parameter>.ast) if $<parameter>),
    |(:expression($<expression>.ast) if $<expression>),
    ;
}
method call($/) returns yPerl::AST::Node { make $<term> ?? $<term>.ast !! yPerl::AST::Node }

method term($/) returns yPerl::AST::Node {
    my $function = ($<variable> || $<abstraction>).ast;
    make $function unless $<call>;
    make reduce -> $t, $s {
        yPerl::AST::Application.new:
        function => $t,
        argument => $s.ast
    }, $function, |$<call>[]
}

