title=Boolean
date=2017-06-14
type=post
tags=boolean, lense
status=published
~~~~~~

# Booleans

To represent boolean values, Lense has a type named ``Boolean``. Only two objects have type ``Boolean``: ``true`` and ``false``.
Lense decision directives only allows Boolean values and expressions as argument. For example, the following code will not compile:

~~~~brush: lense
val name : String = "Alice";
if (name){  // Compilation error. Expected Boolean expression
	printName(name);
}
~~~~

Boolean values are very common is method signatures so whenever possible the compiler will leverage the plataforms native boolean type by means of [erasure](erasure.html).

Operations upon booleans are divided in two categories Bitwise Operations and Logic Operations

## Bitwise Operations

Bitwise operations regard boolean values as being equivalent to a single bit an operate according to they respective tradicional [Truth Tables](https://en.wikipedia.org/wiki/Truth_table).

+ &  - the bitwise AND operator
+ |  - the bitwise OR operator
+ ^  - the bitwise XOR (Exclusive-OR) operator

These operators are comutative, so the order of the operands is not relevant.

~~~~brush: lense
assert(!checkA()); // checkA() returns false 
assert(checkB()); // checkA() returns true 

val check = checkA() & checkB();
val checkReverse = checkB() & checkA();

assert( check ==  checkReverse);
~~~~

## Logic Operators 

Logic operators are operators that can only operate on expressions of type ``Boolean``. In Lense these operators are [intrinsic](operators.html#intrinsic) and cannot be overloaded.
They are:

+ &&  - the logic AND operator
+ ||  - the logic OR operator
+ !  - the logic NOT operator

Logic operators && and || are short-circuit, meaning that once the evaluation has determine the result is fixed no further expressions will be evaluated.
Take this example:

~~~~brush: lense
assert(!checkA()); // checkA() returns false 
assert(checkB()); // checkA() returns true 

val check = checkA() && checkB();
val checkReverse = checkB() && checkA();

assert( check == checkReverse);
~~~~
 
Because ``checkA`` return ``false`` the result at line 1 will be ``false`` no matter what ``checkB`` returns, so the call to ``checkB`` it will not be executed.
In line 2 ``checkB()`` return ``true`` so ``checkA()`` must be called to determine the final value. The end result will be the same as using the ``&`` operator but the side effects would not.
Because Lense is not a pure functional language and side effects mut be considered, the Logic operators are needed.

