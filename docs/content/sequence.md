title=Sequence
date=2017-04-18
type=post
tags=sequence, collections, lense
status=published
~~~~~~

## Sequences

Lense supports the concept of `Sequence`. A `Sequence<T>` is an ordered `Iterable<T>` of elements of some type `T`. `Sequence`s are imutable. 

In other languages the array is the primitive of choice for aggregating multiple values. However, is not imutable. There is not an imutable aggregation primitive in these languages.   
In Lense, you can use a `Sequence` most of the time, and arrays only when you are interested in modifying the contents. You can create arrays from sequences like so:

~~~~brush: lense
val sequence : Sequence<Natural>   = [1, 2, 3];
val array : Array<Natural>  = [1, 2, 3];
~~~~

The first line creates a sequence of elements 1, 2 and 3. The second line creates an array of the elements 1, 2 and 3 by first creating a sequence and them promoting it to an `Array` by calling its [conversion constructor](constructors.html#conversion). In practice the compiler is free to optimize these literal constructions and not really call the conversion constructor on `Array<T>`.

Lense uses common brackets to represent ``Sequence`` literals. Keep in mind arrays are not fundamental types in Lense, sequences are. An array is a special (mutable) sub type of sequence.

### Concatenation 

`Sequence`s are imutable , but you can create new sequences by concatenating other sequences.

~~~~brush: lense
val even  = [2, 4, 6];
val odd = [1, 3, 5];

val all = even ++ odd;

assert([2,4,6,1,3,5] == all);

var doubleFive = all ++ 5;

assert([2,4,6,1,3,5,5] == doubleFive);
~~~~

The `++` is the concatenation operator. 

### Sub Sequence

You can obtain sequences that are views of an original sequence by using the range indexer property:

~~~~brush: lense
val sequence  = [1, 2, 3, 4, 5, 6, 7, 8];
val subsequence = sequence[3..5];

assert([4,5,6] == subsequence);
~~~~

### Mapping and Filtering

`Sequence`s are `Iterable`s so you can use mapping and filtering options

~~~~brush: lense
val evenSquares  = [1, 2, 3, 4, 5, 6, 7, 8].filter(i -> i.isEven).map( i -> i ** 2 );
~~~~

### Strings are Sequences

`String`s are `Sequences<Character>` so operations on strings are basicly the same you can do over sequences. See [`String`](strings.html) for more details.
