use v6;
use miniPerl;

use Test;
constant %expectations = (
'sub {}' => '(_ => null)',
'sub {}()' => '(_ => null)()',
'sub {}()()' => '(_ => null)()()',
'sub ($x) {}' => '(x => null)',
'sub ($u) { sub {} }' => '(u => (_ => null))',
'sub { $x }' => '(_ => x)',
).hash;

plan %expectations.elems;

for %expectations {
    is compile-to-javascript(.key), .value, "{.key} --> {.value}";
}

