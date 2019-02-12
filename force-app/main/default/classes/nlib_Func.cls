/**
 * Created by Scott McClung on 10/10/18.
 */

public class nlib_Func
{
  public static final IReduce Sum = new SumFunction();
  public static final IReduce Max = new MaxFunction();
  public static final IReduce Min = new MinFunction();
  public static final ITransform Pluck = new PluckFunction();
  public static final ITransform PluckId = new PluckIdFunction();
  
  
  
  
  public class MalformedCallException extends Exception {}
  
  
  
  
  /**
   * Callback that accepts an element but does not
   * return any value.
   * Since the values are passed by reference, this
   * interface can be used to transform elements in
   * the existing collection but it's better to use
   * the ITransform interface for that.
   *
   */
  public interface IFunction
  {
    void call( Object item, Object arg );
  }
  
  
  
  
  /**
   * Callback that accepts an element and returns
   * a boolean result of some truth test.
   *
   */
  public interface IFilter
  {
    Boolean call( Object item, Object arg );
  }
  
  
  
  
  /**
   * Callback that accepts an element, is free to modify the
   * element and return it.
   *
   */
  public interface ITransform
  {
    Object call( Object item, Object arg );
  }
  
  
  
  
  /**
   * Callback that accepts an accumulator and an element, performs
   * some action on the accumulator and returns it.
   * The accumulator is null by default on the first iteration.
   *
   */
  public interface IReduce
  {
    Object call( Object accumulation, Object item, Object arg );
  }
  
  
  
  
  /**
   * Callback that accepts two objects to be compared in a sorting context.
   * Returns an integer value (1, 0 , -1) that the Comparable interface expects
   * based on the ranking of the two objects.
   *
   */
  public interface IOrder
  {
    Boolean call( Object item, Object compareTo );
  }
  
  
  
  
  /**
   * Base class for higher order functions that
   * allows for injection of the list context
   *
   */
  public abstract class Callback
  {
    protected nlib_List self;
    
    public Callback()
    {
    }
    
    public void setContext( nlib_List self )
    {
      this.self = self;
    }
  }
  
  
  
  
  /**
   * Abstract base class for implementations of IFunction
   * Extend this class if you want your implementation to have access to
   * the nlib_List context.
   *
   */
  public abstract class Function extends Callback implements IFunction
  {
    public Function()
    {
    }
    public abstract void call( Object item, Object arg );
  }
  
  
  
  
  /**
   * Abstract base class for implementations of IFilter
   * Extend this class if you want your implementation to have access to
   * the nlib_List context.
   *
   */
  public abstract class Filter extends Callback implements IFilter
  {
    public Filter()
    {
    }
    public abstract Boolean call( Object item, Object arg );
  }
  
  
  
  
  /**
   * Abstract base class for implementations of ITransform
   * Extend this class if you want your implementation to have access to
   * the nlib_List context.
   *
   */
  public abstract class Transform extends Callback implements ITransform
  {
    public Transform()
    {
    }
    public abstract Object call( Object item, Object arg );
  }
  
  
  
  
  /**
   * Abstract base class for implementations of IReduce
   * Extend this class if you want your implementation to have access to
   * the nlib_List context.
   *
   */
  public abstract class Reduce extends Callback implements IReduce
  {
    public Reduce()
    {
    }
    public abstract Object call( Object accumulation, Object item, Object arg );
  }
  
  
  
  
  /**
   * Abstract base class for implementations of IOrder
   * Extend this class if you want your implementations to have access to
   * the nlib_List context
   */
  public abstract class Order extends Callback implements IOrder
  {
    public abstract Boolean call( Object item, Object compareTo );
  }
  
  
  
  
  /**
   * Callback that returns the sum of the elements
   *
   */
  public class SumFunction extends Reduce
  {
    public override Object call( Object accumulator, Object item, Object arg )
    {
      if(isInvalidNumericType( item )) throw new MalformedCallException( 'Use of the Sum callback is limited to numeric variable types.' );
      if(accumulator == null) accumulator = 0;
      return (Double) accumulator + (Double) item;
    }
    
    Boolean isInvalidNumericType( Object item )
    {
      if(item instanceof Integer) return false;
      if(item instanceof Long) return false;
      if(item instanceof Decimal) return false;
      if(item instanceof Double) return false;
      return true;
    }
  }
  
  
  
  
  /**
   * Callback that returns the max value of the elements
   *
   */
  public class MaxFunction extends Reduce
  {
    public override Object call( Object accumulator, Object item, Object arg )
    {
      accumulator = accumulator == null ? item : accumulator;
      if(isNumericType( item )) {
        accumulator = (Double) accumulator < (Double) item ? item : accumulator;
      } else if(item instanceof String) {
        accumulator = (String) accumulator < (String) item ? item : accumulator;
      } else if(item instanceof Date) {
        accumulator = (Date) accumulator < (Date) item ? item : accumulator;
      } else if(item instanceof Datetime) {
        accumulator = (Datetime) accumulator < (Datetime) item ? item : accumulator;
      } else if(item instanceof Time) {
        accumulator = (Time) accumulator < (Time) item ? item : accumulator;
      } else {
        throw new MalformedCallException( 'Unable to determine max value of this object type. Try mapping to a collection of primitive values first.' );
      }
      return accumulator;
    }
    
