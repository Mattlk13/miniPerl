use zPerl;
use Test;

ok zPerl.parse($_), "allowing $_" for 
'1',
'12345',
'sub { 0 }',
'sub ($x) { 6 }',
'$x($y(12))',
;

nok zPerl.parse($_), "not allowing $_" for
'$x(-1)',
'sub ($x) { $x + 6 }(87)',
'sub (12) { }',
'sub () { -1 }',
;

done-testing;
