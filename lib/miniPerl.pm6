unit module miniPerl;
use miniPerl::I;

sub compile-to-javascript(Str $code) returns Str is export {
    if miniPerl::I.parse($code, actions => miniPerl::I::Actions) {
        return $/.ast;
    } else { die "syntax error" }
}
