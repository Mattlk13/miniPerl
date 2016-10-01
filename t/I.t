use v6;
use Test;
use miniPerl::I;

plan 16;

ok miniPerl::I.parse($_), "allowing $_" for
'sub {}',
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

nok miniPerl::I.parse($_), "not allowing $_" for
'sub ($) {}',
'sub ($x, $y) {}',
'sub { $^x }',
'sub ($x!) {}',
'sub (:$x) {}',
'sub {}(sub {}, sub {})',
;

