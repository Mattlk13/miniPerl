unit module miniPerl;
use miniPerl::I;

proto compile-to-javascript(Str $) returns Str is export {*}

multi compile-to-javascript($code where miniPerl::I.parse($code,
    actions => class {
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
    )
) {
    return $/.ast;
}
