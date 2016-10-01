unit module λ;
role term { method js returns Str { "" } }
class variable does term {
    has Str $.name where /^^<ident>$$/;
    method js { $.name || 'null' }
}
class abstraction does term {
    has variable $.variable;
    has term $.expression;
    method js { "{
        $.variable ?? $.variable.js !! '()'} => {
            $.expression ?? $.expression.js !! 'null'
        }";
    }
}
class application does term {
    has term $.function;
    has term $.argument;
    method js {
        my $jsfunction = $.function.js;
        $jsfunction = "($jsfunction)" if $.function ~~ abstraction;
        "{$jsfunction}({$.argument.js})"
    }
}

