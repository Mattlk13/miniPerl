unit module yPerl::AST;

our role Term {
    method js {...}
}

our class Variable    does Term {
    has Str $.name where /^^<.ident>$$/;
    method js { ~$!name }
}
our class Abstraction does Term {
    has Variable $.parameter;
    has Term     $.expression;
    method js {
        "{
            $!parameter ?? $!parameter.js !! '()'
        } => {
            $!expression ?? $!expression.js !! 'null'
        }"
    }
}
our class Application does Term {
    has Term $.function;
    has Term $.argument;
    method js {
        my $jsfunction = $.function.js;
        $jsfunction = "($jsfunction)" if $!function ~~ Abstraction;
        "{$jsfunction}({$!argument ?? $!argument.js !! ''})";
    }
}
