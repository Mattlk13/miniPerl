unit module miniPerl;
use miniPerl::I;

sub compile-to-javascript(Str $code) returns Str is export {
    return
    miniPerl::I.compile($code) ||
    miniPerl::I.compile(miniPerl::II.compile($code));
}
