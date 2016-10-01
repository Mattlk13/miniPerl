use v6;
use miniPerl;

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
    is compile-to-javascript(.key), .value, "{.key} --> {.value}";
}

done-testing();

