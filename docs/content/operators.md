title=Operators
date=2016-02-03
type=post
tags=lense, operator overloading
status=published
~~~~~~

# Operators

Lense supports operators with a special kind of operator overloading. There are two types of operators : intrinsic and redefinable.

Intrinsic operators are native to the language and their behavior cannot be redefined. On the other hand, the set of available operators for redefinition is limited ( we do not what symbolic noise ) but extended enought to be usefull in a mathematical or engineering context.
Redefinable operators are translated to calls to methods. Intrinsic operators are not translated to method calls.


Symbols are gathered from differente sources. Lense pays special attention to algebric structures that are related to the operators and symbols, this means, for example, that the symbol implies if the operation is comutable or not. As a rule of thumb, doubled symbols always represent non-comutative operations. For example,we use ``^^`` for exponentiation that we now is always non-comutative and `^` for the XOR operator that is always comutative. On te same token we use `+` for comutative sum and `++` for non cumutative concatenation.



## Intrinsic Operators

Intrinsic operators cannot be redefined and are specially handled by the compiler.

<table class="listing">
	<tr>
		<th>Operator</th>
		<th>Example</th>
		<th></th>
	</tr>
	<tr>
		<td> === </td>
		<td> a === b </td>
		<td> Determines if two objects have the same identity. Only objects of type <code>Identifiable</code> can use this operator </td>
	</tr>
	<tr>
		<td> !== </td>
		<td> a !== b </td>
		<td> Determines if two objects have *not* the same identity. Only objects of type <code>Identifiable</code> can use this operator </td>
	</tr>
	</tr>
		<tr>
		<td> :: </td>
		<td> var plusOperator = Natural::plus; </td>
		<td> Allows for easy reflection of class members </td>
	</tr>
	<tr>
		<td> + (infix) </td>
		<td> +a</td>
		<td> Does nothing. An infix <code>+</code> signed is ignored after parsing. It does not turn a negative value into a positive value.</td>
	</tr>
	<tr>
		<td> && </td>
		<td> a && b</td>
		<td> *a* and *b* must be <code>Boolean</code>. Performs an AND logic operation on the operands but only is *a* is true. Otherwise simply return ``false``. Because of the short-circuit behavior this is not a comutative operator. </td>
	</tr>
	<tr>
		<td> || </td>
		<td> a || b</td>
		<td> *a* and *b* must be <code>Boolean</code>. Performs an OR logic operation on the operands but only is *a* is false. Otherwise simply return ``true``.Because of the short-circuit behavior this is not a comutative operator. </td>
	</tr>
		<tr>
		<td> ! </td>
		<td> !a</td>
		<td> *a* must be <code>Boolean</code>. Inverts the logic value of *a*. </td>
	</tr>
</table>

## Definable Operators

Lense supports the following overridable operators:

