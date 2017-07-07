title=Fundamental Types
date=2017-04-18
type=post
tags=fundamental types, lense
status=published
~~~~~~

#Fundamental Types

Lense distinguishes primitive types from fundamental types. Fundamental types are those types the compiler can reason about and/or provide special support. Primitive types are those types that are not objects. In Java, for example, `int` is a primtitive type and all primitive types are also fundamental. However, `String` is also a fundamental type (as special support from the compiler and the runtime), but is not a primitive, since it is an object allocated in the heap derived from a class.

Lense supports several fundamental types, but does not support primitives. All things in Lense are objects. 

Fundamental types receive support in two main forms: literals and directives. Many of the fundamental type have literal support in code and some fundamental types have special relevance in directives. For example, the `if` directive only works with expressions that evaluate to a `Boolean`, and the `for` directive only works on `Iterable`s.

Operators are not fundamental in Lense so when you write `2 + 3` this is not specific to numbers, any operator can be used in an class (if it implements a specific interface). For more on operators see [Operator Overloading](operators.html).

<ul>
	<li><a href="booleans.html">Boolean</a></li>
	<li><a href="strings.html">String</a></li>
	<li><a href="numbers.html">Number</a></li>
	<li><a href="binary.html">Binary</a></li>
	<li><a href="interval.html">Interval</a></li>
	<li><a href="iterable.html">Iterable</a></li>
	<li> Containers
		<ul> 
			<li><a href="maybe.html">Maybe</a></li>
			<li><a href="tuples.html">Tuple</a></li>
			
			<li>Range</li>
			<li><a href="sequence.html">Sequence</a></li>
			<li>Association</li>
		</ul>
	</li>
</ul>