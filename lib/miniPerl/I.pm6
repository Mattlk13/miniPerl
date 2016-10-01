unit grammar miniPerl::I;
rule TOP { ^^ <expression> $$ }
token variable { '$' $<name> = <ident>+ }
rule application { '(' <expression>? ')' }
rule subroutine { sub [ '(' <variable>? ')' ]? '{' <expression>? '}' }
rule expression { [ <variable> | <subroutine> ] <application>* }

our constant Actions = class {
    method TOP($/) { make $<expression>.ast }
    method variable($/) { make ~$<name>; }
    method application($/) { make "({$<expression>.ast || ''})"; }
    method subroutine($/) {
        make "({$<variable>.ast || '()'} => {$<expression>.ast || 'null'})";
    }
    method expression($/) {
        make ($<variable>.ast || $<subroutine>.ast) ~ $<application>».ast.join;
    }
}