<table class="listing">
	<tr>
		<th>Operator</th>
		<th>Example</th>
		<th>Translates to</th>
		<th>Operator Interface</th>
		<th></th>
	</tr>
	<tr>
		<td> == </td>
		<td> a == b </td>
		<td> a.equals(b) </td>
		<td> Equatable </td>
		<td> Determines if two objects are equal. </td>
	</tr>
	<tr>
		<td> !=</td>
		<td> a != b </td>
		<td> !a.equals(b) </td>
		<td> Equatable </td>
		<td> Determines if two objects are *not* equal. </td>
	</tr>
	<tr>
		<td> + </td>
		<td> a + b </td>
		<td> a.plus(b) </td>
		<td> Summable<A,D,S> </td>
		<td> Sums two values and returns a third value. Prefer the + operator for comutative monoid operations with zero as identity element.</td>
	</tr>
	<tr>
		<td> ++ </td>
		<td> a ++ b </td>
		<td> a.concat(b) </td>
		<td> Concatenatable<A,D,S> </td>
		<td> Concatenates two values and returns a third value. Prefer the ++ operator for non comutative monoid operations with empty as identity element </td>
	</tr>
	<tr>
		<td> - </td>
		<td> a - b </td>
		<td> a.minus(b) </td>
		<td> Subtractable<D,A,S> </td>
		<td> Substracts two values and returns in a third value. This operator represents a non-comutative operation.  </td>
	</tr>
	<tr>
		<td> * </td>
		<td> a * b </td>
		<td> a.multiply(b) </td>
		<td> Multiplyable<P,A,B> </td>
		<td> Multiplies the two values and returns in a third value. Prefer the * operator for comutative monoid operations with one as identity. </td>
	</tr>
	<tr>
		<td> ^^ </td>
		<td> a ^^ b </td>
		<td> a.raiseTo(b) </td>
		<td> Powerable<P,B,E> </td>
		<td> Raises the first operand to the power of the second operand and returns the result in a third value. Prefer the ^^ operator for non-comutative monoid operations with one as identity. </td>
	</tr>
	<tr>
		<td> / </td>
		<td> a / b </td>
		<td> a.divide(b) </td>
		<td> Dividable<Q,N,D> </td>
		<td> Divides the two values and returns a third value. The operand values are not changed in any way. This operator represents a non-comutative operation. Note that Whole numbers implement Dividable&lt;Rational, Whole,Whole&gt; and
			Decimals implement Dividable&lt;Decimals,Decimals,Decimals&lt;. 
		</td>
	</tr>
	<tr>
		<td> \ </td>
		<td> a \ b </td>
		<td> a.wholeDivide(b) </td>
		<td> WholeDividable<W> </td>
		<td> Performs whole division the two values and returns a third value. The operand values are not changed in any way. This operator represents a non-comutative operation. Note that Whole numbers implement WholeDividable&lt;Whole&gt; 
		</td>
	</tr>
	<tr>
		<td> % </td>
		<td> a % b </td>
		<td> a.remainder(b) </td>
		<td> WholeDividable<W> </td>
		<td> Divides the two values and returns the remainder of integer devision. This operator represents a non-comutative operation.  Note that it should true that <i>a = a \ b + a % b</i>
		</td>
	</tr>
	<tr>
		<td> - (infix) </td>
		<td> -a </td>
		<td> a.symetric() </td>
		<td> Symmetrical<T,R> </td>
		<td> Returns the symmetric value. Keep in mind the type needs not be closed for subtraction. For `Natural`s, for example the symetric value is an `Integer`. </td> 
	</tr>
	<tr>
		<td> ~ (infix) </td>
		<td> ~a </td>
		<td> a.complement() </td>
		<td> Complementable<T,R> </td>
		<td> Returns the complement of the value. For Binary values it is equivalent to fliping all bits. For complex numbers is represents the conjugate so that  <i>~(a + ib) = a - ib</i> </td>
	</tr>
	<tr>
		<td> ++ (infix) </td>
		<td> ++a </td>
		<td> a.successor() </td>
		<td> Ordable<T> </td>
		<td> Obtain the next value in the enumeration.</td>
	</tr>
	<tr>
		<td> -- (infix) </td>
		<td> --a </td>
		<td> a.predecessor() </td>
		<td> Ordable<T> </td>
		<td>Obtain the previous value in the enumeration.</td>
	</tr>
	<tr>
		<td> & </td>
		<td> a & b </td>
		<td> a.and(b) </td>
		<td> Injunctable<R,A,B> </td>
		<td> Injucts the two values and returns a third value. For binary forms, this implements a bitwise AND. For sets this implements intersection</td>
	</tr>
	<tr>
		<td> | </td>
		<td> a | b </td>
		<td> a.or(b) </td>
		<td> Dijunctable<R,A,B> </td>
		<td> Dijuncts the two values and returns a third value. For binary forms, this implements a bitwise OR . For sets this implements union</td>
	</tr>
	<tr>
		<td> ^ </td>
		<td> a ^ b </td>
		<td> a.xor(b) </td>
		<td> ExclusivelyDijunctable<R,A,B> </td>
		<td> Exclusively dijunsts the two values and returns a third value. For binary forms, this implements a bitwise XOR </td>
	</tr>
	<tr>
		<td> <=> </td>
		<td> a <=> b </td>
		<td> a.compareTo(b) </td>
		<td> Comparable<T> </td>
		<td> Compared the order of the values of *a* and *b*. Returns <code>Comparison.Equals</code>, <code>Comparison.Greater</code> or <code>Comparison.Lesser</code> if , respectively, a = b, a > b and a < b.  The operand values are not changed in any way. </td>
	</tr>
	<tr>
		<td> > </td>
		<td> a > b </td>
		<td> a.compareTo(b) > 0 </td>
		<td> Comparable<T> </td>
		<td> Returns ``true`` if *a* is great than *b*, ``false`` otherwise. The operand values are not changed in any way.  </td>
	</tr>
	<tr>
		<td> >= </td>
		<td> a >= b </td>
		<td> a.compareTo(b) >= 0 </td>
		<td> Comparable<T> </td>
		<td> Returns ``true`` if *a* is great or equals to *b*, ``false`` otherwise. The operand values are not changed in any way.  </td>
	</tr>
	<tr>
		<td> < </td>
		<td> a < b </td>
		<td> a.compareTo(b) < 0 </td>
		<td> Comparable<T> </td>
		<td> Returns ``true`` if *a* is less than *b*, ``false`` otherwise. The operand values are not changed in any way.  </td>
	</tr>
	<tr>
		<td> <= </td>
		<td> a <= b </td>
		<td> a.compareTo(b) <= 0 </td>
		<td> Comparable<T> </td>
		<td> Returns ``true`` if *a* is less or equal to *b*, ``false`` otherwise. The operand values are not changed in any way.  </td>
	</tr>
	<tr>
		<td> .. </td>
		<td> a..b </td>
		<td> a.upTo(b)</td>
		<td> Progressable<T> </td>
		<td> Returns a Progression that starts at *a* and ends at *b*. The operand values are not changed in any way.  </td>
	</tr>
	<tr>
		<td> >> </td>
		<td> a >> n </td>
		<td> a.rightShiftBy(n)</td>
		<td> Binary<T> </td>
		<td> The arithmetic right shift operator returns a value equivalent to the original with bits moved to the right *n* times. This is equivalent to division by 2 *n* times for positieve numeric values.The operand values are not changed in any way.  </td>
	</tr>
	<tr>
		<td> << </td>
		<td> a << n </td>
		<td> a.leftShiftBy(n)</td>
		<td> Binary<T> </td>
		<td> The arithmetic left shift operator returns a value equivalent to the original with bits moved to the left *n* times. This is equivalent to multiplication by 2 *n* times for positieve numeric values. The operand values are not changed in any way.  </td>
	</tr>
	<tr>
		<td> <i>empty space</i> </td>
		<td>  a b </td>
		<td> a.juxtapose(b)</td>
		<td> Juxtaposable<T> </td>
		<td> (Under consideration) This is an operator with no symbol that means the two operands are simply "put together". This may mean a kind of multiplication like in `2 Kg` , or in matrix multiplication like `A B`. The juxtapose operator is non-comutative in general.  </td>
	</tr>
