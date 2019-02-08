# nlib_List

[![Deploy to SFDX](https://deploy-to-sfdx.com/dist/assets/images/DeployToSFDX.svg)](https://deploy-to-sfdx.com?template=https://github.com/scottmcclung/nlib_list)

[![Deploy to Salesforce](https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png)](https://githubsfdeploy.herokuapp.com?owner=scottmcclung&repo=nlib_list)

### APEX Collection class
The nlib_List class provides a fluent, convenient wrapper for working with arrays of data.  
It allows you to reduce the boilerplate code required for many of the typical patterns required when 
working with native APEX lists.

For example we can easily create a new collection of Contact records and determine the most recent created date.

```apex
Date latestDate = nlib_List.collect([SELECT Id, CreatedDate FROM Contact]).pluck('CreatedDate').max();
``` 

No loops required!


#### Creating Collections

As mentioned above, the ```collect``` method returns a new collection instance.   Creating a new collection is as simple as:

```apex
nlib_List collection1 = nlib_List.collect();                                  // Empty collection
nlib_List collection2 = nlib_List.collect(new Contact(LastName = 'Jones'));   // Collection of SObjects
nlib_List collection3 = nlib_List.collect(new Contact[]{});                   // Empty collection of SObjects
nlib_List collection4 = nlib_List.collect( 'A' );                             // Collection of strings
nlib_List collection4 = nlib_List.collect(new String[]{ 'A', 'B', 'C' });     // Collection of strings
nlib_List collection5 = nlib_List.collect( 1 );                               // Collection of numbers
nlib_List collection5 = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });    // Collection of numbers
nlib_List collection = nlib_List.collect(Date.today());                       // Collection of dates
```

The ```combine``` method can also be used to merge two existing arrays or collections into a new list.

```apex
Integer lst1 = new Integer[]{ 1, 2, 3, 4, 5 };
Integer lst2 = new Integer[]{ 6, 7, 8, 9 };
nlib_List lst3 = nlib_List.combine( lst1, lst2 ); // outputs new collection [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] 
```




### Available Methods

##### ```add()```

The ```add``` method appends a value, list of values, or another collection to the end of the collection.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3 });
collection.add( 4 );                        // [ 1, 2, 3, 4 ]
collection.add( new Integer[]{ 5, 6, 7 });  // [ 1, 2, 3, 4, 5, 6, 7 ]
collection.add(nlib_List.collect( 8 ));     // [ 1, 2, 3, 4, 5, 6, 7, 8 ]

```


##### ```addUnless()```

The ```addUnless``` method appends a value to the end of the collection if the boolean expression evaluates to ```false```.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3 });
collection.add( 4, true );    // value not appended [ 1, 2, 3 ]
collection.add( 4, false );   // value appended [ 1, 2, 3, 4 ]
```



##### ```addWhen()```

The ```addWhen``` method is the opposite of ```addUnless```.  
It appends a value to the end of the collection if the boolean expression evaluates to ```true```.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3 });
collection.add( 4, true );   // value not appended [ 1, 2, 3 ]
collection.add( 4, false );  // value appended [ 1, 2, 3, 4 ]
```




##### ```all()```

Returns the underlying array represented by the collection.  
The array is returned as a list of generic objects so it needs to be cast to the intended type.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3 });
(Integer[]) collection.all(); // returns [ 1, 2, 3 ]
 ```


##### ```avg()```

Returns the average value of an array of numbers.  

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3 });
collection.avg(); // returns 2.0
```



##### ```chunk()```

The ```chunk``` method breaks the collection into multiple, smaller lists of a given size.
Returns type is ```List<nlib_List>```.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9 });
collection.chunk( 5 ); // returns [ 1, 2, 3, 4, 5 ] [ 6, 7, 8, 9 ]
 ```
 
 
##### ```copy()```
 
Returns a reference copy of the collection.
 
```apex
nlib_List collection1 = nlib_List.collect(new Integer[]{ 1, 2, 3 });
nlib_List collection2 = collection1.copy();
```


##### ```deepCopy()```

Returns a new cloned instance of the collection.

```apex
nlib_List collection1 = nlib_List.collect(new Integer[]{ 1, 2, 3 });
nlib_List collection2 = collection1.deepCopy();
```



##### ```dump()```

Logs the underlying array of values to the debug log.  Useful to log the current state of the collection while inside a fluent chain.

```apex
nlib_List collection1 = nlib_List.collect(new Integer[]{ 1, 2, 3 })
  .add( 4 )
  .dump()      //  Logs [ 1, 2, 3, 4 ]
  .add( 5 )
  .dump()      //  Logs [ 1, 2, 3, 4, 5 ]
  .add( 6 )
  .all()       // outputs [ 1, 2, 3, 4, 5 ];
```




##### ```equals()```

Compares this collection to the given array.  Returns ```true``` if they are the same.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3 });
collection.equals(new Integer[]{ 1, 2, 3 }); // true
```



##### ```notEquals()```

Compares this collection to the given array. Returns ```true``` if they are different.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3 });
collection.notEquals(new Integer[]{ 2, 3, 4 }); // true
```



##### ```except()```

Returns a new collection without the specified elements.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });
nlib_List newCollection = collection.except(new Integer[]{ 2, 3 }); // [ 1, 4, 5 ]
```


##### ```find()```

Returns the index of the given element in the collection.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });
collection.find( 4 ); // 3
```



