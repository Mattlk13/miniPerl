use yPerl;
unit grammar zPerl is yPerl;
our package AST {
    class number does yPerl::AST::term {
        has UInt $.value;
        method js { ~$.value }
    }
    class application is yPerl::AST::application {}
}

token number { \d+ { make AST::number.new: value => +$/ } }

rule term {
    | <yPerl::term> { make $<yPerl::term>.ast }
    | $<function> = [ <variable> | <abstraction> ]<application>* {
        my $function = $<variable> || $<abstraction>;
        make $function.ast unless $<application>;
        make reduce -> $t, $s {
            AST::application.new: function => $t, argument => $s.ast
        }, $function.ast, |$<application>[]
    }
    | <number> { make $<number>.ast }
}
rule application { \( [<number>|<term>]? \)
    { make ($<number> || $<term>).ast }
}
