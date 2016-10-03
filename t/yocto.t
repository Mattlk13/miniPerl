use v6;
use Test;
use yPerl::Grammar;

ok yPerl::Grammar.parse($_), "allowing $_" for
'sub {}',
'$x()',
'sub {}()',
'sub { sub {} }()()',
'sub { }',
'sub () { }',
'sub ($x) { }',
'sub () {}()',
'sub ($x) { sub {} }',
'sub ($x) { sub {}() }',
'sub ($x) { sub ($y) {}($x()) }',
;

nok yPerl::Grammar.parse($_), "not allowing $_" for
'f()',
'sub ($) {}',
'sub ($x, $y) {}',
'sub { $^x }',
'sub ($x!) {}',
'sub (:$x) {}',
'sub {}(sub {}, sub {})',
;

done-testing;
