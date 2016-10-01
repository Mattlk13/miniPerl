unit module miniPerl;
use miniPerl::I;

sub compile-to-javascript(Str $code) returns Str is export {
    if miniPerl::I.parse($code, actions => class {
            method TOP($/) { make $<expression>.ast }
            method variable($/) { make ~$<name>; }
            method application($/) { make "({$<expression>.ast || ''})"; }
            method subroutine($/) {
                make "({$<variable>.ast || '_'} => {$<expression>.ast || 'null'})";
            }
            method expression($/) {
                make ($<variable>.ast || $<subroutine>.ast) ~ $<application>».ast.join;
            }
        }
    ) { return $/.ast; }
    else { die "syntax error" }
}
