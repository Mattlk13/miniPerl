use v6;
use Test;
use yPerl;

ok yPerl::Grammar.parse($_), "allowing $_" for
'sub {}',
"sub \{\n\}",
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
'sub {}; sub {}();'
;

is yPerl::parse(.key).compile, .value, "{.key} --> {.value}" for
'sub {}' => '() => null',
'sub {}()' => '(() => null)()',
'sub {}()()' => '(() => null)()()',
'sub ($x) {}' => 'x => null',
'sub ($u) { sub {} }' => 'u => () => null',
'sub { $x }' => '() => x',
;

done-testing;
