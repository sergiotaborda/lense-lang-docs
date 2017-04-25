title=Objects
date=2015-12-19
type=post
tags=tour, lense
status=published
~~~~~~


Lense does not have primitives (values that are not objects) and thus all values are objets , all objects decend from some class and all variables are references. 
The Lense back-end compiler may try to use the native plataform's primitives as much as possible to enhance performance, but this is an otimization. Conceptually primitives do not exist.
All being objetcs also means no static members exist.

# Classes

Classes are the main tool to define your own objects.
A class to represent fraction objects could be implemented like so:

~~~~brush: lense
public val class Fraction {
    
    val numerator : Integer;
    val denominator : Integer;

    private constructor ( numerator: Integer,  denominator: Integer);

    constructor valueOf ( value: Decimal){
        return new Fraction(value.toString());
    }

    constructor valueOf (value : String){
         val pos : Natural? = value.indexOf('.');
         if (pos.hasValue){
            val wholePart = new Integer.parse(value.subString(0,pos));
            val multiplier =  10 ** (value.length - pos); // 10 to the power of the number of decimal digits
            val decimalPart = new Integer.parse(value.subString(pos+1));     

            val numerator = wholePart * multiplier + decimalPart;

            return new Fraction(numerator, multiplier);
         } else {
            // whole number
            return new Fraction(new Integer.parse(value), 1);
         }
    }

    public multiply ( other : Fraction) : Fraction{
          return new Fraction ( this.numerator * other.numerator, this.denominator * other.denominator);
    }

    public invert () : Fraction{
        return new Fraction (this.denominator, this.numerator);
    }

    public Numerator : Integer { get { return numerator; } } 

    public Denominator : Integer { get { return denominator; } } 

}
~~~~

Classes in Lense support fields, [properties](properties.html), [indexers](properties.html#indexed), methods and [constructors](constructors.html) as you would expect.
Lense also support imutability declaration for classes with ``val class``.
Any type or member can also have generic type parameters.


~~~~brush: lense
public class Matrix<T> { 

    val backingArray : Array<T> = new Array<T>();

    val rowsCount : Natural;
    val colsCount : Natural;

    constructor Matrix( rowsCount : Natural, colsCount : Natural){
        this.rowsCount = rowsCount;
        this.colsCount = colsCount;

        backingArray = new Array<T>(rowsCount * colsCount);
    }

    public  [row : Natural, column: Natural] : T {
        get {
            return backingArray[row * ]
        }        
        set (value){

        }
    }

}
~~~~

# Sum Types

<a name="sum-types"/>In Lense is possible to define an abstract type that can only be implemented by a limited list of other types.
The classic example is the Node type. Normally we have a Branch node and a Leaf node. Tradicionally we would write:

~~~~brush: lense 
public abstract class Node <T> {

}

public class Brunch<T> extends Node<T>{
	constructor (left : Node<T>  , right: Node<T> );
}
	
public class Leaf <T> extends Node<T>{
	constructor (value : T );
}
~~~~ 

If we now need to visit a long and complex tree we need to normally do so validation of types. For example, in java would be:

~~~~brush: java
// java
public <T> void colectLeafs(Node<T> node, List<T> leafs){

	if (node instanceof Branch){
	     Branch b = (Branch)node);
	     collectLeafs(b.left, leafs);
	     collectLeafs(b.right, leafs);
	} else if (node instanceof Leaf){
	    leafs.add(((Leaf)node).value);
	}
}
~~~~

We need to make a decision based on the type of the object, then cast it, then capture the properties and use them.
In Lense we could use a similar construction using the flow-cast mechanism:

~~~~brush: lense 
public colectLeafs<T>(Node<T> node, List<T> leafs): Void {

	if (node is Branch<T>){
	     collectLeafs(node.left, leafs);
	     collectLeafs(node.right, leafs);
	} else if (node is Leaf<T>){
	    leafs.add(node.value);
	}
}
~~~~

However the compiler would be blind to the fact ``Node`` is a sum type. If we did not had a ``else if`` to test for leafs the compiler 
would not complain.  If we need the be sure all sub types are covered we can use the ``switch`` statement.

~~~~brush: lense
public colectLeafs<T>(Node<T> node, List<T> leafs) : Void {

	switch(node) {
		case is Branch<T> {
			collectLeafs(node.left, leafs);
	        collectLeafs(node.right, leafs);
		} 
		case is Leaf<T> {
			leafs.add(node.value);
		} 
	}
}
~~~~

The flow-cast mechanism still applies in the switch, but for this to work as expect we need to informe the compiler the children types of ``Node`` are limited to ``Brunch`` and ``Leaf``:

~~~~brush: lense 
public abstract class Node<T> is Brunch<T> | Leaf<T> {

}

public case class Brunch<T> extends Node<T> {
	constructor (var left : Node<T> , var right : Node<T>);
}

public case class Leaf<T> extends Node<T> {
	constructor (var value : T);
}
~~~~ 

With this new code the compiler knows that ``Brunch`` and ``Leaf`` are the only possible sub types of ``Node``.