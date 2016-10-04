miniPerl
========

## Description

`miniPerl` is a collection of Turing-complete subsets of Perl compiling to ES6
javascript code.  They actually ultimately target lambda-calculus, so they
should be easily translated to any language supporting functional programming.

`yPerl` is the smallest language.  It is only made of three different terms :
variables, functions, and function calls.  It is basically lambda calculs with
a Perl syntax.  It compiles directly to javascript.

`zPerl` extends `yPerl` with sequences of expressions.  Those sequences are
stored as [Cons](https://en.wikipedia.org/wiki/Cons).  `zPerl` compiles into
`yPerl`'s [syntax tree](https://en.wikipedia.org/wiki/Abstract_syntax_tree).

A `Cons` is turned into a lambda-expression as such:

    [car cdr] -> ((λ·cdr) car)

## Synopsis

```Perl6
use yPerl;

say yPerl::compile($_) for
    q[sub {}],          # () => null
    q[sub {}()],        # (() => null)()
    q[sub ($x) {}($y)]; # (x => null)(y)
```
    

    
