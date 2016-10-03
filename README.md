miniPerl
========

## Description

`miniPerl` is a collection of Turing-complete subsets of Perl compiling to ES6
javascript code.  They actually ultimately target lambda-calculus, so they
should be easily translated to any language supporting functional programming.

## Synopsis

    use yPerl;

    say compile($_).js
        for q[sub {}], q[sub {}()], q[sub ($x) {}($y)];
    

    
