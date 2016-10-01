unit grammar miniPerl::I;
use λ;
rule TOP {
    ^^ <term> $$
    { make $<term>.ast }
}
token variable {
    '$' $<name> = <.ident>+
    { make λ::variable.new: name => ~$<name> }
}
rule application { '(' <term>? ')' { make $<term>.ast } }
rule abstraction {
    sub [ '(' <variable>? ')' ]? '{' <term>? '}'
    {
        make λ::abstraction.new:
        variable => $<variable>.ast,
        expression => $<term>.ast,
    }
}
rule term {
    [ <variable> | <abstraction> ] <application>*
    {
        my $function = $<variable> || $<abstraction>;
        make $function.ast unless $<application>;
        make reduce -> $t, $s {
            λ::application.new: function => $t, argument => $s.ast
        }, $function.ast, |$<application>[]
    }
}
