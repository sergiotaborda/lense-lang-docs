title=Casting
date=2017-11-19
type=post
tags=casting, lense
status=published
~~~~~~

# Casting

Lense does not support an explicit cast operator like C or Java , it supports flow sensitive casting instead. This means the compiler can use flow directives like ``if`` or ``switch`` to understand the type of the variable.

~~~~brush: lense 
public collectLeafs( root : Node , leafs : List<Node>) {
	
	if ( obj is LeafNode){
	   leafs.add(obj);
	} else if (obj is BranchNode){
		
		for (var child in obj.Children){
			collectLeafs(child, leafs);
		}
	} else {
		throw new Exception("Unrecognised node");
	}

}
~~~~

The ``is`` operator returns ``true`` if the variable holds an object of the specified type. The compiler then knows that all references to that variable inside the ``if`` realy refer to that type, and so all operations on that type are allowed.

Flow sensitive typing simplifies writing of *check and cast* idiom, very common when overriding ``equals``. In other languages, like Java you need to test for type and then cast:

~~~~brush: java
// Java 
public class Person {

	public long id;

	public equals(Object other){
		return (other instanceof Person) && ((Person)other).Id == this.Id;
	}

}
~~~~

in Lense the compiler is smart to understand that if tested, then the variable is of that type.

~~~~brush: lense 
public class Person {

	public var Id : Natural;

	public equals(other : Any){
		return other is Person && other.Id == this.Id;
	}

}
~~~~

You can also use other flow directives like ``switch`` :

~~~~brush: lense 
public collectLeafs( root : Node , leafs : List<Node>) {
	
	switch(obj){
		case is LeafNode {
		    leafs.add(obj);
		}
		case is BranchNode {
			for (var child in obj.Children){
				collectLeafs(child, leafs);
			}
		}
		default{
		 	throw new Exception("Unrecognised node");
		}
	}
}
~~~~

and ``assert``:

~~~~brush: lense 
var node : Node  = ... // some node

assert( node is BranchNode);

return node.Children.size; // at this line the compiler kowns node is a BranchNode because otherwise and exception would have been thrown.

~~~~

