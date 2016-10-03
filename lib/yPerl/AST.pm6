unit module yPerl::AST;

our role Node {
    method js {...}
}

our class Variable    does Node {
    has Str $.name where /^^<.ident>$$/;
    method js { ~$!name }
}
our class Abstraction does Node {
    has Variable $.parameter;
    has Node     $.expression;
    method js {
        "{
            $!parameter ?? $!parameter.js !! '()'
        } => {
            $!expression ?? $!expression.js !! 'null'
        }"
    }
}
our class Application does Node {
    has Node $.function;
    has Node $.argument;
    method js {
        my $jsfunction = $.function.js;
        $jsfunction = "($jsfunction)" if $!function ~~ Abstraction;
        "{$jsfunction}({$!argument ?? $!argument.js !! ''})";
    }
}
