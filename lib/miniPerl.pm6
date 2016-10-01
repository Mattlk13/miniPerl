unit module miniPerl;
use yPerl;
use zPerl;

sub compile-to-javascript(Str $code) returns Str is export {
    return 
        (
            False
            || yPerl.parse($code)
            || zPerl.parse($code)
        ).ast.js
}