    Boolean isNumericType( Object item )
    {
      if(item instanceof Integer) return true;
      if(item instanceof Long) return true;
      if(item instanceof Decimal) return true;
      if(item instanceof Double) return true;
      return false;
    }
  }
  
  
  
  
  /**
   * Callback that returns the min value of the elements
   *
   */
  public class MinFunction extends Reduce
  {
    public override Object call( Object accumulator, Object item, Object arg )
    {
      accumulator = accumulator == null ? item : accumulator;
      if(isNumericType( item )) {
        accumulator = (Double) accumulator > (Double) item ? item : accumulator;
      } else if(item instanceof String) {
        accumulator = (String) accumulator > (String) item ? item : accumulator;
      } else if(item instanceof Date) {
        accumulator = (Date) accumulator > (Date) item ? item : accumulator;
      } else if(item instanceof Datetime) {
        accumulator = (Datetime) accumulator > (Datetime) item ? item : accumulator;
      } else if(item instanceof Time) {
        accumulator = (Time) accumulator > (Time) item ? item : accumulator;
      } else {
        throw new MalformedCallException( 'Unable to determine min value of this object type. Try mapping to a collection of primitive values first.' );
      }
      return accumulator;
    }
    
    Boolean isNumericType( Object item )
    {
      if(item instanceof Integer) return true;
      if(item instanceof Decimal) return true;
      if(item instanceof Long) return true;
      if(item instanceof Double) return true;
      return false;
    }
  }
  
  
  
  
  /**
   * Callback that returns the Id from SObjects
   *
   */
  public class PluckIdFunction extends Transform
  {
    public override Object call( Object item, Object arg )
    {
      if(hasInvalidType( item )) throw new MalformedCallException( 'Use of the Pluck callback is limited to SObjects.' );
      return (Id) ( (SObject) item ).get( 'Id' );
    }
    
    Boolean hasInvalidType( Object item )
    {
      if(item instanceof SObject) return false;
      return true;
    }
  }
  
  
  
  
  /**
   * Callback that returns the value of a given field from SObjects
   *
   */
  public class PluckFunction extends Transform
  {
    public override Object call( Object item, Object arg )
    {
      if(hasInvalidType( item )) throw new MalformedCallException( 'Use of the Pluck callback is limited to SObjects.' );
      if(hasInvalidArgs( arg )) throw new MalformedCallException( 'The Pluck callback requires the field name to be specified.' );
      
      return ( (SObject) item ).get( (String) arg );
    }
    
    Boolean hasInvalidType( Object item )
    {
      if(item instanceof SObject) return false;
      return true;
    }
    
    Boolean hasInvalidArgs( Object arg )
    {
      if(arg instanceof String) return false;
      if(arg != null) return false;
      return true;
    }
  }
  
  
  
  
  /**
   * Callback that sorts numerical values in ascending order
   *
   */
  public class SortNumbersAsc extends Order
  {
    public override Boolean call( Object item, Object compareTo )
    {
      return (Decimal) item < (Decimal) compareTo;
    }
  }
  
  
  
  
  /**
   * Callback that sorts numerical values in descending order
   *
   */
  public class SortNumbersDesc extends Order
  {
    public override Boolean call( Object item, Object compareTo )
    {
      return (Decimal) item > (Decimal) compareTo;
    }
  }
  
  
  
  
  /**
   * Callback that sorts string values in ascending order
   *
   */
  public class SortTextAsc extends Order
  {
    public override Boolean call( Object item, Object compareTo )
    {
      return (String) item < (String) compareTo;
    }
  }
  
  
  
  
  /**
   * Callback that sorts string values in descending order
   *
   */
  public class SortTextDesc extends Order
  {
    public override Boolean call( Object item, Object compareTo )
    {
      return (String) item > (String) compareTo;
    }
  }
  
  
  
  
  /**
   * Callback that sorts string values in ascending order
   *
   */
  public class SortDatesAsc extends Order
  {
    public override Boolean call( Object item, Object compareTo )
    {
      return (Date) item < (Date) compareTo;
    }
  }
  
  
  
  
  /**
   * Callback that sorts string values in descending order
   *
   */
  public class SortDatesDesc extends Order
  {
    public override Boolean call( Object item, Object compareTo )
    {
      return (Date) item > (Date) compareTo;
    }
  }
}