##### ```first()```

Returns the first element in the collection.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });
collection.first(); // 1
```



##### ```firstOr()```

Returns the first element in the collection or the given value if the list is empty.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });
collection.firstOr( 6 );        // 1

nlib_List emptyCollection = nlib_List.collect();
emptyCollection.firstOr( 6 );   // 6
```



##### ```firstOrNull()```

Returns the first element in the collection or ```null``` if the collection is empty.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });
collection.firstOrNull();       // 1

nlib_List emptyCollection = nlib_List.collect();
emptyCollection.firstOrNull();  // null
```



##### ```get()```

Returns the element at the given index.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });
collection.get( 2 ); // 3
```



##### ```getOr()```

Returns the element at the given index or the given value if the index is out of bounds.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });
collection.getOr( 2, 6 );   // 3
collection.getOr( 10, 6 );  // 6
```



##### ```getOrNull()```

Returns the element at the given index or ```null``` if the index is out of bounds.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });
collection.getOrNull( 2 );   // 3
collection.getOrNull( 10 );  // null
```



##### ```getType()```

Returns the system type of the elements in the collection.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });
collection.getType(); // Integer.class
```



##### ```getTypeName()```

Returns the system type name of the elements in the collection.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 });
collection.getType(); // 'Integer'
```


##### ```ifEmptyThrow()```

Throws the given exception if the list is empty, otherwise it returns itself.  
This allows it to be used in a fluent chain of methods. 

```apex
nlib_List collection = nlib_List.collect();
collection.ifEmptyThrow(new MyException('Error message'));  // FATAL_ERROR|MyException: Error message
```


##### ```isEmpty()```

Returns ```true``` if the collection is empty.

```apex
nlib_List.collect().isEmpty();  // true
```


##### ```isNotEmpty()```

Returns ```true``` if the collection is not empty.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).isNotEmpty();  // true
```



##### ```last()```

Returns the last element in the collection.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).last();  // 5
```



##### ```lastOr()```

Returns the last element in the collection or the given value if the list is empty.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).lastOr( 6 );   // 5
nlib_List.collect().lastOr( 6 );                                 // 6
```



##### ```lastOrNull()```

Returns the last element in the collection or ```null``` if the list is empty.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).lastOrNull();  // 5
nlib_List.collect().lastOrNull();                                // null
```



##### ```lastIndex()```

Returns the index of the last element in the collection.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).lastIndex(); // 4
```



##### ```max()```

Returns the maximum value of the collection.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).max(); // 5
```



##### ```min()```

Returns the minimum value of the collection.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).min(); // 1
```



##### ```pluck()```

For use with SObject collections.  
Returns a new collection containing just the values in the given SObject field name.  

```apex
nlib_List collection = nlib_List.collect();
collection.add(new Contact(LastName = 'Smith', MailingState = 'WA'));
collection.add(new Contact(LastName = 'Jones', MailingState = 'NY'));
nlib_List states = collection.pluck('MailingState'); // [ 'WA', 'NY' ]
```



##### ```pluckIds()```

For use with SObject collections.  
Returns a new collection containing the Ids from the records in the collection.

```apex
nlib_List collection = nlib_List.collect([SELECT Id, LastName FROM Contact]);
nlib_List ids = collection.pluckIds(); // [ 003R000001KHEJXIA5, 003R000001KHEJYIA5 ]
```



##### ```prepend()```

Adds the given element to the beginning of the collection.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).prepend( 6 ); // [ 6, 1, 2, 3, 4, 5 ]
```



##### ```pull()```

Removes and returns the element at the given index in the collection.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).pull( 2 ); // returns 3 and the remaining collection is [ 1, 2, 4, 5 ]
```



##### ```remove()```

Removes the element at the given index in the collection.  Returns the remaining collection.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).remove( 2 ); // [ 1, 2, 4, 5 ]
```



##### ```reverse()```

Returns a new collection with the elements in reverse order.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).reverse(); // [ 5, 4, 3, 2, 1 ]
```



##### ```size()```

Returns the number of elements contained in the collection.

```apex
nlib_List.collect(new String[]{ 'A','B','C' }).size(); // 3
```



##### ```slice()```

Returns the elements starting from the given index to the end of the collection.  
Include an optional second parameter to limit the number of elements returned.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).slice( 2 );     // [ 3, 4, 5 ]
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).slice( 2, 2 );  // [ 3, 4 ]
```



##### ```split()```

Splits the collection evenly into the given number of groups.  Returns a list of collections.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }).split( 3 ); // [ [ 1, 2, 3, 4 ], [ 5, 6, 7 ], [ 8, 9, 10 ] ] 
```



##### ```sum()```

For use with collections of numerical values.  Returns the sum of the values in the collection.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).sum(); // 15 
```



##### ```toJson()```

Returns the collection serialized into the json format.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).toJson(); // [1,2,3,4,5]
```
 
 
 
##### ```toPrettyJson()```

Returns the collection serialized into the json format with nicer formatting.

```apex
nlib_List.collect(new Integer[]{ 1, 2, 3, 4, 5 }).toJson(); // [ 1, 2, 3, 4, 5 ]
```



##### ```values()```

Similar to the ```all()``` method.  Returns all the values in the collection.

```apex
nlib_List collection = nlib_List.collect(new Integer[]{ 1, 2, 3 });
(Integer[]) collection.values(); // returns [ 1, 2, 3 ]
 ```

