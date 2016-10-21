title=Properties
date=2016-04-26
type=post
tags=tour, lense
status=published
~~~~~~

# Properties

In other languages you can have fields (class attributes) and methods. Some languages , like C# and Scala introduce the concept of properties.
Properties are invoked like fields but behave like methods. All properties have two associated methods called Acessor and Modifier. The acessor is the methods called to obtain (get) the value 
of the property. The Modifier is the methods called to change (set) the value of the property. In the background, properties are commonly a polimorfic way to access a field.
In java, for example, properties are not a language construct and developers are required to follow some idioms and rules (Java Beans) to define properties in a ways other developers and API will understand.
 
From the degin point of view, fields represent state and properties represent the access to that state with the added value of intercepting the state read and write operations and eventually calculating the state on the fly from other properties. Because of this, fields are not supposed to be public has this will break polimorfic access and the client code will have knowledge of how the object stores its state. On the other hand, properties never need to be private because if they are they are not polimorfic any more an the class is only controling acess to it self. 

So Lense does only have one construct named Property. However, Lense properties behave like fields if the are private, and like normal properties if the are not private hence having the best of both world in a single construct. Adicionally remember Lense requires all fields and properties to be initialized to a non *null* value.
 
 ~~~~brush: lense
public class Person {

	public var name : String { get; set;}   = ""; // self-backing property initialized with the empty string
	public var surname : String  { get; set;}  = ""; // self-backing property initialized with the empty string
	
}

// used like a field

val person = new Person();

person.name = "John"; // call modifier to set the value
person.surname = "Doe"; // call modifier to set the value

val fullname  = person.fullname; // call accessor to get the value

Console.print(fullname); // prints: John Doe
~~~~
 
The compiler will produce backing fields for non-public properties and will produce acessor and modifier methods that read and write from/to that field.

Note that properties are preceded with var or val. Properties with val are read-only and can only define an acessor (get) method. 
Properties wih var are read-write and can define both acessor and modifier. By this rule we can them simplify the declarations like this:

~~~~brush: lense
public class Person {

	public var name : String  = ""; // self-backing property initialized with the empty string
	public var surname : String  = ""; // self-backing property initialized with the empty string
	
}

Now the properties look like fields. Remember that the compiler will produce polimorphic properties because you defined them as public.

## Adding Beahvior

Properties can be calculated and/or calculate state. When you need this funcionallity you simply declare the body of the acessor and modifier. 
Remember that if you do not declare one of them the correspondig operation (read , or write) will not be available.

~~~~brush: lense
public class Person {

	public var name : String = "";
	public var surname : String = "";
	public var birthdayay : Date?;
	
	// read-write property
	public fullname : String {  // backing-fields will not be produced when the acessor and/or the modifier are explicitly defined.
		get { 
			// concatenate the names
			return name + " " + surname; 
		}
		set (value){
			// split the names by a empty space
			val split = value.split(" ");
			this.name = split[0];
			this.surname = split[1];
		}
	}
	
	// read-only
	public ageToday : Natural? { // the acessor wil not be defined because is not declared
		get{
			return this.birthdayay.map ( date -> (Date.today - date).days); 
		}
	}
	
}
~~~~

## Non Inialized Properties

You may not omit the properie's initialization because Lense as no ``null``. If we do not kown the value or do not want to initialized it you will need to use an optional type.

~~~~brush: lense
public class Person {
    ... 
	public var birthdayay : Date?;
}
~~~~

Lense will still initialize this propery (because there are no nulls), but because its an optional type , the value to use is a constant (the object none). So the above code is equivalent to:

~~~~brush: lense
public class Person {

	public var birthdayay : Date? = none;
}
~~~~


## Read-Only and Write-Only Properties

By omitting just the modifier, you can make a property read-only. By omitting just the accessor, you can make a property write-only. 
If the property is read only, or write only. the compiler will not define a private backing-field and an explicit method body is necessary.

