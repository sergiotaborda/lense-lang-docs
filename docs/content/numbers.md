title=Numbers
date=2016-04-03
type=post
tags=tour, lense
status=published
~~~~~~

#Numbers

Numbers are separated in specific algebraic structures that conform to the mathematical rules of their group of elements.
All numbers are descendent types of the ``Number`` class. Operations are defined for each type independently.
Lense supports Complex and Imaginary numbers. Even thought we are aware the performance of these types may not be optimal, we understand that not supporting them would be a worst decision. 

* Whole - numbers with no decimal part.
	- Natural - Represents elements from the mathematical **&#8469;** set, i.e. positive only whole values that include zero and range from zero up to maximum value limited only by available memory
	- Integer - Represents elements from the mathematical **&#8484;** set, i.e. negative and positive whole values.
		*  Int16 - negative and positive whole values with range from -2<sup>15</sup> to  2<sup>15</sup>-1.
		*  Int32 - negative and positive whole values with range from -2<sup>31</sup> to  2<sup>31</sup>-1. 
		*  Int64 - negative and positive whole values with range from -2<sup>63</sup> to  2<sup>63</sup>-1. 
		*  BigInt - negative and positive whole values with arbitrary range limited only by available memory
* Real - Represents elements from the mathematical **&#8477;** set.
	-  Rational - Represents elements from the mathematical **&#8474;** set, i.e. rational numbers defined by a natural numerator and a natural denominator like 2/3 or -5/8. The denominator cannot be zero. 
	-  Decimal - Represents elements that have a fixed precision and so calculations may incur in loss of precision.
		* FixedPrecisionDecimal - Represents Decimal elements with fixed precision:
			- Decimal32 - negative and positive decimal values that follow 32 bits IEEE 3744 conventions
			- Decimal64 - negative and positive decimal values that follow 64 bits IEEE 3744 conventions
		* ArbitraryPrecisionDecimal - Represents Decimal elements with arbitrary precision:
			- BigDecimal - Represents elements in the **&#8477;** set including truncated version of irrational numbers.Negative and positive decimal values with arbitrary precision limited only by available memory.
* Imaginary - Represents elements from the mathematical **&#120128;** set. Numbers with pure imaginary parts of the form ``bi`` where ``b`` is a ``Number`` and ``i`` is the square root of -1.
	- ImaginaryOverReals<T extends Real>; - uses a Real type to store the numeric value
* Complex - Represents elements from the mathematical **&#8450;** set. Complex numbers are of the form ``a + bi`` where ``i`` it the square root of -1.
	- ComplexOverReals<T extends Real>; - Use a Real to type to store a numeric value for the real part and a ImaginaryOverReals<T> for the imaginary part.

