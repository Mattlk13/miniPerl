use v6;
use Test;
use zPerl;

ok zPerl::Grammar.parse($_), "allowing {.subst("\n", "\x2424")}" for
'$a(); $b()',
('sub {}();', 'sub ($a) { $b }($c);').join("\n")
;

nok zPerl::Grammar.parse($_), "not allowing {.subst("\n", "\x2424")}" for
'sub ($) {}',
'sub ($x, $y) {}',
'sub { $^x }',
'sub ($x!) {}',
'sub (:$x) {}',
'sub {}(sub {}, sub {})',
;

done-testing;
