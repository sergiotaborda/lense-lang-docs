title=Tour
date=2016-02-01
type=post
tags=tour, lense
status=published
~~~~~~

This a simple tour of the language. At [this stage](../status.html) some feature are not decided upon, so sintax may change and features may be added or removed.
Features that may change are marked as *Under Consideration*.


# Guideline Principles

Lense is base in some principles. These principles are used as guidelines during the language's design :

+ 	One Language , Many runtimes: Lense aims to be a universal language in the sense it can be executed on several different target runtime platforms that behave like the same logic platform. 
But this mean the plataform limits the possibilites. For example, a file system is not available for the JavaScript platform targeting browsers, since browser have no native access to file systems, but is available in the Javscript plataform running on servers. On the other hand only a web application targeting JavaScript on a browser can call a DOM API and receive events and such.
Lense resolves this using modules. Some modules will only be available in some target plataforms.
For more on target platforms read the [plataforms guide](../platforms.html)

+	Everything is an object : Everything you can place in a variable is an object, and every object is an instance of a class. 
Even numbers and functions are objects. All classes inherit from the ``Any`` class and [there are no *nulls*](../nullability.html)
There is no explicit static scope. Hence, there is no ``static`` keyword. All members are objects that belong to objects. However, the ``object`` declaration allows to the definition of singleton objects that exist in a *static-like* context. You refer to these objects by their names as the name are unique. 

+	Modular : Modules, and not classes, are the units of deployment. All code compiled in Lense will produce a Module.
Modules can be organized in packages. Classes live in packages. Modules are compiled depending on the target platform. The same module source code can produce several module archives, one for deployment in each platform. (Under revision)

+	Strong Type System : Lense is strong typed and supports type inference, type variance and reification. Specifying types in code allows the compiler, and other tools, to reason about your intent and infer some things.However, more often than not, the compiler will infer the types and you will not have to specify them.	
	
+	Easy to Read : When you look at a code you wrote 1 year before is hard to remember what the code does, less alone 10 years before. Code must be simple to read. [Identifiers](../identifiers.html) must start with a letter,  followed by any combination of characters and digits. No special symbols allowed.

+ 	Easy to Write : Writing must be fluent an coerent a keep to the minimum information necessary. Easy to write does not mean shorter words, or the heavy use of acronyms. It means reduction of boiler plate. Each word types is meaningfull and necessary. 

+	Expression of intension is more important that performance. Lense introduces many concepts that may not be easy to implement from a performance point of view, like Complex numbers for example. Lense conception cannot be limited by the performance restrictions because those are manly a runtime problem, and since we are trying to run the same abstractions on different environments is not possible to performatic on all of them. So abstraction and expression of intension comes first. Performance is a problem of the runtime implementation.

# A basic Lense program (Under consideration)

The most basic program is a console interaction program. The famous *Hello, word!* in Lense would look like this:

~~~~brush: lense 
public object MyApplication extends ConsoleApplication {

	public run (){
		val name : String = this.arguments[0];
		
		this.console.println("Hello, {{ name }}!");
	}
}
~~~~

The program's entry point is an ``Application`` object. In this case a ``ConsoleApplication``. Lense does not support static members like other languages because everything is an object.
However is supports the singleton pattern out of the box. By using an ``object`` declaration you define an object of type, in this case, ``ConsoleApplication`` that has a ``run()`` method.
The ``run`` method is the program's entry point.

A program must be package into a module to be runnable. Lense supports modules out of the box:

~~~~brush: lense 
module MyApplicationModule (1.0.0) {

	imports lense.core 1.0.0;
}
~~~~

There must always exist a module in you application (you application *is* a module).
A module can be executable if it contains an ``Application`` object. If it does not contain an ``Application`` oject it's library module to be used by other modules.
A module can not contain more than one ``Application`` object.

Each module must have a name and a version. In this case the name is *MyApplicationModule* and the version is *1.0.0*. Lense understands version literals, no need to wrap the version in a string.
If you need access to passed arguments you can read them from the ``arguments`` property in ``Application``.
This property holds a ``Sequence<String>`` with the parameters given in the command line. If no arguments were passed or the application is running in an environment 
without access to arguments (like a web browser) the sequence is empty.

## Numbers

Numbers are separated in specific algebraic structures that conform to their mathematical rules.
All numbers are descendent types of the ``Number`` class. Operations are defined for each type independently.
Lense supports Natural, Integer, Real,  Complex and Imaginary numbers. A byte is not a number in Lense, its a ``Binary`` object. 

