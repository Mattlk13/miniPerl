unit module miniPerl;
use yPerl;

sub compile-to-javascript(Str $code) returns Str is export {
    return yPerl.parse($code).ast.js
}
