/**
 * Created by Scott McClung on 9/23/18.
 */

/**
 * todo: Write documentation
 * todo: implement where()
 * todo: implement unique()
 * todo: implement sort()
 * todo: implement contains()
 *
 */




public class nlib_List implements Iterator<Object>
{
  @TestVisible Object[] values;
  @TestVisible Integer pointer;
  @TestVisible String valueType;
  @TestVisible Boolean isSObject;
  
  
  public class IndexOutOfBoundsException extends Exception {}
  public class MalformedCallException extends Exception {}
  public class InvalidTypeException extends Exception {}
  
  
  
  
  /**
   * Combines two collections into a new collection
   *
   * @param collection1
   * @param collection2
   * @return
   */
  public static nlib_List combine( nlib_List lst1, nlib_List lst2 )
  {
    return collect().add( lst1 ).add( lst2 );
  }
  
  
  
  
  /**
   * Combines two lists into a new collection
   *
   * @param items1
   * @param items2
   * @return
   */
  public static nlib_List combine( Object[] items1, Object[] items2 )
  {
    return collect().add( items1 ).add( items2 );
  }
  
  
  
  
  /**
   * Instantiates a new collection
   *
   * @return
   */
  public static nlib_List newInstance()
  {
    return collect();
  }
  
  
  
  
  /**
   * Instantiates a new collection
   *
   * @return
   */
  public static nlib_List collect()
  {
    return new nlib_List();
  }
  
  
  
  
  /**
   * Instantiates a new collection object
   *
   * @param item
   * @return
   */
  public static nlib_List collect( Object item )
  {
    return new nlib_List( item );
  }
  
  
  
  
  /**
   * Instantiates a new collection object
   *
   * @param item
   * @return
   */
  public static nlib_List collect( nlib_List collection )
  {
    return new nlib_List( collection );
  }
  
  
  
  
  /**
   * Instantiates a new collection object
   *
   * @param items
   * @return
   */
  public static nlib_List collect( Object[] items )
  {
    return new nlib_List( items );
  }
  
  
  
  
  /**
   * Instantiates a new collection object from a Database.QueryLocator
   *
   */
  public static nlib_List collect( Database.QueryLocator query )
  {
    nlib_List lst = collect();
    Database.QueryLocatorIterator iterator = query.iterator();
    while(iterator.hasNext()) {
      lst.add( iterator.next() );
    }
    return lst;
  }
  
  
  
  
  /**
   * Constructor
   */
  public nlib_List()
  {
    this( new Object[]{} );
  }
  
  
  
  
  /**
   * Constructor
   *
   * @param item
   */
  @TestVisible
  private nlib_List( Object item )
  {
    this( new Object[]{ item } );
  }
  
  
  
  
  /**
   * Constructor
   *
   * @param item
   */
  @TestVisible
  private nlib_List( nlib_List collection )
  {
    this( collection.all() );
  }
  
  
  
  
  /**
   * Constructor
   *
   * @param lstItems
   */
  @TestVisible
  private nlib_List( Object[] items )
  {
    typeCheck( items );
    this.values = items;
    pointer = 0;
  }
  
  
  
  
  /**
   * Has element in the current pointer position
   *
   * @return
   */
  public Boolean hasCurrent()
  {
    return isNotOutOfBounds( pointer );
  }
  
  
  
  
  /**
   * Has an element in the next pointer position
   *
   * @return
   */
  public Boolean hasNext()
  {
    return canAdvancePointer( 1 );
  }
  
  
  
  
  /**
   * Has an element in the previous pointer position
   *
   * @return
   */
  public Boolean hasPrev()
  {
    return canAdvancePointer( -1 );
  }
  
  
  
  
  /**
   * Return the element in the current pointer position
   * and then advance the pointer by 1
   *
   * @return
   */
  public Object next()
  {
    Object value = get();
    advancePointer( 1 );
    return value;
  }
  
  
  
  
  /**
   * Return the element in the current pointer position
   * and then advance the pointer by -1
   *
   * @return
   */
  public Object prev()
  {
    Object value = get();
    advancePointer( -1 );
    return value;
  }
  
  
  
  
  /**
   *
   * @return
   */
  public Object step()
  {
    return step( 1 );
  }
  
  
  
  
  /**
   * Advance the pointer by a given increment (positive or negative)
   * and return the element in the new position.
   *
   * @param inc
   * @return
   */
  public Object step( Integer inc )
  {
    advancePointer( inc );
    return get();
  }
  
  
  
  
  /**
   * Move pointer to the beginning of the collection
   * and return the element at that position
   *
   * @return
   */
  public Object reset()
  {
    pointer = 0;
    return get();
  }
  
  
  
  
  /**
   * Move pointer to the end of the collection
   * and return the element in that position
   *
   * @return
   */
  public Object end()
  {
    pointer = lastIndex();
    return get();
  }
  
  
  
  
  /**
   * Adds an element to the end of the collection
   *
   * @param item
   * @return
   */
  public nlib_List add( Object item )
  {
    typeCheck( item );
    this.values.add( item );
    return this;
  }
  
  
  
  
  /**
   * Adds a collection to the end of the collection
   *
   * @param item
   * @return
   */
  public nlib_List add( nlib_List lst )
  {
    add( lst.all() );
    return this;
  }
  
  
  
  
  /**
   * Adds a list of elements to the end of the collection
   *
   * @param items
   * @return
   */
  public nlib_List add( Object[] items )
  {
    typeCheck( items );
    this.values.addAll( items );
    return this;
  }
  
  
  
  
  /**
   * Adds an element to the end of the collection unless the
   * condition is true
   *
   * @param item
   * @param condition
   * @return
   */
  public nlib_List addUnless( Object item, Boolean condition )
  {
    return addUnless( new Object[]{ item }, condition );
  }
  
  
  
  
  /**
   * Adds a colleciton to the end of this collection unless the
   * condition is true
   *
   * @param item
   * @param condition
   * @return
   */
  public nlib_List addUnless( nlib_List lst, Boolean condition )
  {
    return addUnless( lst.all(), condition );
  }
  
  
  
  
  /**
   * Adds a list of elements to the end of the collection
   * unless the condition is true
   *
   * @param items
   * @param condition
   * @return
   */
  public nlib_List addUnless( Object[] items, Boolean condition )
  {
    if(!condition) add( items );
    return this;
  }
  
  
  
  
  /**
   * Adds an element to the end of the collection when the
   * condition is true
   *
   * @param item
   * @param condition
   * @return
   */
  public nlib_List addWhen( Object item, Boolean condition )
  {
    return addWhen( new Object[]{ item }, condition );
  }
  
  
  
  
  /**
   * Adds an element to the end of the collection when the
   * condition is true
   *
   * @param lst
   * @param condition
   * @return
   */
  public nlib_List addWhen( nlib_List lst, Boolean condition )
  {
    return addWhen( lst.all(), condition );
  }
  
  
  
  
  /**
   * Adds a list of elements to the end of the collection
   * when the condition is true
   *
   * @param items
   * @param condition
   * @return
   */
  public nlib_List addWhen( Object[] items, Boolean condition )
  {
    if(condition) add( items );
    return this;
  }
  
  
  
  
  /**
   * Returns the collection values as a list
   *
   * @return
   */
  public Object[] all()
  {
    return this.values;
  }
  
  
  
  
  /**
   * Returns the collection values as a list
   *
   * @return
   */
  public Object[] all( Type listType )
  {
    Object[] lst = (Object[]) listType.newInstance();
    lst.addAll( this.values );
    return lst;
  }
  
  
  
  
  /**
   * Return the average of the numeric elements in
   * the collection
   * TODO: implement type checking to ensure this is only
   * called on numeric values.
   *
   * @return
   */
  public Double avg()
  {
    Integer i = size();
    if(i == 0) return 0;
    return ( (Double) sum() ) / i;
  }
  
  
  
  
  public nlib_List[] chunk( Integer size )
  {
    if(isEmpty()) throw new IndexOutOfBoundsException( 'The list is empty.' );
    if(size < 1) return new nlib_List[]{};
    
    nlib_List[] lst = new nlib_List[]{};
    Integer start = 0;
    
    while(start < size()) {
      if(size > 0) lst.add( slice( start, size ) );
      start += size;
    }
    
    return lst;
  }
  
  
  
  
  /**
   * Removes all the elements in the list.
   *
   * @return
   */
  public nlib_List clear()
  {
    this.values.clear();
    this.pointer = 0;
    return this;
  }
  
  
  
  
  /**
   * Return a refernece copy of the collection
   *
   * @return
   */
  public nlib_List copy()
  {
    return nlib_List.collect( all() );
  }
  
  
  
  
  /**
   * Return a clone of the collection
   *
   * @return
   */
  public nlib_List deepCopy()
  {
    return nlib_List.collect( this.values.clone() );
  }
  
  
  
  
  /**
   * Logs the list values to the debug log.
   * Useful for exploring the state of the list during a fluent
   * method chain.
   *
   * @return
   */
  public nlib_List dump()
  {
    System.debug( 'nlib_List dump: ' + this.values );
    return this;
  }
  
  
  
  
  /**
   * Iterates over collection passing each item to a callback
   *
   * @param callbackTypeName
   * @return
   */
  public nlib_List each( String callbackTypeName )
  {
    return each( callbackTypeName, null );
  }
  
  
  
  
  /**
   * Iterates over collection passing each item to a callback
   *
   * @param callbackTypeName
   * @return
   */
  public nlib_List each( String callbackTypeName, Object arg )
  {
    return each( System.Type.forName( callbackTypeName ), arg );
  }
  
  
  
  
  /**
   * Iterates over collection passing each item to a callback
   *
   * @param callbackType
   * @return
   */
  public nlib_List each( Type callbackType )
  {
    return each( callbackType, null );
  }
  
  
  
  
  /**
   * Iterates over collection passing each item to a callback
   *
   * @param callbackType
   * @return
   */
  public nlib_List each( Type callbackType, Object arg )
  {
    return each( (nlib_Func.IFunction) callbackType.newInstance(), arg );
  }
  
  
  
  
  /**
   * Iterates over collection passing each item to a callback
   *
   * @param callback
   * @return
   */
  public nlib_List each( nlib_Func.IFunction callback )
  {
    return each( callback, null );
  }
  
  
  
  
  /**
   * Iterates over collection passing each item to a callback
   *
   * @param callback
   * @return
   */
  public nlib_List each( nlib_Func.IFunction callback, Object arg )
  {
    if(callback instanceof nlib_Func.Callback) {
      ( (nlib_Func.Callback) callback ).setContext( this );
    }
    
    for(Integer i = 0; i < this.values.size(); i++) {
      this.pointer = i;
      callback.call( this.values[ i ], arg );
    }
    this.pointer = 0;
    
    return this;
  }
  
  
  
  
  /**
   * Implements equality checking on the collection
   * TODO: This is a pretty naive implementation.  Improve it.
   *
   * @param items
   * @return
   */
  public Boolean equals( Object[] items )
  {
    return this.values.equals( items );
  }
  
  
  
  
  /**
   * Implements equality checking on the collection
   * TODO: This is a pretty naive implementation.  Improve it.
   *
   * @param items
   * @return
   */
  public Boolean notEquals( Object[] items )
  {
    return !equals( items );
  }
  
  
  
  
  /**
   * Return a new collection without the specified elements
   *
   * @param items
   * @return
   */
  public nlib_List except( Object[] items )
  {
    nlib_List collection = this.clone();
    for(Object item : items) {
      collection.remove( collection.find( item ) );
    }
    return collection;
  }
  
  
  
  
  /**
   * Verify all elements in the collection pass a given truth test
   *
   * @param callbackTypeName
   * @return
   */
  public Boolean every( String callbackTypeName )
  {
    return every( callbackTypeName, null );
  }
  
  
  
  
  /**
   * Verify all elements in the collection pass a given truth test
   *
   * @param callbackTypeName
   * @param arg
   * @return
   */
  public Boolean every( String callbackTypeName, Object arg )
  {
    return every( System.Type.forName( callbackTypeName ), arg );
  }
  
  
  
  
  /**
   * Verify all elements in the collection pass a given truth test
   *
   * @param callbackType
   * @return
   */
  public Boolean every( Type callbackType )
  {
    return every( callbackType, null );
  }
  
  
  
  
  /**
   * Verify all elements in the collection pass a given truth test
   *
   * @param callbackType
   * @param arg
   * @return
   */
  public Boolean every( Type callbackType, Object arg )
  {
    return every( (nlib_Func.IFilter) callbackType.newInstance(), arg );
  }
  
  
  
  
  /**
   * Verify all elements in the collection pass a given truth test
   *
   * @param callback
   * @return
   */
  public Boolean every( nlib_Func.IFilter callback )
  {
    return every( callback, null );
  }
  
  
  
  
  /**
   * Verify all elements in the collection pass a given truth test
   *
   * @param callback
   * @param arg
   * @return
   */
  public Boolean every( nlib_Func.IFilter callback, Object arg )
  {
    if(callback instanceof nlib_Func.Callback) {
      ( (nlib_Func.Callback) callback ).setContext( this );
    }
    
    for(Integer i = 0; i < this.values.size(); i++) {
      this.pointer = i;
      if(!callback.call( this.values[ i ], arg )) {
        this.pointer = 0;
        return false;
      }
    }
    this.pointer = 0;
    
    return true;
  }
  
  
  
  
  /**
   * Filters the collection using the given callback, keeping
   * only the elements that pass a given truth test
   *
   * @param callbackTypeName
   * @return
   */
  public nlib_List filter( String callbackTypeName )
  {
    return filter( callbackTypeName, null );
  }
  
  
  
  
  /**
   * Filters the collection using the given callback, keeping
   * only the elements that pass a given truth test
   *
   * @param callbackTypeName
   * @param arg
   * @return
   */
  public nlib_List filter( String callbackTypeName, Object arg )
  {
    return filter( System.Type.forName( callbackTypeName ), arg );
  }
  
  
  
  
  /**
   * Filters the collection using the given callback, keeping
   * only the elements that pass a given truth test
   *
   * @param callbackType
   * @return
   */
  public nlib_List filter( Type callbackType )
  {
    return filter( callbackType, null );
  }
  
  
  
  
  /**
   * Filters the collection using the given callback, keeping
   * only the elements that pass a given truth test
   *
   * @param callbackType
   * @param arg
   * @return
   */
  public nlib_List filter( Type callbackType, Object arg )
  {
    return filter( (nlib_Func.IFilter) callbackType.newInstance(), arg );
  }
  
  
  
  
  /**
   * Filters the collection using the given callback, keeping
   * only the elements that pass a given truth test
   *
   * @param callback
   * @return
   */
  public nlib_List filter( nlib_Func.IFilter callback )
  {
    return filter( callback, null );
  }
  
  
  
  
  /**
   * Filters the collection using the given callback, keeping
   * only the elements that pass a given truth test
   *
   * @param callback
   * @param arg
   * @return
   */
  public nlib_List filter( nlib_Func.IFilter callback, Object arg )
  {
    if(callback instanceof nlib_Func.Callback) {
      ( (nlib_Func.Callback) callback ).setContext( this );
    }
    
    nlib_List lst = collect();
    
    for(Integer i = 0; i < this.values.size(); i++) {
      this.pointer = i;
      Object item = this.values[ i ];
      lst.addWhen( item, callback.call( item, arg ) );
    }
    this.pointer = 0;
    
    return lst;
  }
  
  
  
  
  /**
   * Return index of matching element
   *
   * @param item
   * @return
   */
  public Integer find( Object item )
  {
    return this.values.indexOf( item );
  }
  
  
  
  
  /**
   * Returns the first element in the collection.
   * Throws an IndexOutOfBoundsException if the list is empty.
   *
   * @return
   */
  public Object first()
  {
    requiresValidIndex( 0, 'The list is empty.' );
    return this.values[ 0 ];
  }
  
  
  
  
  /**
   * Returns the first element in the collection.
   * If the collection is empty, returns the given value.
   *
   * @param default
   * @return
   */
  public Object firstOr( Object value )
  {
    if(isEmpty()) return value;
    return this.values[ 0 ];
  }
  
  
  
  
  /**
   * Returns the first element in the collection.
   * If the collection is empty, will return null
   *
   * @return
   */
  public Object firstOrNull()
  {
    if(isEmpty()) return null;
    return this.values[ 0 ];
  }
  
  
  
  
  /**
   * Return the element at the pointer position.
   *
   * Have to return null when the internal pointer is out of bounds
   * since for loops advance the pointer past the boundary
   * before running it's truth test.
   *
   * @return
   */
  public Object get()
  {
    if(isOutOfBounds( pointer )) return null;
    return this.values[ pointer ];
  }
  
  
  
  
  /**
   * Return the element at the given index.
   * Throws IndexOutOfBoundsException if the list is empty or
   * index is too high
   *
   * @param index
   * @return
   */
  public Object get( Integer index )
  {
    requiresValidIndex( index );
    return this.values.get( index );
  }
  
  
  
  
  /**
   * Return the element at the given index.
   * Returns given value if the list is empty or
   * index is too high
   *
   * @param index
   * @return
   */
  public Object getOr( Integer index, Object value )
  {
    if(isOutOfBounds( index )) return value;
    return this.values.get( index );
  }
  
  
  
  
  /**
   * Return the element at the given index.
   * Returns null if the list is empty or index is too high
   *
   * @param index
   * @return
   */
  public Object getOrNull( Integer index )
  {
    if(isOutOfBounds( index )) return null;
    return this.values.get( index );
  }
  
  
  
  
  /**
   * Return the system type contained in the list
   *
   * @return
   */
  public Type getType()
  {
    if(String.isBlank( this.valueType )) return null;
    return Type.forName( this.valueType );
  }
  
  
  
  
  /**
   * Return the system type name contained in the list
   *
   * @return
   */
  public String getTypeName()
  {
    return this.valueType;
  }
  
  
  
  
  /**
   * Throw a given exception if the collection is empty
   *
   * @param e
   *
   * @return
   */
  public nlib_List ifEmptyThrow( Exception e )
  {
    if(e == null) {
      throw new MalformedCallException( 'Must provide a valid instance of an exception class to be thrown if the collection is empty.' );
    }
    if(isEmpty()) throw e;
    return this;
  }
  
  
  