~~~~brush: lense
public class Person {

	public name : String{}
	public surname : String{}
	
	public  fullname : String { // a read only property
		get { return name + " " + surname; }
	}
}
~~~~

The use of write-only properties is less commom, in practice, but possible. In that case you will need some other place to store the value.

~~~~brush: lense
public class Write {

	private var field : String?

	public  fullname : String{ // a write only property
		set(value) { 
			this.field = name + " " + surname; 
		}
	}
}
~~~~

Please note the syntax for a private fields is the same for a public property only the visibility modifier is different.

## Properties Constructor

If the properties are mandatory in the constructor you can use a special constructor syntax

~~~~brush: lense
public class Fraction {

	constructor ( public val numerator, public val denominator);
	
	public val Value : Rational {
		get {
			return this.numerator / this.denominator;
		}
	}
}
~~~~

This will create two readonly properties named "numerator" and "denominator" with a backing-field that is initialized in the constructor. 
You can only use this syntax in the primary constructor (the one with no body).

## Different visibility

Sometimes you need to have a public accessor but a private modifier, or vice-versa. In that case you can use visibility modifiers to declare diferent visibilities

~~~~brush: lense
public class Person {

	public name : String{ public get; private set;}
	public surname : String { get; private set;}
}
~~~~

If you omit the modifier near the acessor or modifier declarations the visibility of the property will be used.
The visibility of the acessor or modifier may not be less restrictive than that of the property. So public get for a private property makes no sense. 

## Intercepting And Acces to the Backing-Field 

Sometimes you need to intercept the call to the acessor or the modifier but we would like the code to also write the result to the backing-field;
This is very uncomon, so the example is a little contrived. The point is that can be done, if you need to.

~~~~brush: lense
public class Doubler {
	
	contructor (private val log: Logger);

	public someValue : Natural {
		get {
			log.trace("returning {{ someValue }}");
			return 
		}
		set (value) {
			val doubleValue = value *2;
			log.trace("storing {{value}} as  {{ doubleValue }}");
			someValue = doubleValue;
		}
	}
}
val log = ... // obtain it somehow

val d = new Doubler(log); 

d.someValue = 5; // will log "storing 5 as 10"
val x = d.someValue; // will log "returning 10"
~~~~

You can use the property's name inside the accessor or the modifier to read the value before returning it and in the case of the modifier also to set a different value that the one given.

# Indexer Properties

<a name="indexed">Indexer properties</a> are anonymous properties that allow you to associate a value of the property with one or more values of parameters called indexes.
The most common examples are arrays that use numeric indexes or maps that use key object for indexes.

The rules of normal properties apply to indexer properties , you need to define an accessor, or a modifier, or both.
Indexer properties are never self-backing.

Indexers are not limited to one index. In the next example we use an array to implement a matrix using a mathematical trick of calculating the cell
position in the array. We use the indexer property in the array to read and write values in the array.

~~~~brush: lense
public class Matrix<T> {

	private cells : Array<T>;
	private rowsCount : Natural;
	private columnsCount: Natural;
	
	contructor (private rowsCount : Natural, private columnsCount: Natural, private seed : T){
		this.rowsCount = rowsCount;
		this.columnsCount = columnsCount;
		
		this.cells = new Array.filled<T>(rowsCount * columnsCount, seed);
	}
    
	public [Natural row, Natural column] : T { 
		get {  
			return items[calculateCell(row, column)]; 
		}
		set (value){
		   items[calculateCell(row, column] = value;
		}
	}
	
	private calculateCell(Natural row, Natural column) : Natural{
		return row * rowsCount + column;
	}	
}

// use it like 

val matrix : Matrix<Integer, Integer>  = new Matrix<Integer,Integer>(3,3, 0);

matrix[1,2 ] = 4;

val four = matrix [1,2];
~~~~

An indexer as no name, so it is not possible to overload it with the exact same number, and types, of indexes. 

