unit grammar miniPerl::I;
rule TOP { ^^ <term> $$ }
token variable { '$' $<name> = <.ident>+ }
rule application { '(' <term>? ')' }
rule abstraction { sub [ '(' <variable>? ')' ]? '{' <term>? '}' }
rule term { [ <variable> | <abstraction> ] <application>* }

our class Actions {
    use λ;
    method TOP($/) { make $<term>.ast }
    method variable($/) { make λ::variable.new: name => ~$<name> }
    method abstraction($/) {
        make λ::abstraction.new:
        variable => $<variable>.ast,
        expression => $<term>.ast,
    }
    method application($/) { make $<term>.ast }
    method term($/) {
        my $function = $<variable> || $<abstraction>;
        make $function.ast unless $<application>;
        make reduce -> $t, $s {
            λ::application.new: function => $t, argument => $s.ast
        }, $function.ast, |$<application>[]
    }
}

our sub AST(Str $code) { ::?CLASS.parse($code, actions => Actions).ast }