  /**
   * Is the collection empty
   *
   * @return
   */
  public Boolean isEmpty()
  {
    return this.values.isEmpty();
  }
  
  
  
  
  /**
   * Is the collection not empty
   *
   * @return
   */
  public Boolean isNotEmpty()
  {
    return !isEmpty();
  }
  
  
  
  
  /**
   * Return the last element in the collection.
   * Throws an IndexOutOfBoundsException if the list is empty.
   *
   * @return
   */
  public Object last()
  {
    requiresValidIndex( 0, 'The list is empty.' );
    return this.values[ lastIndex() ];
  }
  
  
  
  
  /**
   * Return the last element in the collection.
   * Returns the given value if the list is empty.
   *
   * @return
   */
  public Object lastOr( Object value )
  {
    if(isEmpty()) return value;
    return this.values[ lastIndex() ];
  }
  
  
  
  
  /**
   * Return the last element in the collection.
   * Returns null if the list is empty.
   *
   * @return
   */
  public Object lastOrNull()
  {
    if(isEmpty()) return null;
    return this.values[ lastindex() ];
  }
  
  
  
  
  /**
   * Return the index of the last element in collection
   *
   * @return
   */
  public Integer lastIndex()
  {
    return size() - 1;  // returns -1 if empty
  }
  
  
  
  
  /**
   * Iterates through the collection passing each element to a
   * given callback.  The callback can modify each element and
   * return it resulting in a new collection
   *
   * @param callbackTypeName
   * @return
   */
  public nlib_List mapp( String callbackTypeName )
  {
    return mapp( callbackTypeName, null );
  }
  
  
  
  
  /**
   * Iterates through the collection passing each element to a
   * given callback.  The callback can modify each element and
   * return it resulting in a new collection
   *
   * @param callbackTypeName
   * @param arg
   * @return
   */
  public nlib_List mapp( String callbackTypeName, Object arg )
  {
    return mapp( System.Type.forName( callbackTypeName ), arg );
  }
  
  
  
  
  /**
   * Iterates through the collection passing each element to a
   * given callback.  The callback can modify each element and
   * return it resulting in a new collection
   *
   * @param callbackType
   * @return
   */
  public nlib_List mapp( Type callbackType )
  {
    return mapp( callbackType, null );
  }
  
  
  
  
  /**
   * Iterates through the collection passing each element to a
   * given callback.  The callback can modify each element and
   * return it resulting in a new collection
   *
   * @param callbackType
   * @param arg
   * @return
   */
  public nlib_List mapp( Type callbackType, Object arg )
  {
    return mapp( (nlib_Func.ITransform) callbackType.newInstance(), arg );
  }
  
  
  
  
  /**
   * Iterates through the collection passing each element to a
   * given callback.  The callback can modify each element and
   * return it resulting in a new collection
   *
   * @param callback
   * @return
   */
  public nlib_List mapp( nlib_Func.ITransform callback )
  {
    return mapp( callback, null );
  }
  
  
  
  
  /**
   * Iterates through the collection passing each element to a
   * given callback.  The callback can modify each element and
   * return it resulting in a new collection
   *
   * @param callback
   * @param arg
   * @return
   */
  public nlib_List mapp( nlib_Func.ITransform callback, Object arg )
  {
    if(callback instanceof nlib_Func.Callback) {
      ( (nlib_Func.Callback) callback ).setContext( this );
    }
    
    nlib_List lst = collect();
    
    for(Integer i = 0; i < this.values.size(); i++) {
      this.pointer = i;
      lst.add( callback.call( this.values[ i ], arg ) );
    }
    this.pointer = 0;
    
    return lst;
  }
  
  
  
  
  /**
   * Returns the maximum value of collection
   *
   * @return
   */
  public Object max()
  {
    if(isEmpty()) throw new IndexOutOfBoundsException( 'The list is empty.' );
    return reduce( nlib_Func.Max );
  }
  
  
  
  
  /**
   * Returns the minimum value of the collection
   *
   * @return
   */
  public Object min()
  {
    if(isEmpty()) throw new IndexOutOfBoundsException( 'The list is empty.' );
    return reduce( nlib_Func.Min );
  }
  
  
  
  
  /**
   * Return a new collection containing just the values from the
   * given SObject field name
   *
   * @param fieldName
   * @return
   */
  public nlib_List pluck( String fieldName )
  {
    if(!isSObjectType()) throw new MalformedCallException( 'The pluck method is only available for SObject collections' );
    return mapp( nlib_Func.Pluck, fieldName );
  }
  
  
  
  
  /**
   * Returns the collection of Ids from collection of SObjects
   *
   * @return
   */
  public nlib_List pluckIds()
  {
    if(!isSObjectType()) throw new MalformedCallException( 'The pluckIds method is only available for SObject collections' );
    nlib_List lst = new nlib_List( new Id[]{} );
    return lst.add( mapp( nlib_Func.PluckId ) );
  }
  
  
  
  
  /**
   * Adds an element to the beginning of the collection
   *
   * @param item
   * @return
   */
  public nlib_List prepend( Object item )
  {
    if(isEmpty()) {
      add( item );
    } else {
      this.values.add( 0, item );
    }
    return this;
  }
  
  
  
  
  /**
   * Removes and returns the element in the pointer
   * position
   *
   * @return
   */
  public Object pull()
  {
    return pull( pointer );
  }
  
  
  
  
  /**
   * Removes and returns the element at the index position
   *
   * @param index
   * @return
   */
  public Object pull( Integer index )
  {
    requiresValidIndex( index, 'The list is empty.' );
    return this.values.remove( index );
  }
  
  
  
  
  /**
   * Reduces the collection to a single value, passing the result
   * of each iteration to the subsequent iteration
   *
   * @param accumulator
   * @return
   */
  public Object reduce( String callbackTypeName )
  {
    return reduce( callbackTypeName, null );
  }
  
  
  
  
  /**
   * Reduces the collection to a single value, passing the result
   * of each iteration to the subsequent iteration
   *
   * @param accumulatorName
   * @param defaultAccumulationValue
   * @return
   */
  public Object reduce( String callbackTypeName, Object defaultAccumulationValue )
  {
    return reduce( callbackTypeName, defaultAccumulationValue, null );
  }
  
  
  
  
  /**
   * Reduces the collection to a single value, passing the result
   * of each iteration to the subsequent iteration
   *
   * @param accumulatorName
   * @param defaultAccumulationValue
   * @param arg
   * @return
   */
  public Object reduce( String callbackTypeName, Object defaultAccumulationValue, Object arg )
  {
    return reduce( System.Type.forName( callbackTypeName ), defaultAccumulationValue, arg );
  }
  
  
  
  
  /**
   * Reduces the collection to a single value, passing the result
   * of each iteration to the subsequent iteration
   *
   * @param accumulator
   * @return
   */
  public Object reduce( Type callbackType )
  {
    return reduce( callbackType, null );
  }
  
  
  
  
  /**
   * Reduces the collection to a single value, passing the result
   * of each iteration to the subsequent iteration
   *
   * @param accumulatorType
   * @param defaultAccumulationValue
   * @return
   */
  public Object reduce( Type callbackType, Object defaultAccumulationValue )
  {
    return reduce( callbackType, defaultAccumulationValue, null );
  }
  
  
  
  
  /**
   * Reduces the collection to a single value, passing the result
   * of each iteration to the subsequent iteration
   *
   * @param accumulatorType
   * @param defaultAccumulationValue
   * @param arg
   * @return
   */
  public Object reduce( Type callbackType, Object defaultAccumulationValue, Object arg )
  {
    return reduce( (nlib_Func.IReduce) callbackType.newInstance(), defaultAccumulationValue, arg );
  }
  
  
  
  
  /**
   * Reduces the collection to a single value, passing the result
   * of each iteration to the subsequent iteration
   *
   * @param accumulator
   * @return
   */
  public Object reduce( nlib_Func.IReduce callback )
  {
    return reduce( callback, null );
  }
  
  
  
  
  /**
   * Reduces the collection to a single value, passing the result
   * of each iteration to the subsequent iteration
   *
   * @param accumulator
   * @param defaultAccumulationValue
   * @return
   */
  public Object reduce( nlib_Func.IReduce callback, Object defaultAccumulationValue )
  {
    return reduce( callback, defaultAccumulationValue, null );
  }
  
  
  
  
  /**
   * Reduces the collection to a single value, passing the result
   * of each iteration to the subsequent iteration
   *
   * @param accumulator
   * @param defaultAccumulationValue
   * @param arg
   * @return
   */
  public Object reduce( nlib_Func.IReduce callback, Object defaultAccumulationValue, Object arg )
  {
    if(callback instanceof nlib_Func.Callback) {
      ( (nlib_Func.Callback) callback ).setContext( this );
    }
    
    Object accumulation = defaultAccumulationValue;
    
    for(Integer i = 0; i < this.values.size(); i++) {
      this.pointer = i;
      accumulation = callback.call( accumulation, this.values[ i ], arg );
    }
    this.pointer = 0;
    
    return accumulation;
  }
  
  
  
  
  /**
   * Filters the collection using the given callback.  The callback
   * should return true if the element should be removed from
   * the resulting collection
   *
   * @param callbackTypeName
   * @return
   */
  public nlib_List reject( String callbackTypeName )
  {
    return reject( callbackTypeName, null );
  }
  
  
  
  
  /**
   * Filters the collection using the given callback.  The callback
   * should return true if the element should be removed from
   * the resulting collection
   *
   * @param callbackTypeName
   * @param arg
   * @return
   */
  public nlib_List reject( String callbackTypeName, Object arg )
  {
    return reject( System.Type.forName( callbackTypeName ), arg );
  }
  
  
  
  
  /**
   * Filters the collection using the given callback.  The callback
   * should return true if the element should be removed from
   * the resulting collection
   *
   * @param callbackType
   * @return
   */
  public nlib_List reject( Type callbackType )
  {
    return reject( callbackType, null );
  }
  
  
  
  
  /**
   * Filters the collection using the given callback.  The callback
   * should return true if the element should be removed from
   * the resulting collection
   *
   * @param callbackType
   * @param arg
   * @return
   */
  public nlib_List reject( Type callbackType, Object arg )
  {
    return reject( (nlib_Func.IFilter) callbackType.newInstance(), arg );
  }
  
  
  
  
  /**
   * Filters the collection using the given callback.  The callback
   * should return true if the element should be removed from
   * the resulting collection
   *
   * @param callback
   * @return
   */
  public nlib_List reject( nlib_Func.IFilter callback )
  {
    return reject( callback, null );
  }
  
  
  
  
  /**
   * Filters the collection using the given callback.  The callback
   * should return true if the element should be removed from
   * the resulting collection
   *
   * @param callback
   * @param arg
   * @return
   */
  public nlib_List reject( nlib_Func.IFilter callback, Object arg )
  {
    if(callback instanceof nlib_Func.Callback) {
      ( (nlib_Func.Callback) callback ).setContext( this );
    }
    
    nlib_List lst = collect();
    
    for(Integer i = 0; i < this.values.size(); i++) {
      this.pointer = i;
      Object item = this.values[ i ];
      lst.addUnless( item, callback.call( item, arg ) );
    }
    this.pointer = 0;
    
    return lst;
  }
  
  
  
  
  /**
   * Removes the element at the given index and returns the
   * resulting collection
   *
   * @param index
   * @return
   */
  public nlib_List remove( Integer index )
  {
    if(isEmpty()) return this;
    requiresValidIndex( index );
    this.values.remove( index );
    return this;
  }
  
  
  
  
  /**
   * Returns a new collection with the elements in reverse order
   *
   * @return
   */
  public nlib_List reverse()
  {
    nlib_List lst = newInstance();
    for(Object item : this.values) {
      lst.prepend( item );
    }
    return lst;
  }
  
  
  
  
  /**
   * Return the number of elements in the collection
   *
   * @return
   */
  public Integer size()
  {
    return this.values.size();
  }
  
  
  
  
  /**
   * Returns a slice of the collection starting at a given index
   *
   * @param startIndex
   * @return
   */
  public nlib_List slice( Integer index )
  {
    requiresValidIndex( index );
    nlib_List lst = this.deepCopy().clear();
    for(Integer i = index; i <= lastIndex(); i++) {
      lst.add( get( i ) );
    }
    return lst;
  }
  
  
  
  
  /**
   * Returns a slice of the collection starting at a given index
   * and limited to the specified length
   *
   * @param index
   * @param length
   * @return
   */
  public nlib_List slice( Integer index, Integer length )
  {
    requiresValidIndex( index );
//    Integer lastIndex = index + length <= size() ? index + length : size();
    Integer lastIndex = index + (length - 1) <= lastIndex() ? index + (length - 1) : lastIndex();
    
    nlib_List lst = this.deepCopy().clear();
    for(Integer i = index; i <= lastIndex; i++) {
      lst.add( get( i ) );
    }
    return lst;
  }
  
  
  
  
  /**
   * Returns a new collection sorted according the rules in the given callback
   *
   * @param callbackTypeName
   * @return
   */
  public nlib_List sort( String callbackTypeName )
  {
    return sort( System.Type.forName( callbackTypeName ) );
  }
  
  
  
  
  /**
   * Returns a new collection sorted according the rules in the given callback
   *
   * @param callback
   * @return
   */
  public nlib_List sort( Type callbackType )
  {
    return sort( (nlib_Func.IOrder) callbackType.newInstance() );
  }
  
  
  
  
  /**
   * Returns a new collection sorted according the rules in the given callback
   *
   * @param callback
   * @return
   */
  public nlib_List sort( nlib_Func.IOrder callback )
  {
    if(callback instanceof nlib_Func.Callback) {
      ( (nlib_Func.Callback) callback ).setContext( this );
    }
    
    if(size() < 2) return this.deepCopy();
    
    Object chosen = get( lastIndex() );
    
    nlib_List a = nlib_List.collect();
    nlib_List b = nlib_List.collect();
    
    for(Integer i = 0; i < lastIndex(); i++) {
      Object temp = get( i );
      if(callback.call( temp, chosen )) {  // temp < chosen
        a.add( temp );
        continue;
      }
      b.add( temp );
    }
    
    // create a copy of this collection so the result has the correct type
    nlib_List output = copy().clear()
      .add( a.sort( callback ) )
      .add( chosen )
      .add( b.sort( callback ) );
    
    return output;
  }
  
  
  
  
  /**
   * Breaks the collection up into a given number of groups
   *
   * @param groups
   * @return
   */
  public nlib_List[] split( Integer groups )
  {
    if(isEmpty()) throw new IndexOutOfBoundsException( 'The list is empty.' );
    if(groups < 1) return new nlib_List[]{};
    
    nlib_List[] lst = new nlib_List[]{};
    Integer groupSize = (Integer) Math.floor( (Double) size() / (Double) groups );
//    Integer remainder = (Integer) Math.mod( size(), groupSize );
    Integer remainder = (Integer) (size() - (groups * groupSize));
    Integer start = 0;
    
    for(Integer i = 0; i < groups; i++) {
      Integer size = groupSize;
      
      if(i < remainder) size++;
      if(size > 0) lst.add( slice( start, size ) );
      
      start += size;
    }
    
    return lst;
  }
  
  
  
  
  /**
   * Sums numeric values in the collection
   * TODO: Add type checking to ensure this only runs for numeric types
   *
   * @return
   */
  public Object sum()
  {
    if(isEmpty()) throw new IndexOutOfBoundsException( 'The list is empty.' );
    return reduce( nlib_Func.Sum, 0 );
  }
  
  
  
  
  /**
   * Iterates over collection a specified number of times.
   * Passes the iteration counter to the callback
   *
   * @param callbackName
   * @param iterations
   * @return
   */
  public nlib_List times( String callbackName, Integer iterations )
  {
    return times( callbackName, iterations, null );
  }
  
  
  
  
  /**
   * Iterates over collection a specified number of times.
   * Passes the iteration counter to the callback
   *
   * @param callbackName
   * @param iterations
   * @param arg
   * @return
   */
  public nlib_List times( String callbackName, Integer iterations, Object arg )
  {
    return times( System.Type.forName( callbackName ), iterations, arg );
  }
  
  
  
  
  /**
   * Iterates over collection a specified number of times.
   * Passes the iteration counter to the callback
   *
   * @param callbackType
   * @param iterations
   * @return
   */
  public nlib_List times( Type callbackType, Integer iterations )
  {
    return times( callbackType, iterations, null );
  }
  
  
  
  
  /**
   * Iterates over collection a specified number of times.
   * Passes the iteration counter to the callback
   *
   * @param callbackType
   * @param iterations
   * @param arg
   * @return
   */
  public nlib_List times( Type callbackType, Integer iterations, Object arg )
  {
    return times( (nlib_Func.ITransform) callbackType.newInstance(), iterations, arg );
  }
  
  
  
  
  /**
   * Iterates over collection a specified number of times.
   * Passes the iteration counter to the callback
   *
   * @param callback
   * @param iterations
   * @return
   */
  public nlib_List times( nlib_Func.ITransform callback, Integer iterations )
  {
    return times( callback, iterations, null );
  }
  
  
  
  
  /**
   * Iterates over collection a specified number of times.
   * Passes the iteration counter to the callback
   * TODO: Finish flushing out the tests for times method
   *
   * @param callback
   * @param iterations
   * @param arg
   * @return
   */
  public nlib_List times( nlib_Func.ITransform callback, Integer iterations, Object arg )
  {
    if(callback instanceof nlib_Func.Callback) {
      ( (nlib_Func.Callback) callback ).setContext( this );
    }
    
    nlib_List lst = nlib_List.collect();
    if(iterations < 1) return lst;
    
    for(Integer i = 0; i < iterations; i++) {
      lst.add( callback.call( i, arg ) );
    }
    return lst;
  }
  
  
  
  
  /**
   * Serialize the collection as a json string
   *
   * @return
   */
  public String toJson()
  {
    return JSON.serialize( this.values );
  }
  
  
  
  
  /**
   * Serialize the collection as a json string with indentations
   *
   * @return
   */
  public String toPrettyJson()
  {
    return JSON.serializePretty( this.values );
  }
  
  
  
  
  /**
   * Return all the values in the collection
   *
   * @return
   */
  public Object[] values()
  {
    return this.values;
  }
  
  
  
  
  /**
   * Advance the pointer by the given increment (positive or negative)
   * while not exceeding the outer limits of the collection.
   *
   * @param inc
   */
  @TestVisible
  void advancePointer( Integer inc )
  {
    if(isEmpty()) {
      pointer = 0;
    } else if(pointer + inc < 0) {
      pointer = -1;
    } else if(pointer + inc > lastIndex()) {
      pointer = lastIndex() + 1;
    } else {
      pointer += inc;
    }
  }
  
  
  
  
  /**
   * Determines if advancing the pointer by the given
   * increment would exceed the limits of the collection.
   *
   * @param inc
   * @return
   */
  Boolean canAdvancePointer( Integer inc )
  {
    if(isEmpty()) return false;
    if(pointer + inc < -1) return false;
    if(pointer + inc > lastIndex() + 1) return false;
    return true;
  }
  
  
  
  
  /**
   * Throws out of bounds exception if index is outside
   * the valid number of elements in the collection
   *
   * @param index
   */
  void requiresValidIndex( Integer index )
  {
    requiresValidIndex( index, 'There is no element at index ' + index );
  }
  
  
  
  
  /**
   * Throws out of bounds exception if index is outside
   * the valid number of elements in the collection
   *
   * @param index
   */
  void requiresValidIndex( Integer index, String message )
  {
    if(isOutOfBounds( index ))
      throw new IndexOutOfBoundsException( message );
  }
  
  
  
  
  /**
   * Is the index outside the valid number of elements
   * contained in the collection
   *
   * @param index
   * @return
   */
  Boolean isNotOutOfBounds( Integer index )
  {
    return !isOutOfBounds( index );
  }
  
  
  
  
  /**
   * Is the index outside the valid number of elements
   * contained in the collection
   *
   * @param index
   * @return
   */
  Boolean isOutOfBounds( Integer index )
  {
    return isEmpty() || index < 0 || index > lastIndex();
  }
  
  
  
  
  Boolean isSObjectType()
  {
    if(this.values instanceof List<SObject>) return true;
    return false;
  }
  
  
  
  
  void typeCheck( Object[] lst )
  {
    if(lst == null || lst.isEmpty()) return;
    for(Object o : lst) typeCheck( o );
  }
  
  
  
  
  void typeCheck( Object o )
  {
    if(o == null) return;
    if(String.isBlank( this.valueType )) setType( o );
    if(getTypeName( o ) != this.valueType) {
      throw new InvalidTypeException( 'Invalid type' );
    }
  }
  
  
  
  
  void setType( Object o )
  {
    if(o == null) return;
    String name = getTypeName( o );
    if(String.isNotBlank( name )) this.valueType = name;
  }
  
  
  
  
  String getTypeName( Object o )
  {
    return new TypeInspector().getTypeName( o );
  }
  
  
  
  
  class TypeInspector
  {
    public System.Type getType( Object o )
    {
      return System.Type.forName( getTypeName( o ) );
    }
    
    public String getTypeName( Object o )
    {
      try {
        if(o == null) return '';
        if(o instanceof SObject) return ( (SObject) o ).getSObjectType().getDescribe().getName() + '';
        if(o instanceof Boolean) return 'Boolean';
        if(o instanceof Id) return 'Id';
        if(o instanceof String) return 'String';
        if(o instanceof Blob) return 'Blob';
        if(o instanceof String) return 'String';
        if(o instanceof Integer) return 'Integer';
        if(o instanceof Long) return 'Long';
        if(o instanceof Time) return 'Time';
        if(o instanceof Date) return 'Date';
        if(o instanceof Datetime) return 'Datetime';
        return getOtherTypes( o );
      } catch(Exception e) {
        return 'Object';
      }
    }
    
    String getOtherTypes( Object o )
    {
      String result = 'DateTime';
      try {
        DateTime typeCheck = (DateTime) o;
      } catch(System.TypeException e) {
        result = e.getMessage()
          .substringAfter( 'Invalid conversion from runtime type ' )
          .substringBefore( ' to Datetime' );
      }
      return result;
    }
  }
}