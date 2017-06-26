title=Variables and Values
date=2017-06-14
type=post
tags=variables, values, lense
status=published
~~~~~~


# Variables

Creating variables in Lense is very similar to other languages.

~~~~brush: lense
var  name : String = "Alice";
~~~~

Variables always contain references to objects. The variable called *name* contains a reference to a ``String`` object with a value of *Alice*.
The reference contained in a variable can be changed further down in the code to another reference, like :

~~~~brush: lense
var name : String = "Alice";
name = "Beth";
~~~~

Lense as type inference, so variable declaration can be simplified to :

~~~~brush: lense
var  name = "Alice";
~~~~

This is the main reason why type annotations are included after the name of the variable, so they can be removed when are not necessary. 
Notice that they are still relevant in the present of polymorfism like in:

~~~~brush: lense
var  name : Sequence<Character> = "Alice";
~~~~

# Values 

The use of the ``var`` keyword defines a variable (mutable) reference declaration. Immutable references are defined with the ``val`` keyword.

~~~~brush: lense
val name : String = "Alice";
~~~~

Immutable values cannot be changed, so trying to do so is a compilation error.

~~~~brush: lense
val name : String = "Alice";
name = "Beth"; // Compilation Error 
~~~~

# Definition and Initialization

In Lense you can define the value or the variable and initialize the value later, like this:

~~~~brush: lense
val name : String;

name = "Alice";
~~~~

But, because in Lense [there are no nulls](nullability.html), the compiler will track that the variable has been initialized to a proper non null value before it is used. So the following will produce an error:

~~~~brush: lense
val name : String;

val nameSize = name.size; // Compilation error. Variable 'name' has not be initialized yet

name = "Alice";
~~~~



