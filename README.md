miniPerl
========

## Description

`miniPerl` is a Turing-complete subset of Perl compiling to
ES6 javascript code.

## Synopsis

    use miniPerl;

    say compile-to-javascript q[sub {}];             # (_ => null)
    say compile-to-javascript q[sub {}()];           # (_ => null)()
    say compile-to-javascript q[sub ($x) {}($y)];    # (x => null)(y)

    
