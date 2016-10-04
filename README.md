miniPerl
========

## Description

`miniPerl` is a collection of Turing-complete subsets of Perl compiling to ES6
javascript code.  They actually ultimately target lambda-calculus, so they
should be easily translated to any language supporting functional programming.

## Synopsis

```Perl6
use yPerl;

say yPerl::compile($_) for
    q[sub {}],          # () => null
    q[sub {}()],        # (() => null)()
    q[sub ($x) {}($y)]; # (x => null)(y)
```
    

    
