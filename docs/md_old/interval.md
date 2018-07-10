title=Intervals
date=2017-02-27
type=post
tags=tour, lense
status=published
~~~~~~

#Category 

A categoy is an assortement of elements that is not iterable and not contable. It defines a ``contains`` method that can be invoked directly of by means of the ``in`` operator.

~~~~brush: lense
	if (5 in |[2 , 6)|) { 
	    // 5 is in the interval
	}
~~~~

is the same as 

~~~~brush: lense
	if ( |[2 , 6)|.contains(5)) { 
	    // 5 is in the interval
	}
~~~~


#Interval

Lense support intervals as fundamental types. An ``Interval`` forms a ordered ``Category`` of ``Comparable`` elements that contain values between a start and an end element. So you can test if an element exists in the interval.

~~~~brush: lense
	if (5 in |[2 , 6)|) { 
	    // 5 is in the interval
	}
~~~~

However you cannot iterate over the elements.

~~~~brush: lense
	for (i in |[2 , 6)|) { // Compilation error : Interval is not Iterable
	    
	}
~~~~

Interval literals in lense follow the mathematical convention of using square brakets for included values and parentesis for excluded values. So ``|[2 , 6)|`` represents an interval between 2 , inclusive, and 6 exlusive; meaning 6 does not belong in the interval. Lense also supports open intervals. For example ``|( * , 7 ]|`` represent the open start interval that contains all elements  from negative infinity to 7, inclusive. Here are some examples of the possibilities:

~~~~brush: lense 
if ( x in |[ 3 , 7]| ){ 
	// x is >=3 and <= 7
}

if ( x in |[ 3 , 7)| ){
	// x is >=3 and < 7
}

if ( x in |(3 , 7)| ){
	// x is >3 and < 7
}

if ( x in |(3 , 7]| ){
	// x is >3 and <= 7
}

if ( x in |( * , 7)| ){ 
	// x is < 7
}

if ( x in |[ 3, * )| ){
	// x is >= 3
}

if ( x in Interval<Natural>.empty() ){
	// always false. 
}

if ( x in Interval<Natural>.all() ){
	// always true. the full interval covers all possible values.
}
~~~~

Intervals can be used in switch statements as any ``Category`` can 

~~~~brush: lense
	val x = 9;
	switch (x) { 
	   case (in |[ 0, 9]|) {
		  return "Single digit number";
	   }
	   case (in |(9, *)|) {
		  return "Multidigits number" 
	   }
	}
~~~~


#Ranges

Ranges are closely related to intervals. Ranges are also ``Categories``, but of ``Enumerable``s making them ``Iterable``.  Ranges can be understood as intervals of ``Enumerable`` values as ``Enumerable`` types are also ``Comparable``. Because ``Enumerable`` values can produce a sequence of value ranges are iterable. Ranges cannot have open ends. Ranges are also fundamental types in Lense and have their own literal.

~~~~brush: lense
	if (5 in 2..6) { 
	    // 5 is in the range from 2, inclusive, to 6, inclusive
	}
~~~~

By default both ends of the range are included in the range. We can iterate the values in the range with the for-each directive.

~~~~brush: lense
	for (i in 2..6) { 
	    console.println(i);
	}
~~~~

this prints:

~~~~console
2
3
4
5
6
~~~~

So for an ``Enumerable`` type, intervals have a correspondence to ranges 

* |[ x, y]|  correspondes to x..y
* |( x, y]|  correspondes to x>..y
* |( x, y)|  correspondes to x>..<y
* |[ x, y)|  correspondes to x..<y

Open intervals like ``|(*, y]|`` and ``|( x, *)|`` have no correspondence with ranges. The empty interval corresponds to ``Range<T>.empty()`` and does not exist a full Range.



