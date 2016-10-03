unit module yPerl::AST;

our role Term {}

our class Variable    does Term { has Str $.name; }
our class Abstraction does Term {
    has Variable $.parameter;
    has Term     $.expression;
}
our class Application does Term {
    has Term $.function;
    has Term $.argument;
}
