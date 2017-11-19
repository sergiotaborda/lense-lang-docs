title=Casting
date=2017-11-19
type=post
tags=casting, lense
status=published
~~~~~~

# Casting

Lense does not support an explicit cast operator like C or Java , it supports flow sensitive casting instead. This means the compiler can use flow directives like ``if`` or ``switch`` to understand the type of the variable.

~~~~brush: lense 
val x : Any =  1; // x hold a Natural

if ( x is Natural){
   
   x = x * 2; // the * operation is available for naturals.
} 
~~~~
The ``is`` operator returns ``true`` if the variable holds an object of the specified type. The compiler then knows that all references to x inside the ``if``  refer to a ``Natural`` so the multiplication operation is allowed.

Being the scens the compiler will introduce a plataforma specific cast to another variable operate on the variable has if it was a Natural.

Flow sensitive typing simplifies writing of  the common *check and cast* idiom.

You can also use other flow directives like ``switch`` :


~~~~brush: lense 
switch (x) {

	case is Natural { 
		return x * 2;
	}
	case is String {
		return new Natural.parse(x) * 2;
	}
}
~~~~

and ``assert``:

~~~~brush: lense 
...  // some other code 

assert( x is Natural);

x = x * 2; // at this line the compiler kowns x is Natural because otherwise and exception would have been thrown.

~~~~