Natural is used as an indexer for sequences. It is non-negative and has big as you need. Limits for the size of collections like arrays, lists and maps are only bound by their implementation. Using a Natural to index sequences removes the necessity to check for negative indexes and as Arrays always have a upper limit and always are constructed by [factory like constructors](constructors.html)
the implementation for each platform can accommodate different implementations according to maximum length demand.
For more information on how ``Natural`` relates to index of sequences, see how [Arrays](arrays.html) work in Lense.

Arithmetic operations are defined by [Operator Interfaces](operators.html) so you can implement you own versions of the common operators.

For more detail on number visit the dedicated [numbers](numbers.html) page

## Strings

A string in Lense is a Sequence of Character. Characters are UTF-16 code points. A string literal is just a text enclosed in double quotes.

~~~~brush: lense
val greating : String = "Hello, world";
~~~~

You can interpolate values inside literal strings using ``{{`` and ``}}`` as delimiters.

~~~~brush: lense
val  name : String= "Alice";
val  greating : String = "Hello, {{ name }}";
~~~~

You can concatenate strings using the ``+`` operator.

~~~~brush: lense
val name : String = "Alice";
val greating : String = "Hello, " + name;
~~~~

String are mulit-line, so you can simply right

~~~~brush: lense
val greating : String = "Hello, 
	wold";
~~~~

The line break , tab and spaces in the second line will be preserved.

If you need to use a Unicode a special character enclosing an hexadecimal natural value with ``\{`` and ``}`` delimiters.

~~~~brush: lense
val definePi : String = "The value of \{#03C0} is the ratio between the circumference and the diameter of a circle"
~~~~



# Collections

Lense offers a rich API to handle collections. All collections in Lense are [monads](../monads.html).
All collections inherit from the ``Assortment`` class and are read-only and immutable by design. Mutable implementations exist.

## Sequence

Sequences are assortments that let you assign a ``Natural`` index to each element. The elements can be iterated in the order of their indexes.
Sequences are immutable and read-only. Sequences are fundamental in Lense and not arrays as in other languages (like Java).
Lense provides a very familiar syntax for sequences:

~~~~brush: lense
val cities : Sequence<String>  = ["New York", "London", "Paris"];

val london = cities[1]; // access by a Natural index
~~~~

### Arrays

In Lense an ``Array``in an implementation of ``EditableSequence``s. This means you can chance the values in each position of the sequence but you cannot change the sequence's size.
Arrays in Lense are fixed in size. To add a new element to the array you need to create a new array. Also keep in mind arrays in Lense are objects of the ``Array<T>`` class and not primitive types like in Java.

~~~~brush: lense
val cities : Array<String> = ["New York", "London", "Paris"];

val london = cities[1]; // access by a natural index

cities[1] = "São Paulo"; // position 1 now refers to "São Paulo" and not to "London" any more.
~~~~

Because of Lense's [conversion constructors](../constructors.html) you can initialize an Array with a Sequence literal.

### Lists

``List`` is an implementation of  ``ResizeableSequence`` that is both editable (like Arrays) and resizeable. This means you can add and remove elements from a list after the list is created.
``List`` implementation is equivalent to ``ArrayList`` in Java.
 
~~~~brush: lense
val cities : List<String> = ["New York", "London", "Paris"];

cities.remove(1); // removes element at index 1, "London" in this example
cities.add("São Paulo"); // add a new element at end of the list
~~~~

### Range 

Lense supports Ranges. A Range is a special sequence of elements that has a *start* and an *end* and knows how to iterate elements from the start to the end.
A Range is normally created from a Rangeable. A Rangeable defines an ``upTo`` method that returns a Range.

~~~~brush: lense
val  range Range<Natural> = 1.upTo(9);
~~~~

This constructs a Range from 1 inclusive to 9 inclusive. Lense also supports an operator called ``..`` that you can use instead of ``upTo``.

~~~~brush: lense
val range Range<Natural>  = 1..9;
~~~~

This is usefull in interations

~~~~brush: lense
for (Natural n in 1..9){
  // do something
}
~~~~

## Association

Associations are like sequences, but instead of attributing a Natural index to each element, you can attribute an object to each element. This object act like a key to later retrive the stored object. Lense also provides a familiar literal for Associations. Associations, like sequences, are imutable.

~~~~brush: lense
val personsAndJobs : Association<String, String>  = { "Alice": "CEO", "Bob":"CIO" , "Claude":"CFO" };
~~~~

Like Sequences, Associations are immutable and read-only.

### Dictionary 

``Dictionary`` is an implementation of ``EditableAssociation`` that allows for the edition of the values associated with keys, but does not allow the modification of the keys.

~~~~brush: lense
val personsAndJobs  Dictionary<String, String> = { "Alice": "CEO", "Bob":"CIO" , "Claude":"CFO" };

