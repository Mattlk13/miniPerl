use zPerl;
use Test;

ok zPerl.parse($_), "allowing $_" for 
'1',
'sub { 0 }',
'sub ($x) { 6 }',
;

nok zPerl.parse($_), "not allowing $_" for
'sub ($x) { $x + 6 }(87)',
'sub (12) { }',
'sub () { -1 }',
;

done-testing;
