use yPerl::Grammar;
unit grammar zPerl::Grammar is yPerl::Grammar;

rule TOP { ^^ <term>+ %% \; $$ }

