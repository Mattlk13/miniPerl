unit grammar yPerl::Grammar;

rule TOP { ^^ <term> $$ }

token variable { \$<ident> }
rule abstraction {
    sub [\( <parameter=variable>? \)]? \{ <expression=term>? \}
}

rule call { \(<term>?\) }
rule term { [ <variable> | <abstraction> ]<call>* }


