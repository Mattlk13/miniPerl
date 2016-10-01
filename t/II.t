use v6;
use Test;
use miniPerl::II;

ok miniPerl::II.parse($_), "allowing $_" for
'sub {};',
'sub {}; sub {}',
'sub {}; sub {};',
'sub {}; sub {}; sub {}',
'sub {}; sub {}; sub {};',
;

constant %expectations = (
    'sub ($x) {}; sub ($y) {}' => 'sub { sub ($y) {} }(sub ($x) {})',
    'sub ($x) {}; sub ($y) {}; sub ($z) {}' => 'sub { sub ($z) {} }(sub { sub ($y) {} }(sub ($x) {}))',
).hash;

for %expectations {
    is miniPerl::II.compile(.key), .value, "compile({.key}) --> {.value}";
}

done-testing;