personsAndJobs.replace("Alice", "CTO"); // replaces the value pointed by the 
~~~~

### Maps 

``Map`` is an implementation of ``ResizableAssociation`` that you can use to manipulate editable and resizeable associations.  In Lense, Map implementation is similar to that of HashMap in Java.

~~~~brush: lense
val personsAndJobs  Map<String, String> = { "Alice": "CEO", "Bob":"CIO" , "Claude":"CFO" };

personsAndJobs.removeKey("Alice"); // removes the key and its value.
~~~~

## Tuples

Tuples are special assortments. They are like sequences of objects in the sense each element has an index. The difference is that each element can be of a different type with no relation to the other elements (has in a sequence all elements are off the same class or inherit from it).

~~~~brush: lense
val  personsAndJobs : (String, Natural , Boolean) = ("Alice", 42 , true);
~~~~

Lense provides the abose short sintax to create tuple's types and values. the compiler will translate that notation to the following notation that you can also use.

~~~~brush: lense
val personsAndJobs : Tuple<String, Tuple<Natural , Tuple<Boolean, Nothing>>>  = ("Alice", 42 , true);
~~~~

If you are interested, you can read [more on container literals](../containerLiterals.html). 

Lense understands that a variable of type X can be considered a variable of type 1-tuple of X, so 1-tuples can be assigned to variables directly and vice-versa:

~~~~brush: lense
val tuple1 : (String)  = ("Alice"); // commom pattern
val tuple1 : (String)  = "Alice"; // also valid
val name : String  = "Alice"; // commom pattern
val name : String  = ("Alice"); // also valid
val name : String  = tuple1; //  also valid
~~~~

# Functions

Functions allow for algorithms to be  encapsulated. Normally these algorithms depend on parameters that the function declares explicitly and return a value.
  
~~~~brush: lense
	 public doSomething() : Void { 
	 	Console.print("Did something");
	 }
	 
	  square ( x : Natural) : Natural { 
		return x*x; 
	 }
~~~~

Functions always return a value. ``Void`` is not a keyword, is an actual type. ``Void`` only has one instance denoted ``()`` (the empty tuple). All functions have an implicit return of the instance of ``Void`` at the end. This is correct unless the method return another type. 
You can explicitly write a return of the instance of ``Void``.

~~~~brush: lense
	 public doSomething() : Void  { 
	 	Console.print("Did something");
	 	return; // implicitly returns the instance of Void.
	 };
~~~~

~~~~brush: lense
	 public  doSomething() : Void { 
	 	Console.print("Did something");
	 	return (); // explicit returns the instance of Void.
	 };
~~~~

Functions are objects of type *Function*. There is a type for each number of parameters. So ``Function<R>`` is for a function with no parameters that returns a type ``R``. ``Function<R,T>`` if for a single parameter function.
``Function<R,T,U>`` is for a function of two parameters, and do on ...

~~~~brush: lense
	 val f : Function<Int, Int> = x -> x*x; 
	 val g : Function<Int, Int, Int>= (x,y) -> x*y;
	 
	 Console.println(f(3));  
	 Console.println(g(3,2));
~~~~

Prints

~~~~console
9
6
~~~~

When functions are defined in the context of a class we talk about methods. Methods are functions bound to an instance of a class.
Method can make calls to the ``this`` variable that implicitly represent the instance the function is bonded to.

## Transforming Methods into Functions (Under Consideration)

Using reflection, methods can be converter to functions that can be invoked if the instance object is passed explicitly 

~~~~brush: lense
	val  one : Integer= 1;

    val  minusOne: Integer = one.negative();

    // extract the underlying function
    val negativeOf : Function<Number,Number>  = one::negative(); // f has a parameter of type Number representing the bounded value of *negative*.

    val  alsoMinusOne : Integer = negativeOf(one);
	val  minusTwo : Integer = negativeOf(2);
~~~~

Note the use of the `::` operator to detach members from object instances. 
You can do the same using the class instead of the instance.

~~~~brush: lense
    // extract the underlying function
    val negativeOf : Function<Number,Number> = Integer::negative(); // f has a parameter of type Number representing the bounded value of *negative*.

    val alsoMinusOne : Integer = negativeOf(one);
	val minusTwo : Integer = negativeOf(2);
~~~~

# Operators

Lense does not support operator overloading but lets you use operators like ``+`` and ``*`` in your own classes. Each operator is defined in a interface.
For example , for the ``+`` operator is the ``Summable<A,D,S>`` interface. These special interfaces are called *Operator Interfaces* in the documentation.

