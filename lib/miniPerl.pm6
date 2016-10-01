unit module miniPerl;
use miniPerl::I;

sub compile-to-javascript(Str $code) returns Str is export {
    return miniPerl::I.parse($code).ast.js
}
