unit module yPerl;
use yPerl::Grammar;
use yPerl::Actions;
use yPerl::AST;

our sub parse(Str $code) returns yPerl::AST::Node {
    yPerl::Grammar.parse($code, actions => yPerl::Actions).ast
}

our proto compile($) returns Str {*}

multi compile(Str $code) { compile(parse($code)); }
multi compile(yPerl::AST::Variable $variable) { ~$variable.name }
multi compile(yPerl::AST::Abstraction $abstraction) {
    "{
        $abstraction.parameter ?? compile($abstraction.parameter) !! '()'
    } => {
        $abstraction.expression ?? compile($abstraction.expression) !! 'null'
    }"
}
multi compile(yPerl::AST::Application $application) {
    my $compiled-function = compile($application.function);
    $compiled-function = "($compiled-function)" if $application.function ~~ yPerl::AST::Abstraction;
    "{$compiled-function}({$application.argument ?? compile($application.argument) !! ''})";
}
