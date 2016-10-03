unit module yPerl::AST;

our role Node {
    method compile {...}
}

our class Variable    does Node {
    has Str $.name where /^^<.ident>$$/;
    method compile { ~$!name }
}
our class Abstraction does Node {
    has Variable $.parameter;
    has Node     $.expression;
    method compile {
        "{
            $!parameter ?? $!parameter.compile !! '()'
        } => {
            $!expression ?? $!expression.compile !! 'null'
        }"
    }
}
our class Application does Node {
    has Node $.function;
    has Node $.argument;
    method compile {
        my $compiled-function = $.function.compile;
        $compiled-function = "($compiled-function)" if $!function ~~ Abstraction;
        "{$compiled-function}({$!argument ?? $!argument.compile !! ''})";
    }
}