Type ``Natural`` is used as an indexer for ``Sequence``s. Limits to collections like arrays, lists and maps are only bound by the limit of Natural which in turn is limited only by available memory.
Using a Natural to index sequences removes the necessity to check for negative indexes and because ``Arrays`` always have a upper limit and always are constructed by [factory like constructors](constructors.html#factory) the implementation for each platform can accommodate different implementations according to maximum length demand.

For more information on how Natural relates to index of sequences, see how [Arrays](arrays.html) work in Lense.
For more information on arithmetic operations  more on Lense [operators](operators.html).


## Number Literals 

Literals with no decimal part are always assumed ``Natural`` and in base ten representation. The natural values are transformed to other types as needed. 
This conversion may rise an ``OverflowException`` becasue a ``Natural`` can exceed the maximum values of other types. For example, atribuiting a natural to a Int32.
For literals with a decimal part , they are always assumed ``Rational``. This is because irrational numbers cannot , in general, be represented literally.

If you need to define the type of the literal explicitly you can use specific sufixes, upper case letters for whole numbers and lowercase letters to decimal numbers.

~~~~brush: lense
	var Natural n = 1; // equivalent to Natural.valueOf("1")
	
	// literals are always assumed to be Natural and promoted when necessary
	var i : Int32 = 1;  // equivalent to Int32.valueOf(Natural.valueOf("1"));
	var s : Int16 = 1;  // equivalent to Int16.valueOf(Natural.valueOf("1"));
	var k : Int64 = 1;  // equivalent to Int64.valueOf(Natural.valueOf("1"));
	var g : BigInt = 1;  // equivalent to BigInt.valueOf(Natural.valueOf("1"));
	
	// If the target type is Whole or Integer, the literal it's equivalent to having BigInt as target 
	var w : Whole = 1; // equivalent to BigInt.valueOf(Natural.valueOf("1"));
	var u : Integer = 1;  // equivalent to BigInt.valueOf(Natural.valueOf("1"));
	
	// sufixes can be used to inform the compiler the correct type of the literal
	// for whole numbers only uppercase prefixes are allowed 
	var ii : Int32 = 1Z;  // equivalent to Int32.valueOf("1");
	var ss : Int16 = 1S;  // equivalent to Int16.valueOf("1");
	var kk : Int64 = 1L;  // equivalent to Int64.valueOf("1");
	var gg : BigInt = 1G;  // equivalent to BigInt.valueOf("1");
	
	// Rationals are defined by the division of two whole positive values. 
	var r : Rational = 2/3; // equivalent to Natural.valueOf("2").divide(Natural.valueOf("3"))
	var q : Rational = -5/8; // equivalent to Natural.valueOf("5").negate().divide(Natural.valueOf("8"));
	var q : Rational = -x/y; // equivalent to Natural.valueOf(x).negate().divide(Natural.valueOf(y));
	
	// In this case the value is a Natural being promoted to a Decimal32.
	var f : Decimal32 = 1; // equivalent to Decimal32.valueOf(Natural.valueOf("1"));
	
	// decimal values are always assumed to be Rational
	var rr : Rational = 1.4 //  equivalent to Rational.valueOf("1.4");
	var ff : Decimal32 = 1.6; // equivalent to Decimal32.valueOf(Rational.valueOf("1.6"));
	var d  : Decimal64 = 2.0; // equivalent to Decimal64.valueOf(Rational.valueOf("2.0"));
	var m  : BigDecimal = 1.234567890E100; // equivalent to BigDecimal.valueOf(Rational.valueOf("2.0"));

	// prefixes can also be used to inform the compiler the correct type of the literal
	// for non whole numbers only lower-case prefixes are allowed 
	var fff : Decimal32 = 1.6f; // equivalent to Decimal32.valueOf("1.6");
	var dd : Decimal64 = 2.0d; // equivalent to Decimal64.valueOf("2.0");
	var mm : BigDecimal = 1m; // equivalent to BigDecimal.valueOf("1");
	
	
	var a : Imaginary = 2i; // equivalent to Imaginary.valueOf(Natural.valueOf("2"));
	var b : Imaginary = 2.5i; // equivalent to Imaginary.valueOf(Rational.valueOf("2.5"));
	
	var error : Imaginary = 2; // does not compile because a Natural can not be converted to an Imaginary number

	var c: Complex = 5 + 2i; // equivalent to Natural.valueOf("5").plus(Imaginary.valueOf(Natural.valueOf("2")))
	var d: Complex = 3.9 + 0.2i; // equivalent to Rational.valueOf("3.9").plus(Imaginary.valueOf(Rational.valueOf("0.2"))
~~~~

In any representation you can use _ to logically separate digits in the value to help readability.

~~~~brush: lense
	var x : Integer -1000000;
	// or
	var x : Integer = -1_000_000;
~~~~

### Other Bases for Literal Representations 

Numeral literals are assumed to be represented in decimal form (base 10) for all types. For naturals it is also possible to use the hexadecimal (base 16) form.

The hexadecimal form begins with a ``#`` symbol followed by a valid hexadecimal digit: 1, 2, 3, 4, 5, 6, 7, 8, A , B, C, D , E , F. You can also use _ to separate digits like in base ten representation.

~~~~brush: lense
	var  color : Natural = #FF_EE_00; // hexadecimal
~~~~

## Binary and Bytes

Lense supports the ``Binary`` immutable interface to represent any value that can be understood as a sequence of bits. ``Binary`` does not,necessarily, represent a number. 
Two default implementations of Binary exist :  ``BitArray``is a size imutable implementation , while is ``BitList`` a size mutable implementation.
``BitList`` supports a variable size of bits. ``BitArray`` supports a fixed length of bits.

``Byte`` is a special class that also implements ``Binary`` corresponding to a fixed length sequence of 8 bits. It's primarily intented for use in I/O operations. ``Byte`` is not a number, does not have an assigned numeric value and there is no automatic promotion from ``Byte`` to any type of ``Number``. Also it has no arithmetic operations. However, a ``Byte`` can be transformed explicitly to a ``Natural`` between 0 and 255 or to a ``Int32`` between -128 and 127 by means of the ``toNatural()`` and ``toInteger()`` functions.

~~~~brush: lense
	var  byte : Byte = $1111_0000; 
	var  n : Natural = byte.toNatural(); // equivalent to 240;
	var  i : Int32 = byte.toInteger(); // equivalent to -16
	
	var error : Natural = byte; // illegal. Byte is not assignable to Natural.
~~~~

``Int16`` , ``Int32`` and ``Int64`` also implement ``Binary`` corresponding to a fixed length sequence of 16, 32 and 64 bits respectively. Because this values have a signed numeric value, one of the bits is reserved to determine the sign. The rest of the bits represent the value if the value is positive, else represent the Two Complement representation of the (then negative) value.

### Binary Literal Representation

The literal of binary begins with a ``$`` sign flowed by a sequence of ones (to represent ``true``) and zeros (to represent ``false``). The ``_`` symbol can be used, as in number literals, to separate digits logically.

All binary literals are assumed to be instances of ``BitArray`` with the given number of bits. It is not possible to have literal for a zero bits sequence. 

~~~~brush: lense
	var  byte : Byte= $1111_0000; // equivalent to Byte.valueOf(BitArray.valueOf(true,true,true,true,false,false,false,false));
	var  short : Int16 = $1111_0000_1111_0000; // equivalent to Int16.valueOf(BitArray.valueOf(true,true,true,true,false,false,false,false,true,true,true,true,false,false,false,false));
	var  flags : BitArray = $1111_0000_0101_0110_0010_0001_0101_1001; // equivalent to BitArray.valueOf(true,true,true,true,false,false,false,false,true,false,true,false,true,true,false,false,false,false,false,false,false,false,true,false,true,false,true,true,false,false,true);
~~~~	

*Note the equivalent expressions are conceptual, in practice the compiler uses more suitable constructors for each case.*
