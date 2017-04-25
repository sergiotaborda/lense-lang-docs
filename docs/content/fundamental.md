title=Fundamental Types
date=2017-04-18
type=post
tags=fundamental types, lense
status=published
~~~~~~

#Fundamental Types

Lense distinguishes primitive types from fundamental types. Fundamental types are those types the compiler can reason about and/or provide special support. Primitive types are those types that are not objects. In Java, for example, `int` is a primtitive type and all primitive types are also fundamental. However, `String` is also a fundamental type, but is not a primtitive, since it is a class.

Lense supports several fundamental types, but does not support primitives. All things in Lense are objects. 

Fundamental types receive support in two main forms: literals and directives. Many of the fundamental type have literal support in code and some fundamental types have special relevance in directives. For example, the `if` directive only works with expressions that evaluate to a `Boolean`, and the `for` directive only works on `Iterable`s.

Operators are not fundamental in Lense so when you write `2 + 3` this is not specific to numbers, any operator can be used in an class (if it implements specific interface). For more on operators see [Operator Overloading](operators.html).


<ul>
	<li><a href="strings.html">Strings</a></li>
	<li><a href="numbers.html">Numbers</a></li>
	<li><a href="interval.html">Intervals</a></li>
	<li><a href="maybe.html">Maybe</a></li>
	<li>Tuples</li>
	<li><a href="iterable.html">Iterable</a></li>
	<li>Ranges</li>
	<li>Sequence</li>
	<li>Association</li>
	<li><a href="containerLiterals.html">Container Literals</a></li>
</ul>