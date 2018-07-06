title=Iterable
date=2016-02-03
type=post
tags=tour, lense
status=published
~~~~~~

#Iterable

Iterable is a [monad](monads.html) that allows for the iteration of elements by means of an ``Iterator``. All ``Sequence``s , ``Association``s , ``Tuple``s and ``Range``s are ``Iterable``s.
Iteration can be implicit or explicit.

## Explicit Iteration
You can explicitly iterate over the elements of any ``Iterable<T>`` with the *for-each* directive

~~~~brush: lense 
val cities : Sequence<String> = ["New York", "London", "Paris"];
val lengths : List<Natural> = new List<Natural>();

for (String city in cities){
	lengths.add(city.size());
}
~~~~

The *for-each* directive can be used on any type that implements ``Iterable``. The compiler will transform this code to the use of an ``Iterator``. Something like:

~~~~brush: lense 
val cities : Sequence<String> = ["New York", "London", "Paris"];
val lengths : List<Natural> = new List<Natural>();

Iterator<Natural> it = cities.iterator();
while (it.moveNext()){
    String city = it.current;
	lengths.add(city.size());
}
~~~~

You can see from this example that Lense ``Iterator``s are not like Java iterators.

## Implicit Iteration
Because all Iterables are monads , they have a ``map`` method that receives a lambda to operate over all elements. 

~~~~brush: lense 
val cities : Sequence<String> = ["New York", "London", "Paris"];
val lengths : Sequence<Natural>  =  cities.map( city -> city.size());
~~~~

This code simply applies a transformation to all elements of the original container (*cities*) and produces a new *Sequence<Natural>* with the lenghts of the cities names. 
The main diference from explicit iteration is that explicit iteration normally involves some kind of mutable object , like ``List`` in this example, while implicit iteration does not.

You can use several other methods like ``filter`` that allows you to exclude some values. 
For example, if we want to calculate the cubes of only odd numbers between 1 and 100 we can use a ``Range`` and write:

~~~~brush: lense 
var cubes : Sequence<Natural> = 1..100.filter(n -> n.isOdd()).map( n -> n ** 3));
~~~~

This a very simple, readable, code that means the same that: 

~~~~brush: lense 
val  cubes = new List<Natural>();

for (Natural n in 1..100) {
	if (n.isOdd()) {
		lengths.add(n ** 3);
	}
}
~~~~

But does not use mutable objects.