</table>

## Ternary operators 

### Ternary Select operator 
This operator test for the first term to be true. In the positieve case returns the second term. Otherwise returns the third.

~~~~brush:lense 
val c = (a == b) ? 1 : 4;
~~~~


### Ternary Comparison operator 
This operator compares the second term with the other ones according to the comparison operators use in between them an returns true if both sides are true

~~~~brush:lense 
val isTeenager =  13 <= x <= 19;
~~~~

This operator is equivalent to 

~~~~brush:lense 
val isTeenager =  13 <= x && x <= 19
~~~~

but, we do not need to use the `&&` operator nor type the variable `x` twice. 
Also this operator is equivalent to

~~~~brush:lense 
val isTeenager = x in |[ 13 , 19 ]|;
~~~~

but we do not need to create and interval object to text x agains it.

## A note on Increment and Decrement operators (Under consideration)

The infix ``--a`` and ``++b`` operators are transformed to calls into ``predecessor`` and ``successor``. For example, this code:

~~~~brush:lense 
val a : Integer= 3;
val b : Integer = ++a;
~~~~

At the end of this code, both *a* and *b* are 4.
Is equivalent to

~~~~brush:lense 
var  a : Integer = 3;
a = a.successor();
val b :Integer = a;
~~~~

As you can see the value in the variable is incremented implicitly as you would expect, however a new object is created and the reference is redirected to this new object. 

The suffix operators ``a--`` and ``a++`` are also transformed to calls into ``predecessor`` and ``successor``, but in a different sequence. For example:

~~~~brush:lense 
val a : Integer= 3;
val b : Integer = a++;
~~~~

At the end of this code, *b* is 3 and *a* is 4.
is translated internally to

~~~~brush:lense 
var a : Integer = 3;
val b : Integer = a;
a = a.successor();
~~~~

## Composed assignment operators

Consider the following operator statement:

~~~~brush:lense 
var a : Integer = 3;

a+=5;

~~~~

The ``+=`` is a composed assignment operator. Where the ``a+=5`` statement is equivalent to:

~~~~brush:lense 
var a : Integer = 3;

a = a + 5;

~~~~

All composed assignment operator are decomposed by the compiler in an assignment an a call to the root operator. 

<table class="listing">
	<tr>
		<td>+=</td>
		<td>-=</td>
		<td>*=</td>
		<td>/=</td>
		<td>\=</td>
	</tr>
	<tr>
		<td>&=</td>
		<td>|=</td>
		<td>^=</td>
		<td><<=</td>
		<td>>>=</td>
	</tr>
</table>

Remember that assignments are statemets in Lense, so the following code does not compile:

~~~~brush:lense 
var a : Integer = 3;

if (a+=5 > 7){
  // do something
}

~~~~

This one does:

~~~~brush:lense 
var a : Integer = 3;

a+=5;

if (a > 7){
  // do something
}

~~~~