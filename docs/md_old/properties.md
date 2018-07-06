title=Properties
date=2016-04-26
type=post
tags=tour, lense
status=published
~~~~~~

# Fields and Properties

In other languages you can have fields to store state and methods to manipulate state, or (like in C# and Scala) you can have properties.
Properties store state like fields but have two associated methods called Accessor and Modifier. The accessor is the method called to obtain (get) the value of the property. The Modifier is the methods called to change (set) the value of the property. 

From the design point of view, fields represent state and properties represent the access to that state with the added value of intercepting the state read and write operations or eventually calculating the state on the fly from other properties. Because of this, fields are not supposed to be public because it will break encapsulation (how to store state should be a private choice). On the other hand, properties never need to be private because if they are they, the object is using encapsulation to protect it from it self. 

So, Lense does only have properties. The compiler will produce backing fields, accessor and modifier methods that read and write from/to the backing field. Backing fields are not accessible by other class members.

In Lense all properties are required to be initialized except for optional properties that are initialized automatic to ``none``.

~~~~brush: lense
public class Person {

	public gender : Gender = male; // initialize to a default value
	public name : String?; 
	public surname : String?; 
	
}
~~~~

Since the accessor and modifier will be added by the compiler when not explicitly defined, this code is equivalent to:

~~~~brush: lense
public class Person {

	public gender : Gender = male {get;set;}; 
	public name : String? = none {get;set;} ; 
	public surname : String? = none {get;set;} ; 
	
}
~~~~

There is a serious reduction in boilerplate for the most common case.


## Read-Only and Calculated Properties

When a property is read-only it's value is obtained from other properties via some function.

~~~~brush: lense
public class Person {

	public name : String?;
	
	public surname : String?;
	
	public fullname : String? {
		get {
			return name.zip(surname, (n , s ) -> "{{n }} {{s}}");
		}
	}
}
~~~~

Because the modifier is not explicitly defined, but the accessor is, the compiler will understand this is a read-only property.
This syntax can be verbose at times, so you a use the shorter version:

~~~~brush: lense
public class Person {

	public name : String?; 
	
	public surname : String?;
	
	public fullname : String? => name.zip(surname, (n , s ) -> "{{n }} {{s}}");
}
~~~~

## Write-Only and Intercepting Modifications

You can use the full syntax when you need to code the accessor and the modifier. If you code the modifier explicitly you must explicitly declare the accessor, otherwise the compiler will assume it is a write-only property.

~~~~brush: lense
public class Person {

	public name : String?; 
	
	public surname : String?; 
	
	public fullname : String? => name.zip(surname, (n , s ) -> "{{n }} {{s}}");
	
	public birthday : Date? {
		get {}
		set(value){ // (a)
			if (value != none && value > Date.today){
				throw new IllegalArgumentException("A Person birthday cannot be in the future");
			}
			
			this.birthday = value; // (c)
		}
	}
}
~~~~

This code is quite interesting. We define the accessor and the modifier explicitly. The modifier receives a parameter _(a)_ with the new value. You can call the parameter whatever you like and the type of the parameter is implicitly the same has that of the property. Then we make a simple validation and throw an exception if there is a problem. In this case, the `value` parameter is a optional type, so we use Lense's type flow sensitivity to unbox the value and compare it to today's date _(b)_. If all is well we assign the value the property _(c)_.

Note than assigning a value to the property inside the modifier simply assigns it the the backing field directly, since otherwise it would cause a infinite recursion of calls to the modifier.  This is why, in Lense, there is not special syntax to access or modify the backing field (since no other meaning terminates).

## Properties Constructor

If the properties are mandatory is better to required then in the constructor:

~~~~brush: lense
public class Person {

	public constructor( name : String,  surname : String,  birthday : Date){
		this.name = name;
		this.surname = surname;
		this.birthday = birthday; 
	}
	
	public name : String;
	
	public surname : String;
	
	public fullname : String => "{{n }} {{s}}";
	
	public birthday : Date {
		get {}
		set(value){ // (a)
			if (value > Date.Today){
				throw new IllegalArgumentException("A Person birthday cannot be in the future");
			}
			
			this.birthday = value; // (b)
		}
	}
	
}
~~~~

Now we don't need the optional types and we do not need to initialize the properties with dummy values. 
If you don't like this boilerplate code , we can always use the [primary constructor](constructors.html#primary):


~~~~brush: lense
public class Person {

	public constructor( public var name : String, public var surname : String, public var birthday : Date);
	
	public fullname : String => "{{n }} {{s}}";
	
	public birthday : Date {
		get {}
		set(value){ // (a)
			if (value > Date.Today){
				throw new IllegalArgumentException("A Person birthday cannot be in the future");
			}
			
			this.birthday = value; // (b)
		}
	}
	
	
}
~~~~

This will create the same properties as before with eventually the same code.

## Different visibility

Sometimes you need to have a public accessor but a private modifier, or vice-versa. In that case you can use visibility modifiers to declare different visibilities

~~~~brush: lense
public class Person {

	public name : String? { public get; private set;}
	public surname : String? { get; private set;}
}
~~~~

If you omit the modifier near the accessor or modifier declarations the standard visibility of the property will be used.
The accessor and modifier  visibility cannot be less restrictive than that of the property. Having a ``public get`` for a ``private`` property makes no sense. 

## Interoperability 

Some issues regarding how properties are translated to the native platform's concepts.
  
### Explicit Accessor and Modifier 

Each platform supports the concept of Property in a different way. The Lense back-end compiler will use the platform's strategy of choice. In the JVM , for example, for property `xyz` is translated to a backing private field `xyz` accompanied by methods `getXyz()` and `setXyz()` with the correct visibility.

### Private Property Erasure

When the target platform supports fields, the property is marked `private` and the accessor and modifier are not explicitly declared the compiler may erase the property and produce a private field that will be accessed directly. 

In case the property is not public and the accessor and modifier are not explicitly declared, the compiler can  bypass the accessor and modifier and use the backing field directly when reading and writing within the class.
