unit grammar miniPerl::I;
rule TOP { ^^ <expression> $$ }
token variable { '$' $<name> = <ident>+ }
rule application { '(' <expression>? ')' }
rule subroutine { sub [ '(' <variable>? ')' ]? '{' <expression>? '}' }
rule expression { [ <variable> | <subroutine> ] <application>* }
