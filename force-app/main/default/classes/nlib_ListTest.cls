/**
 * Created by Scott McClung on 9/23/18.
 */

@IsTest
private class nlib_ListTest
{
  public class TestException extends Exception {}
  
  
  
  
  @IsTest
  static void itShouldCombineTwoListsIntoNewList()
  {
    nlib_List lst1 = nlib_List.collect( new String[]{ 'value1', 'value2' } );
    nlib_List lst2 = nlib_List.collect( new String[]{ 'value3', 'value4' } );
    nlib_List lst3 = nlib_List.combine( lst1, lst2 );
    System.assertEquals( 2, lst1.size() );
    System.assertEquals( 2, lst2.size() );
    System.assertEquals( 4, lst3.size() );
    System.assertEquals( 'value1', lst3.get( 0 ) );
    System.assertEquals( 'value2', lst3.get( 1 ) );
    System.assertEquals( 'value3', lst3.get( 2 ) );
    System.assertEquals( 'value4', lst3.get( 3 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldCombineTwoNativeListsIntoNewList()
  {
    String[] lst1 = new String[]{ 'value1', 'value2' };
    String[] lst2 = new String[]{ 'value3', 'value4' };
    nlib_List lst3 = nlib_List.combine( lst1, lst2 );
    System.assertEquals( 2, lst1.size() );
    System.assertEquals( 2, lst2.size() );
    System.assertEquals( 4, lst3.size() );
    System.assertEquals( 'value1', lst3.get( 0 ) );
    System.assertEquals( 'value2', lst3.get( 1 ) );
    System.assertEquals( 'value3', lst3.get( 2 ) );
    System.assertEquals( 'value4', lst3.get( 3 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldConstructAnEmptyList()
  {
    System.assertEquals( 0, nlib_List.collect().all().size() );
  }
  
  
  
  
  @IsTest
  static void itShouldConstructAListFromOneItem()
  {
    System.assertEquals( 1, nlib_List.collect( 'value' ).all().size() );
  }
  
  
  
  
  @IsTest
  static void itShouldConstructAListFromANativeList()
  {
    nlib_List lst = nlib_List.collect( new String[]{ 'value1', 'value2' } );
    System.assertEquals( 2, lst.all().size() );
  }
  
  
  
  
  @IsTest
  static void itShouldConstructAListFromExistingList()
  {
    nlib_List lst = nlib_List.collect( new String[]{ 'value1', 'value2' } );
    System.assertEquals( 2, nlib_List.collect( lst ).all().size() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTheType()
  {
    System.assertEquals( Boolean.class, nlib_List.collect( true ).getType() );
    System.assertEquals( String.class, nlib_List.collect( 'value' ).getType() );
    System.assertEquals( Integer.class, nlib_List.collect( Integer.valueOf( 1 ) ).getType() );
    System.assertEquals( Long.class, nlib_List.collect( Long.valueOf( '123456789' ) ).getType() );
    System.assertEquals( Decimal.class, nlib_List.collect( Decimal.valueOf( '1.0' ) ).getType() );
    System.assertEquals( Double.class, nlib_List.collect( Double.valueOf( '1.234567890000' ) ).getType() );
    System.assertEquals( Date.class, nlib_List.collect( Date.today() ).getType() );
    System.assertEquals( Datetime.class, nlib_List.collect( Datetime.now() ).getType() );
    System.assertEquals( Time.class, nlib_List.collect( Datetime.now().time() ).getType() );
    System.assertEquals( List<Integer>.class, nlib_List.collect( new Object[]{ new Integer[]{ 1 } } ).getType() );
    System.assertEquals( List<String>.class, nlib_List.collect( new Object[]{ new String[]{ '1' } } ).getType() );
    System.assertEquals( List<Date>.class, nlib_List.collect( new Object[]{ new Date[]{ Date.today() } } ).getType() );
    System.assertEquals( List<Datetime>.class, nlib_List.collect( new Object[]{ new Datetime[]{ Datetime.now() } } ).getType() );
    System.assertEquals( Lead.class, nlib_List.collect( new Lead() ).getType() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTheTypeName()
  {
    System.assertEquals( 'Boolean', nlib_List.collect( true ).getTypeName() );
    System.assertEquals( 'String', nlib_List.collect( 'value' ).getTypeName() );
    System.assertEquals( 'Integer', nlib_List.collect( Integer.valueOf( 1 ) ).getTypeName() );
    System.assertEquals( 'Long', nlib_List.collect( Long.valueOf( '123456789' ) ).getTypeName() );
    System.assertEquals( 'Decimal', nlib_List.collect( Decimal.valueOf( '1.0' ) ).getTypeName() );
    System.assertEquals( 'Double', nlib_List.collect( Double.valueOf( '1.234567890000' ) ).getTypeName() );
    System.assertEquals( 'Date', nlib_List.collect( Date.today() ).getTypeName() );
    System.assertEquals( 'Datetime', nlib_List.collect( Datetime.now() ).getTypeName() );
    System.assertEquals( 'Time', nlib_List.collect( Datetime.now().time() ).getTypeName() );
    System.assertEquals( 'List<Integer>', nlib_List.collect( new Object[]{ new Integer[]{ 1 } } ).getTypeName() );
    System.assertEquals( 'List<String>', nlib_List.collect( new Object[]{ new String[]{ '1' } } ).getTypeName() );
    System.assertEquals( 'List<Date>', nlib_List.collect( new Object[]{ new Date[]{ Date.today() } } ).getTypeName() );
    System.assertEquals( 'List<Datetime>', nlib_List.collect( new Object[]{ new Datetime[]{ Datetime.now() } } ).getTypeName() );
    System.assertEquals( 'Lead', nlib_List.collect( new Lead() ).getTypeName() );
  }
  
  
  
  
  @IsTest
  static void itShouldOnlyAllowOneTypeInTheList()
  {
    nlib_List lst = nlib_List.collect( new String[]{ 'value1', 'value2' } );
    System.assertEquals( 2, lst.size() );
    
    nlib_List lst1 = nlib_List.collect( 'value' );
    System.assertEquals( String.class, lst1.getType() );
    try {
      lst1.add( 1 );
    } catch(nlib_List.InvalidTypeException e) {
      System.assertEquals( 'Invalid type', e.getMessage() );
    }
    
    nlib_List lst2 = nlib_List.collect();
    try {
      lst2.add( new Object[]{ '1', 2 } );
    } catch(nlib_List.InvalidTypeException e) {
      System.assertEquals( 'Invalid type', e.getMessage() );
      System.debug( lst2 );
    }
  }
  
  
  
  
  // Iterator methods
  
  /**
   * The standard iterator while loop configuration
   * requires that the pointer is allowed to exceed
   * the limit of the collection (positive or negative)
   * by 1.
   */
  @IsTest
  static void itShouldHaveNext()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assert( lst.hasNext() );
    System.assertEquals( 0, lst.pointer );
    
    lst.advancePointer( 1 );
    System.assertEquals( 1, lst.pointer );
    System.assert( lst.hasNext() );
    
    lst.advancePointer( 1 );
    System.assertEquals( 2, lst.pointer );
    
    lst.advancePointer( 1 );
    System.assertEquals( 3, lst.pointer );
    System.assertEquals( false, lst.hasNext() );
  }
  
  
  
  /**
   * The standard iterator while loop configuration
   * requires that the pointer is allowed to exceed
   * the limit of the collection (positive or negative)
   * by 1.
   */
  @IsTest
  static void itShouldHavePrev()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    lst.end();
    
    System.assertEquals( 2, lst.pointer );
    System.assert( lst.hasPrev() );
    
    lst.advancePointer( -1 );
    System.assertEquals( 1, lst.pointer );
    System.assert( lst.hasPrev() );
    
    lst.advancePointer( -1 );
    System.assertEquals( 0, lst.pointer );
    
    lst.advancePointer( -1 );
    System.assertEquals( -1, lst.pointer );
    System.assertEquals( false, lst.hasPrev() );
  }
  
  
  
  
  /**
   * The standard iterator while loop configuration
   * requires that the pointer is allowed to exceed
   * the limit of the collection (positive or negative)
   * by 1.
   * HasCurrent returns true if we're within the true bounds
   * of the collection.
   */
  @IsTest
  static void itShouldHaveCurrent()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 0, lst.pointer );
    System.assert( lst.hasCurrent() );
    lst.step( -1 );
    System.assertEquals( false, lst.hasCurrent() );
    lst.end();
    System.assert( lst.hasCurrent() );
    lst.step( 1 );
    System.assertEquals( false, lst.hasCurrent() );
  }
  
  
  
  
  /**
   * The standard iterator while loop configuration
   * requires that the pointer is allowed to exceed
   * the limit of the collection (positive or negative)
   * by 1.
   */
  @IsTest
  static void itShouldAdvanceToNext()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 0, lst.pointer );
    
    System.assertEquals( 1, lst.next() ); // returns value prior to advancing the pointer
    System.assertEquals( 1, lst.pointer );
    System.assertEquals( 2, lst.next() ); // returns value prior to advancing the pointer
    System.assertEquals( 2, lst.pointer );
    System.assertEquals( 3, lst.next() ); // returns value prior to advancing the pointer
    System.assertEquals( 3, lst.pointer );
    System.assertEquals( null, lst.next() ); // returns value prior to advancing the pointer
    System.assertEquals( 3, lst.pointer ); // won't advance any further
  }
  
  
  
  
  /**
   * The standard iterator while loop configuration
   * requires that the pointer is allowed to exceed
   * the limit of the collection (positive or negative)
   * by 1.
   */
  @IsTest
  static void itShouldAdvanceToPrev()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    lst.end();
    System.assertEquals( 2, lst.pointer );
    
    System.assertEquals( 3, lst.prev() ); // returns value prior to advancing the pointer
    System.assertEquals( 1, lst.pointer );
    System.assertEquals( 2, lst.prev() ); // returns value prior to advancing the pointer
    System.assertEquals( 0, lst.pointer );
    System.assertEquals( 1, lst.prev() ); // returns value prior to advancing the pointer
    System.assertEquals( -1, lst.pointer );
    System.assertEquals( null, lst.prev() ); // returns value prior to advancing the pointer
    System.assertEquals( -1, lst.pointer ); // won't advance any further
  }
  
  
  
  /**
   * Step function is designed to be used to construct
   * a for loop over the collection.
   * Steps forward through collection by 1 with no arguments (e.g. lst.step() )
   * Steps forward through collection by given integer (e.g. lst.step(4) )
   * Steps through collection in reverse by given negative integer (e.g. lst.step(-1) )
   *
   * e.g.
   * nlib_List lst = nlib_List.collect(<values>);
   * for(Object o = lst.reset(); lst.hasCurrent(); o = lst.step(<int>) {
   *    System.debug(o);
   * }
   */
  @IsTest
  static void itShouldStepThroughList()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 0, lst.pointer );
    System.assertEquals( 2, lst.step() ); // returns value after advancing the pointer
    System.assertEquals( 1, lst.pointer );
    System.assertEquals( 3, lst.step( 1 ) ); // returns value after advancing the pointer
    System.assertEquals( 2, lst.pointer );
    
    System.assertEquals( null, lst.step( 1 ) ); // returns value after advancing the pointer
    
    System.assertEquals( 3, lst.pointer );
    System.assertEquals( 3, lst.step( -1 ) ); // returns value after advancing the pointer
    System.assertEquals( 2, lst.pointer );
    System.assertEquals( 2, lst.step( -1 ) ); // returns value after advancing the pointer
    System.assertEquals( 1, lst.pointer );
    System.assertEquals( 1, lst.step( -1 ) ); // returns value after advancing the pointer
    System.assertEquals( 0, lst.pointer );
    System.assertEquals( null, lst.step( -1 ) ); // returns value after advancing the pointer
  }
  
  
  
  
  @IsTest
  static void itShouldResetPointerToFirstPostion()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 0, lst.pointer );
    lst.step( 2 );
    System.assertEquals( 2, lst.pointer );
    lst.reset();
    System.assertEquals( 0, lst.pointer );
  }
  
  
  
  
  @IsTest
  static void itShouldMovePointerToEndOfList()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 0, lst.pointer );
    lst.end();
    System.assertEquals( 2, lst.pointer );
  }
  
  
  
  
  @IsTest
  static void itShouldLoopThroughList()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    
    // While loop
    Integer sum = 0;
    while(lst.hasNext()) {
      sum += (Integer) lst.next();
    }
    System.assertEquals( 6, sum );
    
    
    // For loop using internal pointer
    sum = 0;
    for(Integer x = (Integer) lst.reset(); lst.hasCurrent(); x = (Integer) lst.step()) {
      sum += x;
    }
    System.assertEquals( 6, sum );
    
    
    // For loop not using internal pointer
    sum = 0;
    for(Integer i = 0; i <= lst.lastIndex(); i++) {
      sum += (Integer) lst.get( i );
    }
    System.assertEquals( 6, sum );
  }
  
  
  
  
  @IsTest
  static void itShouldAddItem()
  {
    nlib_List lst = nlib_List.collect();
    lst.add( 'value' );
    System.assertEquals( 1, lst.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldAddMultipleItems()
  {
    nlib_List lst = nlib_List.collect();
    lst.add( new String[]{ 'value1', 'value2' } );
    System.assertEquals( 2, lst.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldAddItemsFromExistingList()
  {
    nlib_List lst1 = nlib_List.collect( new String[]{ 'value1', 'value2' } );
    nlib_List lst2 = nlib_List.collect( new String[]{ 'value3', 'value4' } );
    System.assertEquals( 2, lst1.size() );
    System.assertEquals( 2, lst2.size() );
    System.assertEquals( 4, lst1.add( lst2 ).size() );
  }
  
  
  
  
  @IsTest
  static void itShouldAddSingleItemUnlessConditionTrue()
  {
    nlib_List lst = nlib_List.collect();
    lst.addUnless( 'value', true );
    System.assertEquals( 0, lst.size() );
    lst.addUnless( 'value', false );
    System.assertEquals( 1, lst.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldAddMultipleItemsUnlessConditionTrue()
  {
    nlib_List lst = nlib_List.collect();
    lst.addUnless( new String[]{ 'value1', 'value2' }, true );
    System.assertEquals( 0, lst.size() );
    lst.addUnless( new String[]{ 'value1', 'value2' }, false );
    System.assertEquals( 2, lst.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldAddExistingListUnlessConditionTrue()
  {
    nlib_List lst1 = nlib_List.collect();
    nlib_List lst2 = nlib_List.collect( new String[]{ 'value1', 'value2' } );
    lst1.addUnless( lst2, true );
    System.assertEquals( 0, lst1.size() );
    lst1.addUnless( lst2, false );
    System.assertEquals( 2, lst1.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldAddSingleItemWhenConditionTrue()
  {
    nlib_List lst = nlib_List.collect();
    lst.addWhen( 'value', false );
    System.assertEquals( 0, lst.size() );
    lst.addWhen( 'value', true );
    System.assertEquals( 1, lst.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldAddMultipleItemsWhenConditionTrue()
  {
    nlib_List lst = nlib_List.collect();
    lst.addWhen( new String[]{ 'value1', 'value2' }, false );
    System.assertEquals( 0, lst.size() );
    lst.addWhen( new String[]{ 'value1', 'value2' }, true );
    System.assertEquals( 2, lst.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldAddExistingListWhenConditionTrue()
  {
    nlib_List lst1 = nlib_List.collect();
    nlib_List lst2 = nlib_List.collect( new String[]{ 'value1', 'value2' } );
    lst1.addWhen( lst2, false );
    System.assertEquals( 0, lst1.size() );
    lst1.addWhen( lst2, true );
    System.assertEquals( 2, lst1.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnContentsAsNativeList()
  {
    nlib_List lst = nlib_List.collect( new String[]{ 'value1', 'value2' } );
    List<Object> lst2 = lst.all();
    System.assertEquals( 2, lst2.size() );
    System.assertEquals( 'value1', lst2[ 0 ] );
    System.assertEquals( 'value2', lst2[ 1 ] );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnContentsAsASpecificListType()
  {
    nlib_List lst = nlib_List.collect();
    lst.add( 'value1' );
    
    List<Object> lst2 = lst.all( String[ ].class );
    
    System.assert( lst2 instanceof String[] );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTheAverage()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assertEquals( 5.5, lst.avg() );
  }
  
  
  
  
  @IsTest
  static void itShouldBreakUpListIntoListOfListsContainingGivenNumberOfElements()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assertEquals( 3, lst.chunk( 4 ).size() );
    System.assert( lst.chunk( 4 )[ 0 ].equals( new Integer[]{ 1, 2, 3, 4 } ) );
    System.assert( lst.chunk( 4 )[ 1 ].equals( new Integer[]{ 5, 6, 7, 8 } ) );
    System.assert( lst.chunk( 4 )[ 2 ].equals( new Integer[]{ 9, 10 } ) );
  }
  
  
  
  
  @IsTest
  static void itShouldCopyTheCollection()
  {
    nlib_List lst1 = nlib_List.collect( new String[]{ 'value1', 'value2' } );
    nlib_List lst2 = lst1.copy();
    System.assertEquals( 2, lst2.size() );
    System.assertEquals( 'value1', lst2.get( 0 ) );
    System.assertEquals( 'value2', lst2.get( 1 ) );
    
    // copy method is a shallow copy.  test the reference.
    lst1.pull( 0 );
    System.assertEquals( 1, lst1.size() );
    System.assertEquals( 1, lst2.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldDeepCopyTheCollection()
  {
    nlib_List lst1 = nlib_List.collect( new String[]{ 'value1', 'value2' } );
    nlib_List lst2 = lst1.deepCopy();
    System.assertEquals( 2, lst2.size() );
    System.assertEquals( 'value1', lst2.get( 0 ) );
    System.assertEquals( 'value2', lst2.get( 1 ) );
    
    // deepCopy method creates a clone so there shouldn't be a reference.
    lst1.pull( 0 );
    System.assertEquals( 1, lst1.size() );
    System.assertEquals( 2, lst2.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldPassEachElementToIFunctionCallbackByTypeName()
  {
    nlib_List lst = nlib_List.collect( new Account[]{
      new Account( Name = 'Company 1' ),
      new Account( Name = 'Company 2' )
    } ).each( 'nlib_ListTest.TestFunction' );
    
    System.assertEquals( 'Updated Company 1', ( (Account) lst.get( 0 ) ).Name );
    System.assertEquals( 'Updated Company 2', ( (Account) lst.get( 1 ) ).Name );
  }
  
  
  
  
  @IsTest
  static void itShouldPassEachElementToIFunctionCallbackByTypeNameWithArguments()
  {
    nlib_List lst = nlib_List.collect( new Account[]{
      new Account( Name = 'Company 1' ),
      new Account( Name = 'Company 2' )
    } ).each( 'nlib_ListTest.TestFunction', 'New ' );
    
    System.assertEquals( 'New Company 1', ( (Account) lst.get( 0 ) ).Name );
    System.assertEquals( 'New Company 2', ( (Account) lst.get( 1 ) ).Name );
  }
  
  
  
  
  @IsTest
  static void itShouldPassEachElementToIFunctionCallbackByType()
  {
    nlib_List lst = nlib_List.collect( new Account[]{
      new Account( Name = 'Company 1' ),
      new Account( Name = 'Company 2' )
    } ).each( TestFunction.class );
    
    System.assertEquals( 'Updated Company 1', ( (Account) lst.get( 0 ) ).Name );
    System.assertEquals( 'Updated Company 2', ( (Account) lst.get( 1 ) ).Name );
  }
  
  
  
  
  @IsTest
  static void itShouldPassEachElementToIFunctionCallbackByTypeWithArguments()
  {
    nlib_List lst = nlib_List.collect( new Account[]{
      new Account( Name = 'Company 1' ),
      new Account( Name = 'Company 2' )
    } ).each( TestFunction.class, 'New ' );
    
    System.assertEquals( 'New Company 1', ( (Account) lst.get( 0 ) ).Name );
    System.assertEquals( 'New Company 2', ( (Account) lst.get( 1 ) ).Name );
  }
  
  
  
  
  @IsTest
  static void itShouldPassEachElementToIFunctionCallbackObject()
  {
    TestFunction callback = new TestFunction();
    nlib_List lst = nlib_List.collect( new Account[]{
      new Account( Name = 'Company 1' ),
      new Account( Name = 'Company 2' )
    } ).each( (nlib_Func.IFunction) callback );
    
    System.assertEquals( 2, callback.executionCounter );
    System.assertEquals( 'Updated Company 1', ( (Account) lst.get( 0 ) ).Name );
    System.assertEquals( 'Updated Company 2', ( (Account) lst.get( 1 ) ).Name );
  }
  
  
  
  
  @IsTest
  static void itShouldPassEachElementToIFunctionCallbackObjectWithArguments()
  {
    TestFunction callback = new TestFunction();
    nlib_List lst = nlib_List.collect( new Account[]{
      new Account( Name = 'Company 1' ),
      new Account( Name = 'Company 2' )
    } ).each( (nlib_Func.IFunction) callback, 'New ' );
    
    System.assertEquals( 2, callback.executionCounter );
    System.assertEquals( 'New Company 1', ( (Account) lst.get( 0 ) ).Name );
    System.assertEquals( 'New Company 2', ( (Account) lst.get( 1 ) ).Name );
  }
  
  
  
  
  @IsTest
  static void itShouldBeEqual()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2 } );
    System.assertEquals( true, lst.equals( new Integer[]{ 1, 2 } ) );
    System.assertEquals( false, lst.equals( new Integer[]{ 1, 2, 3 } ) );
  }
  
  
  
  
  @IsTest
  static void itShouldNotBeEqual()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2 } );
    System.assertEquals( true, lst.notEquals( new Integer[]{ 1, 2, 3 } ) );
    System.assertEquals( false, lst.notEquals( new Integer[]{ 1, 2 } ) );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnNewListExceptGivenValues()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    nlib_List lst2 = lst.except( new Integer[]{ 6, 7, 8, 9, 10 } );
    System.assertEquals( 5, lst2.size() );
    System.assert( lst2.equals( new Integer[]{ 1, 2, 3, 4, 5 } ) );
  }
  
  
  
  
  @IsTest
  static void itShouldDetermineIfAllElementsPassGivenIFilterTruthTestByClassTypeName()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assert( lst.every( 'nlib_ListTest.GreaterThanZero' ) );
  }
  
  
  
  
  @IsTest
  static void itShouldDetermineIfAllElementsPassGivenIFilterTruthTestByClassTypeNameWithArguments()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assertEquals( false, lst.every( 'nlib_ListTest.GreaterThan', 5 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldDetermineIfAllElementsPassGivenIFilterTruthTestByClassType()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assert( lst.every( GreaterThanZero.class ) );
  }
  
  
  
  
  @IsTest
  static void itShouldDetermineIfAllElementsPassGivenIFilterTruthTestByClassTypeWithArguments()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assertEquals( false, lst.every( GreaterThan.class, 5 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldDetermineIfAllElementsPassGivenIFilterTruthTestObject()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assert( lst.every( new GreaterThanZero() ) );
  }
  
  
  
  
  @IsTest
  static void itShouldDetermineIfAllElementsPassGivenIFilterTruthTestObjectWithArguments()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assertEquals( false, lst.every( new GreaterThan(), 5 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldElementsPassingGivenIFilterTruthTestClassTypeName()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ -2, -1, 0, 1, 2 } );
    System.assertEquals( 2, lst.filter( 'nlib_ListTest.GreaterThanZero' ).size() );
    System.assert(
      lst.filter( 'nlib_ListTest.GreaterThanZero' )
        .equals( new Integer[]{ 1, 2 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldElementsPassingGivenIFilterTruthTestClassTypeNameWithArguments()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5 } );
    System.assertEquals( 3, lst.filter( 'nlib_ListTest.GreaterThan', 2 ).size() );
    System.assert(
      lst.filter( 'nlib_ListTest.GreaterThan', 2 )
        .equals( new Integer[]{ 3, 4, 5 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldElementsPassingGivenIFilterTruthTestClassType()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ -2, -1, 0, 1, 2 } );
    System.assertEquals( 2, lst.filter( GreaterThanZero.class ).size() );
    System.assert(
      lst.filter( GreaterThanZero.class )
        .equals( new Integer[]{ 1, 2 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldElementsPassingGivenIFilterTruthTestClassTypeWithArguments()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5 } );
    System.assertEquals( 3, lst.filter( GreaterThan.class, 2 ).size() );
    System.assert(
      lst.filter( GreaterThan.class, 2 )
        .equals( new Integer[]{ 3, 4, 5 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldElementsPassingGivenIFilterTruthTestObject()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ -2, -1, 0, 1, 2 } );
    System.assertEquals( 2, lst.filter( new GreaterThanZero() ).size() );
    System.assert(
      lst.filter( new GreaterThanZero() )
        .equals( new Integer[]{ 1, 2 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldElementsPassingGivenIFilterTruthTestObjectWithArguments()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5 } );
    System.assertEquals( 3, lst.filter( new GreaterThan(), 2 ).size() );
    System.assert(
      lst.filter( new GreaterThan(), 2 )
        .equals( new Integer[]{ 3, 4, 5 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnIndexOfGivenElement()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 1, lst.find( 2 ) );
    System.assertEquals( 2, lst.find( 3 ) );
    System.assertEquals( -1, lst.find( 5 ) ); // not found
    System.assertEquals( -1, lst.find( 10 ) ); // not found
  }
  
  
  
  
  @IsTest
  static void itShouldReturnFirstElement()
  {
    nlib_List lst = nlib_List.collect();
    
    // Throws an IndexOutOfBoundsException if index in invalid
    try {
      lst.first();
      System.assert( false, 'Did not received the IndexOutOfBoundsException as expected.' );
    } catch(nlib_List.IndexOutOfBoundsException e) {
      System.assertEquals( 'The list is empty.', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
    
    lst.add( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 1, lst.first() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnFirstElementOrGivenValueIfEmpty()
  {
    nlib_List lst = nlib_List.newInstance();
    System.assertEquals( 10, lst.firstOr( 10 ) );
    
    lst.add( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 1, lst.firstOr( 10 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnFirstElementOrNullIfEmpty()
  {
    nlib_List lst = nlib_List.newInstance();
    System.assertEquals( null, lst.firstOrNull() );
    
    lst.add( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 1, lst.firstOrNull() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTheElementWithIndexOfInternalPointer()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 1, lst.get() ); // pointer at 0
    lst.next(); // increments pointer;
    System.assertEquals( 2, lst.get() );
    lst.next();
    System.assertEquals( 3, lst.get() );
    lst.next();
    System.assertEquals( null, lst.get() ); // returns null if out of bounds
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTheElementAtGivenIndex()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 1, lst.get( 0 ) ); // pointer at 0
    System.assertEquals( 2, lst.get( 1 ) );
    System.assertEquals( 3, lst.get( 2 ) );
    
    // Throws an IndexOutOfBoundsException if index in invalid
    try {
      lst.get( 3 );
      System.assert( false, 'Did not received the IndexOutOfBoundsException as expected.' );
    } catch(nlib_List.IndexOutOfBoundsException e) {
      System.assertEquals( 'There is no element at index 3', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
  }
  
  
  
  
  @IsTest
  static void itShouldReturnElementAtIndexOrGivenValueIfEmpty()
  {
    nlib_List lst = nlib_List.newInstance();
    System.assertEquals( 10, lst.getOr( 5, 10 ) );
    
    lst.add( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 3, lst.getOr( 2, 10 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnElementAtIndexOrNullIfEmpty()
  {
    nlib_List lst = nlib_List.newInstance();
    System.assertEquals( null, lst.getOrNull( 10 ) );
    
    lst.add( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 3, lst.getOrNull( 2 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldThrowExceptionWhenEmpty()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{} );
    try {
      lst.ifEmptyThrow( new TestException( 'List is empty' ) );
      system.assert( false, 'The nlib_List.ifEmptyThrow method did not throw an exception when it was supposed to' );
    } catch(TestException e) {
      system.assertEquals( 'List is empty', e.getMessage() );
    } catch(Exception e) {
      system.assert( false, 'There was an unexpected exception thrown. ' + e.getMessage() );
    }
  }
  
  
  
  
  @IsTest
  static void itShouldNotThrowExceptionWhenNotEmpty()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    try {
      lst.ifEmptyThrow( new TestException( 'List is empty' ) );
    } catch(TestException e) {
      system.assert( false, 'The nlib_List.ifEmptyThrow method threw an exception when it wasnt supposed to' );
    } catch(Exception e) {
      system.assert( false, 'There was an unexpected exception thrown. ' + e.getMessage() );
    }
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTrueIfEmpty()
  {
    nlib_List lst = nlib_List.collect();
    System.assert( lst.isEmpty() );
    lst.add( 1 );
    System.assertEquals( false, lst.isEmpty() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTrueIfNotEmpty()
  {
    nlib_List lst = nlib_List.collect();
    System.assertEquals( false, lst.isNotEmpty() );
    lst.add( 1 );
    System.assert( lst.isNotEmpty() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnLastElement()
  {
    nlib_List lst = nlib_List.collect();
    
    // Throws an IndexOutOfBoundsException if index in invalid
    try {
      lst.last();
      System.assert( false, 'Did not received the IndexOutOfBoundsException as expected.' );
    } catch(nlib_List.IndexOutOfBoundsException e) {
      System.assertEquals( 'The list is empty.', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
    
    lst.add( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 3, lst.last() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnLastElementOrGivenValueIfEmpty()
  {
    nlib_List lst = nlib_List.newInstance();
    System.assertEquals( 10, lst.lastOr( 10 ) );
    
    lst.add( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 3, lst.lastOr( 10 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnLastElementOrNullIfEmpty()
  {
    nlib_List lst = nlib_List.newInstance();
    System.assertEquals( null, lst.lastOrNull() );
    
    lst.add( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 3, lst.lastOrNull() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnLastIndex()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 2, lst.lastIndex() );
    lst.add( 4 );
    System.assertEquals( 3, lst.lastIndex() );
  }
  
  
  
  
  @IsTest
  static void itShouldPassElementsToGivenITransformClassTypeName()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assert(
      lst.mapp( 'nlib_ListTest.ConvertToString' )
        .equals( new String[]{ '1', '2', '3' } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldPassElementsToGivenITransformClassTypeNameWithArguments()
  {
    nlib_List lst = nlib_List.collect( new String[]{ 'four', 'six', 'seven' } );
    System.assert(
      lst.mapp( 'nlib_ListTest.AddSuffix', 'teen' )
        .equals( new String[]{ 'fourteen', 'sixteen', 'seventeen' } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldPassElementsToGivenITransformClassType()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assert(
      lst.mapp( ConvertToString.class )
        .equals( new String[]{ '1', '2', '3' } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldPassElementsToGivenITransformClassTypeWithArguments()
  {
    nlib_List lst = nlib_List.collect( new String[]{ 'four', 'six', 'seven' } );
    System.assert(
      lst.mapp( AddSuffix.class, 'teen' )
        .equals( new String[]{ 'fourteen', 'sixteen', 'seventeen' } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldPassElementsToGivenITransformObject()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assert(
      lst.mapp( new ConvertToString() )
        .equals( new String[]{ '1', '2', '3' } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldPassElementsToGivenITransformObjectWithArguments()
  {
    nlib_List lst = nlib_List.collect( new String[]{ 'four', 'six', 'seven' } );
    System.assert(
      lst.mapp( new AddSuffix(), 'teen' )
        .equals( new String[]{ 'fourteen', 'sixteen', 'seventeen' } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTheMaximumValue()
  {
    System.assertEquals( 3, nlib_List.collect( new Integer[]{ 1, 2, 3 } ).max() );
    System.assertEquals( '3', nlib_List.collect( new String[]{ '1', '2', '3' } ).max() );
    System.assertEquals( Date.today().addDays( 1 ), nlib_List.collect( new Date[]{ Date.today().addDays( -1 ), Date.today(), Date.today().addDays( 1 ) } ).max() );
    
    Datetime[] lstDatetimes = new Datetime[]{ Datetime.now().addSeconds( -5 ), Datetime.now(), Datetime.now().addSeconds( 5 ) };
    System.assertEquals( lstDatetimes[ 2 ], nlib_List.collect( lstDatetimes ).max() );
    
    Time[] lstTimes = new Time[]{ Datetime.now().time().addSeconds( -5 ), Datetime.now().time(), Datetime.now().time().addSeconds( 5 ) };
    System.assertEquals( lstTimes[ 2 ], nlib_List.collect( lstTimes ).max() );
    
    // Throws an MalformedCallException if object type is invalid
    try {
      nlib_List.collect( new Account( Name = 'Company' ) ).max();
      System.assert( false, 'Did not received the MalformedCallException as expected.' );
    } catch(nlib_Func.MalformedCallException e) {
      System.assertEquals( 'Unable to determine max value of this object type. Try mapping to a collection of primitive values first.', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTheMinimumValue()
  {
    System.assertEquals( 1, nlib_List.collect( new Integer[]{ 1, 2, 3 } ).min() );
    System.assertEquals( '1', nlib_List.collect( new String[]{ '1', '2', '3' } ).min() );
    System.assertEquals( Date.today().addDays( -1 ), nlib_List.collect( new Date[]{ Date.today().addDays( -1 ), Date.today(), Date.today().addDays( 1 ) } ).min() );
    
    Datetime[] lstDatetimes = new Datetime[]{ Datetime.now().addSeconds( -5 ), Datetime.now(), Datetime.now().addSeconds( 5 ) };
    System.assertEquals( lstDatetimes[ 0 ], nlib_List.collect( lstDatetimes ).min() );
    
    Time[] lstTimes = new Time[]{ Datetime.now().time().addSeconds( -5 ), Datetime.now().time(), Datetime.now().time().addSeconds( 5 ) };
    System.assertEquals( lstTimes[ 0 ], nlib_List.collect( lstTimes ).min() );
    
    // Throws an MalformedCallException if object type is invalid
    try {
      nlib_List.collect( new Account( Name = 'Company' ) ).min();
      System.assert( false, 'Did not received the MalformedCallException as expected.' );
    } catch(nlib_Func.MalformedCallException e) {
      System.assertEquals( 'Unable to determine min value of this object type. Try mapping to a collection of primitive values first.', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
  }
  
  
  
  
  @IsTest
  static void itShouldReturnAListOfValuesFromSObjectField()
  {
    nlib_List lst = nlib_List.collect(
      new Account[]{
        new Account( Name = 'Name1' ),
        new Account( Name = 'Name2' ),
        new Account( Name = 'Name3' )
      }
    );
    nlib_List lst2 = lst.pluck( 'Name' );
    System.assertEquals( 3, lst2.size() );
    System.assert( lst2.equals( new String[]{ 'Name1', 'Name2', 'Name3' } ) );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnAListOfIds()
  {
    FabricatedSObjectId fab = new FabricatedSObjectId();
    Id id1 = fab.getFakeId( Account.class );
    Id id2 = fab.getFakeId( Account.class );
    Id id3 = fab.getFakeId( Account.class );
    
    nlib_List lst = nlib_List.collect(
      new Account[]{
        new Account( Id = id1 ),
        new Account( Id = id2 ),
        new Account( Id = id3 )
      }
    );
    nlib_List lst2 = lst.pluckIds();
    System.assertEquals( 3, lst2.size() );
    System.assert( lst2.equals( new String[]{ id1, id2, id3 } ) );
  }
  
  
  
  
  @IsTest
  static void itShouldAddElementsToBeginningOfList()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 2, 3 } );
    lst.prepend( 1 );
    System.assertEquals( 3, lst.size() );
    System.assert( lst.equals( new Integer[]{ 1, 2, 3 } ) );
    System.assert( lst.notEquals( new Integer[]{ 3, 2, 1 } ) );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnAndRemoveTheElementWithIndexOfInternalPointer()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 1, lst.pull() ); // pointer at 0
    System.assertEquals( 2, lst.pull() );
    System.assertEquals( 3, lst.pull() );
    
    // Throws an IndexOutOfBoundsException if index in invalid
    try {
      lst.pull();
      System.assert( false, 'Did not received the IndexOutOfBoundsException as expected.' );
    } catch(nlib_List.IndexOutOfBoundsException e) {
      System.assertEquals( 'The list is empty.', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
  }
  
  
  
  
  @IsTest
  static void itShouldReturnAndRemoveTheElementAtGivenIndex()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 1, lst.pull( 0 ) ); // pointer at 0
    System.assertEquals( 2, lst.pull( 0 ) );
    System.assertEquals( 3, lst.pull( 0 ) );
    
    // Throws an IndexOutOfBoundsException if index in invalid
    try {
      lst.pull( 0 );
      System.assert( false, 'Did not received the IndexOutOfBoundsException as expected.' );
    } catch(nlib_List.IndexOutOfBoundsException e) {
      System.assertEquals( 'The list is empty.', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
  }
  
  
  
  
  @IsTest
  static void itShouldPassValuesToGivenIReduceClassTypeName()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 6, lst.reduce( 'nlib_ListTest.Sum' ) );
  }
  
  
  
  
  @IsTest
  static void itShouldPassValuesToGivenIReduceClassTypeNameWithStartingValue()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 16, lst.reduce( 'nlib_ListTest.Sum', 10 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldPassValuesToGivenIReduceClassTypeNameWithArgument()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 316, lst.reduce( 'nlib_ListTest.Sum', 10, 100 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldPassValuesToGivenIReduceClassType()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 6, lst.reduce( Sum.class ) );
  }
  
  
  
  
  @IsTest
  static void itShouldPassValuesToGivenIReduceClassTypeWithStartingValue()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 16, lst.reduce( Sum.class, 10 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldPassValuesToGivenIReduceClassTypeWithArgument()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 316, lst.reduce( Sum.class, 10, 100 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldPassValuesToGivenIReduceObject()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 6, lst.reduce( new Sum() ) );
  }
  
  
  
  
  @IsTest
  static void itShouldPassValuesToGivenIReduceObjectWithStartingValue()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 16, lst.reduce( new Sum(), 10 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldPassValuesToGivenIReduceObjectWithArgument()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 316, lst.reduce( new Sum(), 10, 100 ) );
  }
  
  
  
  
  @IsTest
  static void itShouldRejectElementsThatPassGivenIFilterClassTypeName()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ -3, -2, -1, 0, 1, 2, 3 } );
    System.assert(
      lst.reject( 'nlib_ListTest.GreaterThanZero' )
        .equals( new Integer[]{ -3, -2, -1, 0 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldRejectElementsThatPassGivenIFilterClassTypeNameWithArgument()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 0, 1, 2, 3, 4, 5 } );
    System.assert(
      lst.reject( 'nlib_ListTest.GreaterThan', 2 )
        .equals( new Integer[]{ 0, 1, 2 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldRejectElementsThatPassGivenIFilterClassType()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ -3, -2, -1, 0, 1, 2, 3 } );
    System.assert(
      lst.reject( GreaterThanZero.class )
        .equals( new Integer[]{ -3, -2, -1, 0 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldRejectElementsThatPassGivenIFilterClassTypeWithArgument()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 0, 1, 2, 3, 4, 5 } );
    System.assert(
      lst.reject( GreaterThan.class, 2 )
        .equals( new Integer[]{ 0, 1, 2 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldRejectElementsThatPassGivenIFilterObject()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ -3, -2, -1, 0, 1, 2, 3 } );
    System.assert(
      lst.reject( new GreaterThanZero() )
        .equals( new Integer[]{ -3, -2, -1, 0 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldRejectElementsThatPassGivenIFilterObjectWithArgument()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 0, 1, 2, 3, 4, 5 } );
    System.assert(
      lst.reject( new GreaterThan(), 2 )
        .equals( new Integer[]{ 0, 1, 2 } )
    );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnListWithGivenIndexRemoved()
  {
    System.assertEquals( 0, nlib_List.collect().remove( 0 ).size() );
    
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assertEquals( 9, lst.remove( 0 ).size() );
    System.assertEquals( 2, lst.first() );
    
    // Throws an IndexOutOfBoundsException if index in invalid
    try {
      lst.remove( 10 );
      System.assert( false, 'Did not received the IndexOutOfBoundsException as expected.' );
    } catch(nlib_List.IndexOutOfBoundsException e) {
      System.assertEquals( 'There is no element at index 10', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
  }
  
  
  
  
  @IsTest
  static void itShouldReverseTheValues()
  {
    System.assertEquals( 0, nlib_List.collect().reverse().size() );
    
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assert( lst.reverse().equals( new Integer[]{ 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 } ) );
    System.assert( lst.equals( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } ) );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTheSize()
  {
    System.assertEquals( 0, nlib_List.collect().size() );
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assertEquals( 10, lst.size() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnASlice()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    nlib_List lst2 = lst.slice( 4 );
    System.assertEquals( 6, lst2.size() );
    System.assert( lst2.equals( new Integer[]{ 5, 6, 7, 8, 9, 10 } ) );
    
    // Throws an IndexOutOfBoundsException if index in invalid
    try {
      nlib_List lst3 = nlib_List.collect().slice( 0 );
      System.assert( false, 'Did not received the IndexOutOfBoundsException as expected.' );
    } catch(nlib_List.IndexOutOfBoundsException e) {
      System.assertEquals( 'There is no element at index 0', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
  }
  
  
  
  
  @IsTest
  static void itShouldReturnASliceWithAGivenLength()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    nlib_List lst2 = lst.slice( 4, 3 );
    System.assertEquals( 3, lst2.size() );
    System.assert( lst2.equals( new Integer[]{ 5, 6, 7 } ) );
    
    // Throws an IndexOutOfBoundsException if index in invalid
    try {
      nlib_List lst3 = nlib_List.collect().slice( 0, 1 );
      System.assert( false, 'Did not received the IndexOutOfBoundsException as expected.' );
    } catch(nlib_List.IndexOutOfBoundsException e) {
      System.assertEquals( 'There is no element at index 0', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
  }
  
  
  
  
  @isTest
  static void itShouldSortIntegersInAscendingOrder()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 8, 2, 10, 5, 9, 0, 3, 7, 4, 6, 1 } );
    Integer[] answer = new Integer[]{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    System.assertEquals( answer, (Integer[]) lst.sort( 'nlib_Func.SortNumbersAsc' ).all() );
  }
  
  
  
  
  @isTest
  static void itShouldSortIntegersInDescendingOrder()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 8, 2, 10, 5, 9, 0, 3, 7, 4, 6, 1 } );
    Integer[] answer = new Integer[]{ 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };
    System.assertEquals( answer, (Integer[]) lst.sort( 'nlib_Func.SortNumbersDesc' ).all() );
  }
  
  
  
  
  @isTest
  static void itShouldSortDecimalsInAscendingOrder()
  {
    nlib_List lst = nlib_List.collect( new Decimal[]{ 8.8, 2.2, 10.1, 5.5, 9.9, 0.1, 3.3, 7.7, 4.4, 6.6, 1.1 } );
    Decimal[] answer = new Decimal[]{ 0.1, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9, 10.1 };
    System.assertEquals( answer, (Decimal[]) lst.sort( 'nlib_Func.SortNumbersAsc' ).all() );
  }
  
  
  
  
  @isTest
  static void itShouldSortDecimalsInDescendingOrder()
  {
    nlib_List lst = nlib_List.collect( new Decimal[]{ 8.8, 2.2, 10.1, 5.5, 9.9, 0.1, 3.3, 7.7, 4.4, 6.6, 1.1 } );
    Decimal[] answer = new Decimal[]{ 10.1, 9.9, 8.8, 7.7, 6.6, 5.5, 4.4, 3.3, 2.2, 1.1, 0.1 };
    System.assertEquals( answer, (Decimal[]) lst.sort( 'nlib_Func.SortNumbersDesc' ).all() );
  }
  
  
  
  
  @isTest
  static void itShouldSortTextInAscendingOrder()
  {
    nlib_List lst = nlib_List.collect( new String[]{ 'Hi', 'ef', 'AB', 'cd', 'fG', 'jk', 'Ca', 'no', 'ee', 'lm' } );
    String[] answer = new String[]{ 'AB', 'Ca', 'cd', 'ee', 'ef', 'fG', 'Hi', 'jk', 'lm', 'no' };
    System.assertEquals( answer, (String[]) lst.sort( 'nlib_Func.SortTextAsc' ).all() );
  }
  
  
  
  
  @isTest
  static void itShouldSortTextInDescendingOrder()
  {
    nlib_List lst = nlib_List.collect( new String[]{ 'Hi', 'ef', 'AB', 'cd', 'fG', 'jk', 'Ca', 'no', 'ee', 'lm' } );
    String[] answer = new String[]{ 'no', 'lm', 'jk', 'Hi', 'fG', 'ef', 'ee', 'cd', 'Ca', 'AB' };
    System.assertEquals( answer, (String[]) lst.sort( 'nlib_Func.SortTextDesc' ).all() );
  }
  
  
  
  
  @isTest
  static void itShouldSortDatesInAscendingOrder()
  {
    nlib_List lst = nlib_List.collect( new Date[]{ Date.today().addDays( 1 ), Date.today(), Date.today().addDays( -1 ) } );
    Date[] answer = new Date[]{ Date.today().addDays( -1 ), Date.today(), Date.today().addDays( 1 ) };
    System.assertEquals( answer, (Date[]) lst.sort( 'nlib_Func.SortDatesAsc' ).all() );
  }
  
  
  
  
  @isTest
  static void itShouldSortDatesInDescendingOrder()
  {
    nlib_List lst = nlib_List.collect( new Date[]{ Date.today().addDays( -1 ), Date.today(), Date.today().addDays( 1 ) } );
    Date[] answer = new Date[]{ Date.today().addDays( 1 ), Date.today(), Date.today().addDays( -1 ) };
    System.assertEquals( answer, (Date[]) lst.sort( 'nlib_Func.SortDatesDesc' ).all() );
  }
  
  
  
  
  @isTest
  static void itShouldReturnANewCollectionWhenSorting()
  {
    Integer[] original = new Integer[]{ 8, 2, 10, 5, 9, 0, 3, 7, 4, 6, 1 };
    Integer[] answer = new Integer[]{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    nlib_List lst = nlib_List.collect( original );
    System.assertEquals( answer, (Integer[]) lst.sort( 'nlib_Func.SortNumbersAsc' ).all() );
    System.assertEquals( original, (Integer[]) lst.all() );
  }
  
  
  
  
  @IsTest
  static void itShouldBeSplitIntoGroups()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    nlib_List[] splitLst = lst.split( 3 );
    System.assertEquals( 3, splitLst.size() );
    System.assertEquals( new Integer[]{ 1, 2, 3, 4 }, (Integer[]) splitLst[ 0 ].all() );
    System.assertEquals( new Integer[]{ 5, 6, 7 }, (Integer[]) splitLst[ 1 ].all() );
    System.assertEquals( new Integer[]{ 8, 9, 10 }, (Integer[]) splitLst[ 2 ].all() );
    
    
    nlib_List lst2 = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9 } );
    nlib_List[] splitLst2 = lst2.split( 3 );
    System.assertEquals( 3, splitLst2.size() );
    System.assertEquals( new Integer[]{ 1, 2, 3 }, (Integer[]) splitLst2[ 0 ].all() );
    System.assertEquals( new Integer[]{ 4, 5, 6 }, (Integer[]) splitLst2[ 1 ].all() );
    System.assertEquals( new Integer[]{ 7, 8, 9 }, (Integer[]) splitLst2[ 2 ].all() );
    
    
    nlib_List lst3 = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8 } );
    nlib_List[] splitLst3 = lst3.split( 3 );
    System.assertEquals( 3, splitLst3.size() );
    System.assertEquals( new Integer[]{ 1, 2, 3 }, (Integer[]) splitLst3[ 0 ].all() );
    System.assertEquals( new Integer[]{ 4, 5, 6 }, (Integer[]) splitLst3[ 1 ].all() );
    System.assertEquals( new Integer[]{ 7, 8 }, (Integer[]) splitLst3[ 2 ].all() );
    
    
    nlib_List lst4 = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7 } );
    nlib_List[] splitLst4 = lst4.split( 3 );
    System.assertEquals( 3, splitLst4.size() );
    System.assertEquals( new Integer[]{ 1, 2, 3 }, (Integer[]) splitLst4[ 0 ].all() );
    System.assertEquals( new Integer[]{ 4, 5 }, (Integer[]) splitLst4[ 1 ].all() );
    System.assertEquals( new Integer[]{ 6, 7 }, (Integer[]) splitLst4[ 2 ].all() );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnSum()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } );
    System.assertEquals( 55, lst.sum() );
    
    // Throws an IndexOutOfBoundsException if index in invalid
    try {
      nlib_List.collect().sum();
      System.assert( false, 'Did not received the IndexOutOfBoundsException as expected.' );
    } catch(nlib_List.IndexOutOfBoundsException e) {
      System.assertEquals( 'The list is empty.', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
    
    
    // Throws an IndexOutOfBoundsException if index in invalid
    try {
      nlib_List.collect( new String[]{ '1', '2', '3' } ).sum();
      System.assert( false, 'Did not received the MalformedCallException as expected.' );
    } catch(nlib_Func.MalformedCallException e) {
      System.assertEquals( 'Use of the Sum callback is limited to numeric variable types.', e.getMessage() );
    } catch(Exception e) {
      System.assert( false, 'Received an unexpected exception.' );
    }
  }
  
  
  
  
  @isTest
  static void itShouldRunTransformCallbackASpecifiedNumberOfTimes()
  {
    nlib_List lst = nlib_List.collect();
    lst = lst.times( IntegerFill.class, 11 );
    system.assertEquals( new Integer[]{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, (Integer[]) lst.all( Integer[ ].class ) );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnJsonString()
  {
    System.assertEquals( '[]', nlib_List.collect().toJson() );
    String json1 = nlib_List.collect( new String[]{ '1', '2', '3' } ).toJson();
    System.assertEquals( '["1","2","3"]', json1 );
    
    String json2 = nlib_List.collect( new Account[]{
      new Account( Name = 'Company 1' ),
      new Account( Name = 'Company 2' )
    } ).toJson();
    System.assertEquals( '[{"attributes":{"type":"Account"},"Name":"Company 1"},{"attributes":{"type":"Account"},"Name":"Company 2"}]', json2 );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnPrettyJsonString()
  {
    System.assertEquals( '[ ]', nlib_List.collect().toPrettyJson() );
    String json1 = nlib_List.collect( new String[]{ '1', '2', '3' } ).toPrettyJson();
    System.assertEquals( '[ "1", "2", "3" ]', json1 );
  }
  
  
  
  
  @IsTest
  static void itShouldReturnTheValues()
  {
    nlib_List lst = nlib_List.collect( new Integer[]{ 1, 2, 3 } );
    System.assertEquals( 3, lst.values().size() );
    System.assertEquals( new Integer[]{ 1, 2, 3 }, lst.values() );
  }
  
  
  
  
  public class FabricatedSObjectId
  {
    private Integer counter = 0;
    
    public Id getFakeId( Schema.SObjectType sObjectType )
    {
      String strCounter = String.valueOf( ++counter );
      String prefix = sObjectType.getDescribe().getKeyPrefix();
      return Id.valueOf( prefix + '0'.repeat( 12 - strCounter.length() ) + strCounter );
    }
    
    
    public Id getFakeId( Type type )
    {
      SObject obj = (SObject) type.newInstance();
      return getFakeId( obj.getSObjectType() );
    }
  }
  
  
  
  
  public class TestFunction extends nlib_Func.Function
  {
    public Integer executionCounter = 0;
    
    public override void call( Object item, Object arg )
    {
      String strValue = arg == null ? 'Updated ' : (String) arg;
      Account objAccount = (Account) item;
      objAccount.Name = strValue + objAccount.Name;
      executionCounter++;
    }
  }
  
  
  
  
  public class GreaterThanZero extends nlib_Func.Filter
  {
    public override Boolean call( Object item, Object arg )
    {
      return (Double) item > 0;
    }
  }
  
  
  
  
  public class GreaterThan extends nlib_Func.Filter
  {
    public override Boolean call( Object item, Object arg )
    {
      return (Double) item > (Double) arg;
    }
  }
  
  
  
  
  public class TestFilter extends nlib_Func.Filter
  {
    public Integer executionCounter = 0;
    public Integer minimum;
    
    public TestFilter( Integer minimum )
    {
      this.minimum = minimum;
    }
    
    public override Boolean call( Object item, Object arg )
    {
      return (Double) item > minimum;
    }
  }
  
  
  
  
  public class ConvertToString extends nlib_Func.Transform
  {
    public override Object call( Object item, Object arg )
    {
      return String.valueOf( item );
    }
  }
  
  
  
  
  public class AddSuffix extends nlib_Func.Transform
  {
    public override Object call( Object item, Object arg )
    {
      return String.valueOf( item ) + String.valueOf( arg );
    }
  }
  
  
  
  
  public class IntegerFill extends nlib_Func.Transform
  {
    public override Object call( Object item, Object arg )
    {
      return Integer.valueOf( item );
    }
  }
  
  
  
  
  public class Sum extends nlib_Func.Reduce
  {
    public override Object call( Object accumulator, Object item, Object arg )
    {
      accumulator = accumulator == null ? 0 : accumulator;
      arg = arg == null ? 0 : arg;
      return (Double) accumulator + (Double) item + (Double) arg;
    }
  }


}