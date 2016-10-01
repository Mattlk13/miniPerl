use v6;
use miniPerl::I;

use Test;
constant %expectations = (
'sub {}' => '() => null',
'sub {}()' => '(() => null)()',
'sub {}()()' => '(() => null)()()',
'sub ($x) {}' => 'x => null',
'sub ($u) { sub {} }' => 'u => () => null',
'sub { $x }' => '() => x',
).hash;

for %expectations {
    is miniPerl::I::AST(.key).js, .value, "{.key} --> {.value}";
}

done-testing();

