title=Tuples
date=2017-04-20
type=post
tags=tuple, lense
status=published
~~~~~~

## Tuples

Tuples are similar to [sequences](sequence.html), but each index has its own type. Tuples are fundamental types in Lense.
Structurally a Tuple is a node in a linked-list kind of structure. But `Tuple`s are not `Sequence`s, eventhought they are `Iterable<Any>`
The literal syntax is similar to `Sequence`s, but with parentesis instead of brakets.

~~~~brush: lense
var tuple : (Natural , String , Boolean) = ( 1 , "a" , true );
~~~~

This creates a tuple of 3 elements where the first is a `Natural`, the second a `String` and the third a `Boolean`.
You can also observe that the type of the tupe is a tuple of the types. 

The tuple is a fundamental type with a lot of syntax sugar in Lense. That code wil be compiler like so :

~~~~brush: lense
var tuple : Tuple<Natural , Tuple<String, Tuple< Boolean, Nothing >>> = Tuple.of( 1 , Tuple.of("a" , Tuple.of(true)));
~~~~

You can write that, but Lense assumes you don't wish to, so it enables literals for tuple values and types.

### Accessing elements 

To access an element in the tuple you use it like a sequence:

~~~~brush: lense
var tuple  = ( 1 , "a", true);

var number = tuple[0];
var name = tuple[1];
var predicate = tuple[2];
~~~~

Tuples do not have indexers like sequencs do because the type depends on the index, but the compiler can translate that code to:

~~~~brush: lense
var tuple  = Tuple.of( 1 , Tuple.of("a" , Tuple.of(true)));

var number = tuple.head;
var name = tuple.tail.head;
var predicate = tuple.tail.tail.head;
~~~~

### Tuple of 1

These lines are equivalent:

~~~~brush: lense
var tuple : (Natural)  = ( 1 );
var value : Natural  = 1;
~~~~

Lense understans that a single value and a 1-tuple, are the same thing so the compiler enables the translation dynamicaly.

### Void

The `Void` is a special case of a tuple. The 0-tuple. A 0-tuple can only have one element. This element is designated by the `()` literal. 
