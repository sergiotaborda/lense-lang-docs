title=Objects
date=2015-12-19
type=post
tags=tour, lense
status=published
~~~~~~

# Interfaces

Interfaces are constract declarations with no implementation.
 
~~~~brush: lense
public interface Validator<in T> {
     public validate( T candidate) : ValidatorResult;
}
~~~~

Interfaces can extend other interfaces an are implemented by classes or objects.

~~~~brush: lense
public val class MailValidator implements Validator<String> {

     public validate( String candidate) : ValidatorResult{
            val result = new ValidatorResult ();

            if (!candidate.indexOf('@').isPresent){
                result.addReason("Invalid email");
            }

            return result;
     }
}
~~~~

Interfaces can only define public properties and public methods. 