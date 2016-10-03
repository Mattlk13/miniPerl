unit module yPerl::AST;

our role Node {}

our class Variable    does Node {
    has Str $.name where /^^<.ident>$$/;
}
our class Abstraction does Node {
    has Variable $.parameter;
    has Node     $.expression;
}
our class Application does Node {
    has Node ($.function, $.argument);
}
