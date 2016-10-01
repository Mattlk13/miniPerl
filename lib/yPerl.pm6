unit grammar yPerl;
our package AST {
    role term { method js returns Str {...} }
    class variable does term {
        has Str $.name where /^^<ident>$$/;
        method js { $!name || 'null' }
    }
    class abstraction does term {
        has variable $.variable;
        has term $.expression;
        method js { "{
            $!variable ?? $!variable.js !! '()'
        } => {
                $!expression ?? $!expression.js !! 'null'
            }";
        }
    }
    class application does term {
        has term $.function;
        has term $.argument;
        method js {
            my $jsfunction = $!function.js;
            $jsfunction = "($jsfunction)" if $!function ~~ abstraction;
            "{$jsfunction}({$!argument ?? $!argument.js !! ''})"
        }
    }
}

rule TOP {
    ^^ <term> $$
    { make $<term>.ast }
}
token variable {
    '$' $<name> = <.ident>+
    { make AST::variable.new: name => ~$<name> }
}
rule application { '(' <term>? ')' { make $<term>.ast } }
rule abstraction {
    sub [ '(' <variable>? ')' ]? '{' <term>? '}'
    {
        make AST::abstraction.new:
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
            AST::application.new: function => $t, argument => $s.ast
        }, $function.ast, |$<application>[]
    }
}
