title=Home
date=2015-12-12
type=post
tags=tour, lense
status=published
~~~~~~
# Lense

Lense is a strong typed, pure object oriented programming language that tries to be carefully crafted by meticulous observation and analysis of language design state-of-the-art and comparison with other language design decisions (and mistakes, yes). Even with this analysis and comparation with the state-of-the-art, Lense does not aim to be an academic driven language even when it tries to follow a more scientific and logic approach to design decision making.

Lense goal is to be a simple language, easy to read and write that could be compiled to any object oriented platform. The first effort will focus on running Lense in the Java Virtual Machine (JVM). Other possible platforms are Javascript and CRL (.NET)

# Some features to expect 

## Basic Syntax
Lense syntax starts fom a C familly based syntax ( methods delimited with *{* and *}* ) but moves the type declaration to the end. This is because types can be infered when not declared.

~~~~brush: lense 
val n = 4; // infers type is Natural
val r = 5.6; // infers type Rational

var x = n + r; // infers type Rational 

val name = "John"; //infers type String
~~~~

Variables and expressions can be easy inserted within a string using a simple syntax (see [string](strings.html)).

~~~~brush: lense 
val birthday = new Date(1976, 4, 2);
var name = "John";

val message =  "{{ name }} was born on {{ birthday }}";
~~~~

## Object Oriented
All types are treated as objects in the heap. Some [fundamental types](glossary.html#fundamentalType) receive special handling from the compiler in the form of literals or specific operators. The compiler is free to optimize them to the plataform's primitives as it sees fit (see [erasure](erasure.html)).

Because everything is an object all variables must have been initialized at some point and cannot hold *null*. The concept of "absent value" is support by introducing the [Maybe monad](monads.html) (see [nullability](nullability.html)).  

Generics are reified and the type information of the generic type parameters can be inspected at runtime. This is really works well with [factory constructors](constructors.html#factory)

Types can have generic parameters and these parameters can declare their intended variance on site. 

No *statics*. All things are objects or exist within an object. Lense supports singleton object definition.

## Math friendly

No symbolic noise : operator symbols are predefined and associated with specific interfaces so classes like numbers and strings can use operators.However defining you own operator symbol is not allowed in order to maintain the code simple to read. The use of interfaces to define operations follows an algebraic structure paradigm so the compiler can reason about the operations (example : altering the order of operations the enhance performance if the operation is commutative)

Suport to Rational, Imaginary and Complex numbers : Its important that these numeric types are supported even if the performance is not optimal. Peformance is a problem for the runtime , not the language and expression of intention is more important that performance.

~~~~brush: lense 
var n : Natural = 3; // numbers are naturals by default. naturals are non negative
var d : Integer = -2; // integer holds negative whole numbers 

var r : Rational = -1.5; // decimal literals are rational numbers by default.

if (r == n/d ){
	// natural devision always produces a Rational
	// numbers are compared by value independently of type.
}
~~~~

Lense supports progressions. Progressions are range like objects that can be iterated from a given start value to a given end value. The main difference between a progression and a range on other languages is that progressions have not to be linear.

~~~~brush: lense 
for ( x in 3..7 ){
	// iterate from 3 to 7
}
~~~~

Intervals are another usefull type to have fundamental support. Interval literals allow you to express in the limit is contained on the inteval or not. Also allows you to define only upper , or lower bounds

~~~~brush: lense 
if ( x in |[ 3 , 7)| ){
	// x is >=3 and < 7
}

if ( x in |( * , 7)| ){
	// x is < 7
}

if ( x in |[ 3, * )| ){
	// x is >= 3
}

if ( x in |[]| ){
	// always false. |[]| is the empty interval
}

if ( x in |( *, * )| ){
	// always true. |( *, * )| means all values possible.
}

~~~~

## Modern

Funcional programming support to some extend : Support for lambda expressions and types like Function<A,B>. 


Modules : ability to compile meta information in "module bundle" (think .jar or .dll) and their respective dependencies. This would allow for the runtime to determine the modules that are needed for a given module to run.

# Some features under consideration

Closures : are like lambdas but can capture and modify values in the calling scope. Very usefully we try to allow the user to implement its on control directives.

Constructors are like factory methods : A class is a factory and constructors really construct the object (not only initialize it). 
All calls to create new objects are calls to factory methods present in an object thus enforcing the *static factory method* design pattern out-of the box. 