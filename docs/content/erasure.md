title=Erasure
date=2016-10-17
type=post
tags=erasure, boolean, lense
status=published
~~~~~~

# Erasure

Erasure is a process that removes type information or transforms types to more primitive types at compile time.

Lense does not uses parametric types (aka Generics) facilities from the underlying plataform because they may not be compatible with Lense's variance rules , or not even exist (think javascript).
Thus all types are compiled as if they where not generic. However, Lense records all type information in metadata, for later use. This is similar to the strategy used for the java language. 

Lense itself has reified generics, but at compile time some tricks happen so no parametric type information exists in the code. This is similar to the strategy used by java's array where the type of the array is reified in the array object itself.

## Primitive Erasure

The underlying Virtual Machine handles some types more eficiently such as booleans , numbers and strings. 
Primitive erasure tries to gain this optimization by automaticly change type signature from the Lense types to the pimitive ones. This is only possible when values are not being used inside other values, so automathic boxing and unboxing are performed when necessary. 
Primtive erasure allows for the compiled code to be more compatible with the plataforms native code and thus more efficient, similar to the code you would write youself by hand.

Where is the list of erased types so far. 

| Lense type | Erased to |         |   
| :----------- | :-----------: | :-------------------: |   
| <code>lense.core.lang.Void</code>| plataform's primitive *void* | |   
| <code>lense.core.lang.Boolean</code>| plataform's primitive *boolean* |  Boolean constants (Boolean.False, Boolean.True) are also erased to their primitive conterparts (false, true). |   


Other candidates to consider are <code>lense.core.lang.String</code> and the bounded numeric types.



 