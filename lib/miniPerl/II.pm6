use miniPerl::I;
unit grammar miniPerl::II is miniPerl::I;

rule TOP { ^^ <expression>+ % \; \;* $$ }

our class Actions is miniPerl::I::Actions {
    method TOP($/) {
        make reduce -> $a, $b { "sub \{ $b \}($a)" },
        $<expression>
    }
}

method compile(Str $code) {
    self.parse($code, actions => Actions).ast;
}


