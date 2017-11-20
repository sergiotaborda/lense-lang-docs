title=Home
date=2015-12-12
type=post
tags=tour, lense
status=published
~~~~~~
# Lense

Lense is a strong typed, pure object oriented programming language that tries to be carefully crafted by meticulous observation and analysis of language design state-of-the-art and comparison with other language design decisions (and mistakes, yes). Even with this analysis and comparation with the state-of-the-art, Lense does not aim to be an academic driven language even when it tries to follow a more scientific and logic approach to design decision making.

Lense goal is to be a simple language, easy to read and write that could be compiled to any object oriented platform. The first effort will focus on running Lense in the Java Virtual Machine (JVM). Other possible platforms are Javascript and CRL (.NET)

# Basic Syntax
Lense syntax starts fom a C familly based syntax ( methods delimited with *{* and *}* ) but moves the type declaration to the end. This is because types can be infered when not declared.

~~~~brush: lense 
val n = 4; // infers type of n value t be Natural
val r = 5.6; // infers type of r value to be Rational

var i : Integer = 3; // read 3 as Natural , then promotes it to Integer;
var negative = -3; // read 3 as Natural then applies symetric operator ``-`` returning an Integer
val a : Rational = 10; // reads 10 as Natural, then promotes it to Rational

val half = 1/ 2; // dividing any Whole number by another Whole number results in a Rational

var x = n + r; // infers type of variable x to be a Rational
var y = i + r; // infers type of variable y to be a Rational
var z = i + n; // infers type of variable z to be a Integer

val name = "John"; //infers type of value name to be a String
~~~~

Variables and expressions can be easy inserted within a string using a simple syntax (see [string](strings.html)).

~~~~brush: lense 
val age = 34;
var name = "John";

console.print("{{ name }} is {{ age }} year old");
~~~~

Prints:

~~~~console
John is 34 years old
~~~~

# Object Oriented
All types are treated as objects in the heap. Some [fundamental types](glossary.html#fundamentalType) receive special handling from the compiler in the form of literals or specific operators. The compiler is free to optimize them to the plataform's primitives as it sees fit (see [erasure](erasure.html)).

Because everything is an object all variables must have been initialized at some point and cannot hold *null*. The concept of "absent value" is support by introducing the [Maybe monad](monads.html) (see [nullability](nullability.html)).  

Generics are reified and the type information of the generic type parameters can be inspected at runtime. This is really works well with [factory constructors](constructors.html#factory)

Types can have generic parameters and these parameters can declare their intended variance on site. 

~~~~brush: lense
public interface Sequence<out T> { ... }

public interface Validator<in T> { ... }
~~~~

No *statics*. All things are objects or exist within an object. Lense supports singleton object definition.

# Math friendly

Operators symbols are predefined and associated with specific interfaces so classes like numbers and strings can use operators.However defining you own operator symbol is not allowed in order to maintain the code simple to read and avoid symbolic noise. The use of interfaces to define operations follows an algebraic structure paradigm so the compiler can reason about the operations (example : altering the order of operations to enhance performance if the operation is commutative)

Suport to Rational, Imaginary and Complex numbers. It is important for Lense that all these numeric types are supported even if the performance is not optimal. Peformance is a problem for the runtime , not the language. In Lense expression of intention is more important that performance.

~~~~brush: lense 
var n : Natural = 3; // numbers are naturals by default. naturals are non negative
var d : Integer = -2; // integer holds negative whole numbers 

var r : Rational = -1.5; // decimal literals are rational numbers by default.

if (r == n/d ){
	// this will be true, because whole division always produces a Rational
	// and numbers are compared by value independently of type.
}

val img : Imaginary = 4i;
val complex = n + img;

if (complex == 3 + 4i){
	// this will be true because n==3 and img ==4i
	// and numbers are compared by value independently of type.
}

// you can use the power operator even to take roots
val distance = (x^^2 + y^^2) ^^ 1/2;  

~~~~

Lense also supports [Intervals and Ranges](interval.html). 

~~~~brush: lense 
for ( x in 3..7 ){ // iterate a range
	// iterate from 3 to 7
}

if ( x in |[ 3 , 7)| ){
	// test if x is >=3 and < 7
}
~~~~

# Modern

## Modular
Lense if Modular. You compile code and meta information into a "module bundle" (think .jar or .dll) with information about their respective dependencies. This  allows for the runtime to determine the modules that are needed for a given module to run.

~~~~brush: lense 
module com.my.application 1.2.0 {

	requires other.some.library 1.0.0;
	required other.some.new.liberary 1.3.5;
}
~~~~

## Functional
Lense supports funcional programming with monads and lambdas:

~~~~brush: lense 
var evenNumbers = Sequence.iterate(0, i -> i++).map( i -> i*2); 
~~~~

## Innovative

Constructors act like factory methods. A class is a factory and constructors really construct the object (not only initialize it). 
All calls to create new objects are calls to factory methods present in an object thus enforcing the *static factory method* design pattern out-of the box. 

Meta classes allow to program methods that apply to classes instead of instances, like operators.

Enhancements allow you to add methods in classes that originally did not support them.