Note that this interfaces do not define the result or the parameters must be of the same type. They as generic as you can get.

Another family of interfaces define algebraic structures. These structures enforce other rules (like the types all be the same) and provide properties for the underlying type.
Algebraic structures help model some more abstract algebra concepts like *Magma*, *Group* , *Ring*  or *Field*. 

The different algebraic structures are the reason not all number types have the same operations. Integer, for example, do not have division, and so cannot for a *Field*.

# Control Flow Statements

Lense control flow is pretty much what you would expect and are a costumed to see in other languages.

## if-then-else

The *if-then-else* decision statement is pretty much the same as in Java , C# and other languages.

~~~~brush: lense
if (condition){
   // do somthing
} else if (otherCondition){
   // do this other thing
} else {
   // do something else.
}
~~~~

The ``if`` clause demands a Boolean condition to be evaluated. The condition must be of type boolean. Any other type will throw a compilation error.
You can chain and nest *if-then-else* as much as you like.

## while-do 

The *while-do* repetition structure is also pretty much the same as in Java , C# and other languages.

~~~~brush: lense
while (condition){
	// repeat this if condition is true
}
~~~~

## for-each

A very common task in object oriented programming is iterating over a collection of elements. Lense provides the *for-each* structure to help in this very common task.

~~~~brush: lense
for (val element in collection){
	// repeat this code for each element 
}
~~~~

You can use *for-each* with any object that implements the ``Iterable`` interface.
You can use type of the variable instead of var. If you use ``var`` the type will be infered from the collection signature.

~~~~brush: lense
for (String element in collection){
	// repeat this code for each element 
}
~~~~

Lense does not have the traditional increment base *for* like it exist in Java or C#.

~~~~brush: java
// java and others
for (int i = 1; i <= 9  ; i++){  // this exists in Java and C#, not in Lense
	// repeat for each i
}
~~~~

Instead you can use a Progression.
 
~~~~brush: lense
for (var i in 1..9){
	// repeat for each i
}
~~~~


# Exceptions

Lense supports throwing Exceptions. An Exception is a special object. When an Exception is thrown the execution of the code stops and the method returns.
You can that catch the exception with a *try-catch-finally* statement.

~~~~brush: lense
try {
  // do something that can throw an exception
  throw new ArithmenticException();
} catch (ArithmenticException e) {
  // do something is the exception occurred
} finally {
  // do something either if the exception occurred or not.
}
~~~~

Lense does not support checked exception like Java does. 

# Classes

Lense supports classes and class inheritance to define objects and relations betweeen them. 
Lense also supports interfaces, object delcarations and traits (under consideration).

All Lense types suport fields, properties , methods and constructors as members. 
Lense also supports overloading of methods and genric types.

More on types on the [types page](objects.html).

# Generics

Lense supports reified generics with variance control. 

~~~~brush: lense
public interface Sequence<out T> { }

public interface Validator<in T> { }

public interface List<T> { }
~~~~

Lense support co-variant types (out), contra-variant types (in) and invariant types (default) 

# Modules and visibility (Under Consideration)

Lense supports modules. Every application or library is packaged as a module. A modulue is similar to a jar file in java or a dll in .Net,
but contains a little more structure.

Modules can import types from other modules and can export they own types to other modules to use.

Visibility modifies like ``private``, ``public`` and ``protected`` have the same semantics an in java or C#, however there is no *default* level like in java. 
If visibility is not explicit , ``private`` is used. 

A litte diference is that a type being maked as ``public`` adicionaly means that any other module can used it and are exported by default. If you do not want to export a classe use the ``internal`` visibility modifier.

# Parallelism and Concurrency (Under Consideration)

Lense does not support creating an control of threads directly nor support the commom memory model.
Instead Lense provides an actor based API to handle concurrency and parallelism. Parallelism is also ofered by special APIs lik Parallelism is supported by APIs like ``Iterable.asParallel()``. 

# Reflection (Under Consideration)

Lense offer a reflection API based on the ``Type`` class. 

~~~~brush: lense
   val stringType : Type = typeOf(String);
   val alsoStringType : Type = "some String".getType(); 

   Console.println("String has {{ stringType.Methods.size }} methods");
~~~~

# Comments

Lense supports inline comments with ``//`` and multi-line comments with ``/{`` and ``}/``

~~~~brush: lense
/{
    this is a multi-line comment

     /{
       Multi-line comments can be nested
     }/
}/
public class Client {

     // the following line uses a single line comment to inform the role of the field
      val  name : Natural; // the name of the client       
}
~~~~

As in other languages comments should be avoid by renaming your types and members with better names, but some times
you will need them to explain some complex algorithm.