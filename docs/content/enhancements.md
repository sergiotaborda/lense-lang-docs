title=Enhancements
date=2015-12-14
type=post
tags=tour, lense
status=published
~~~~~~

# Enhancements

Normally we extend a class by means of inheritance. Inheritance may not be a good solution in some cases.
Sometimes we need to extends the funcionally of a class without adding to the inheritance tree, e.g. when the class we are trying to extend is final. 
The standard pattern to do this is via a Decorator. A decorator holds a value of the original class and adds methods to it. 
Both class can share the same interface but normally that does not happen.  

Decorator is a solution for the problem and can be implemented in any object oriented language, however is not very practical.

Other languages like C# and Gosu, enable the use of Extention Methods. Extention Methods are static methods declared 
in a special way so they can be called as normal methods (after a dot). Being static methods this methods can also be 
called normally using the static method calling syntax. 

~~~~brush:csharp
String greating = "ho".repeat(4); // Repeat is not a standard method of type String
assert("hohohoho" == greating);
~~~~

Lense does not have static elements, so extention method must be declared on an object and we apply the methods of that
object to the original instance of the class we want to enhance. 

~~~~brush: lense
public enhancement RepeatableString extends String {

	public repeat(count : Natural): String {
		var result = "";
		for ( val i in 1..count){
			result+= this; // this referes to the enhanced object
		}
		return result;
	}
}

~~~~

When enhancing a given type we are in fact enhancing all subtypes as well so polimorfism is at work. More generaly we
can enhance types that conform to some generic rules and thus generics support is needed for enhancement.

~~~~brush: lense
public enhancement MeasureableInterval extends Interval<Natural> {

	public length : Natural? {
		get {
		   return this.start.zip ( this.end , (start, end) ->  end - start);
		}
	}
}

// normally intervals have no length because they are not iterable

val stringInterval = |[ 'a' , 'z' ]|;
val length = stringInterval.length; // will fail at compile time

// but we can have a lenght if we have a closed interval of Naturals

val naturalInterval = |[ 4 , 10 ]|;
val length = naturalInterval.length; // ok, because we have an enhancement.

assert( 6 == length);
~~~~

The difference between enhancements and extention methods is that we can add more that just normal methods. We can also
add constructors and calculated properties. The only restriction is that no state can be added.

The difference between enhancements and traits it that traits are an inheritance base mechanism where we mix the code of the original type with that of the trait

When compiling to the underlying platform the lense compiler does not really create an object so the methods can be called, the compiler is free to optmize the calls using static semantics if they are possible in the platform. 

Enhancement implementations can only access public members of the enhanced type.

Interfaces cannot be fullfiled by adding enhancement methods.