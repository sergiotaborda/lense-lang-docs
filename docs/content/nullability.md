title=Nullability
date=2016-10-17
type=post
tags=arrays, lense
status=published
~~~~~~

#Nullability

Lense does not allow variable to hold **null**. **null** is used in other languages to indicate the variable has not set. However when trying to dereference the object in the variable (i.e. use the dot operator) an exception is raized. It is easy to overlook the variable may contain null.

Lense take a more object oriente aproach. Every variable refers to an existing object. No **null**s are allowed, hence, no nulls exist.

However the concept of an absent value is very usefull. Some data that is not yet calculated or the user as yet to inform. So Lense support the concept of an absent value using the tradiconal Maybe monad.

~~~~~~brush: lense 
val h : Srring = "Hello"; 
val w : Srring? = none; 
~~~~~~

The first line created a variable of type <code>String</code> with value *"Hello"*. The second line create a possible absent value of a <code>String</code> type and initializes it to *none*. 
Please note that *none* is an object so the variable really refers to an object. No nulls are allowed.

String? is a shorthand notation for [Maybe<String>](monads.html) and *none* is the object of type None.


#Interoperatibility

On Lense world no *null*s exist, but in the underlying platform , like java or .net, they may exist. Any method can return or aceppt null. We can not now if the value returned can be null or not.
Let us take an example in java

~~~~~~brush: java 
string[] names = resolveNames();
List<Address> addresses = resolveAddressesFor(names);
~~~~~~

Has we have no way of knowing if the methods will return null this would be mapped to Lense as:

~~~~~~brush: lense 
var names : Array<String>? = resolveNames();
var addresses : List<Address>? = resolveAddressesFor(names);
~~~~~~

At this point we can test if the collections exist, but how about the elements ? Have we certain no nulls exist inside the array or the list ?
This problem is more general and exists everywhere the objets are boxed in other objects. We then have to be sure and write:

~~~~~~brush: lense 
var names : Array<String?>? = resolveNames();
var addresses : List<Address?>? = resolveAddressesFor(names);
var box : Box<Element?>? = resolveBoxedElements();
~~~~~~

This may prove cumbersome in code that tries to use native APIs.

## Rules of None

For interop code , i.e. everytime the compiler identifies a native method is being called it let's you apply automatic filters according to the type you write. If no type is defined, the full optional type is used.

~~~~~~brush: lense 
var names  = resolveNames();  // same as names : Array<String?>? = resolveNames()
var names : Array<String>? = resolveNames();  // same as  names = new Maybe.of(resolveNames()).map( a -> a.Compact());
var names : Array<String> = resolveNames();  // same as names = new Maybe.of(resolveNames()).map( a -> a.Compact()).or(new Array.empty<string>())
var names : Array<String?> = resolveNames();  // same as names = new Maybe.of(resolveNames()).or(new Array.empty<string>())
~~~~~~

<code>Maybe.of()</code> will understand *null* as equivalent to *node* and wrap the array in a possible absent type. The <code>Compact</code> method will remove *null* and *none*s from the array.
In case the array may not be absent an default empty array is used. These rules applies to all <code>Iterable</code>s.

For other boxed types that are not <code>Iterable</code>s the options are limited. We have to raise a compilation error for the cases the compiler cannot sort.

~~~~~~brush: lense 
var box  = resolveBoxedElements();  // same as box : Box<Element?>? = resolveBoxedElements()
var box : Box<String>? = resolveNames();  // compilation error , cannot verify String is not null.
var box : Box<String> = resolveNames();  // compilation , cannot verify String is not null.
var box : Box<String?> = resolveNames();  // same as box = new Maybe.of(resolveNames()).value; 
~~~~~~

<code>Maybe.value</code> is a valid method call in Lense that will raise an <code>ValueAbsentException</code> if no value is present. 

In Java 8, and above, types can be annotated with ``@NotNull`` or ``@Nullable``. These type annotations can made it possible to the compiler to determine if its possible to the value to be absent or not.
When the compiler can determine it is safe the more restrict types will be allowed and no compilation errors would be raised. However, at this point in time, most APIs do not use these annotations.

Even them, the problem will persist for interop with other platforms.

