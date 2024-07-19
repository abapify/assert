# Assert library  

Following official [documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/index.htm?file=abapmethods_testing.htm) we're supposed to write unit tests using following template
```abap
cl_abap_unit_assert=>assert_equals( act = myclass=>text
                                        exp = 'X' ).
```

The only function this library delivers - it allows us to use shorter construction like this:
```abap
assert( myclass=>text )->equals( 'X' ).
```

## Usage in unit tests
To use this library you need to use `ZCL_ASSERT` class as a base class for your test class. 
```abap
CLASS ltcl_main DEFINITION INHERITING FROM zcl_assert
    FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
...
endclass.
```

then later in your code you can just use something like:
```abap
    assert( 1 )->not_initial( ).
    assert( 1 )->eq( 1 ).
    assert( 1 )->ne( 2 ).
    assert( new ltcl_main( ) )->bound( ).
    assert( not_bound )->not_bound( ).
    assert( abap_true )->true( ).
    assert( abap_false )->false( ).
```

## Local asserts

It might be helpful to use assert interface in a nomral runtime, not only in unit tests. 
```abap
data(assert) = new zcl_assert_local( ).
assert->assert( 1 )->not_initial( ).
```
or if your class is inherited from ZCL_ASSERT_LOCAL then simply like this
```abap
assert( 1 )->not_initial( ).
```
alternatively you can implement zif_assert interface right in your class:
```abap
class zcl_your_class definition.
  public section.
    interfaces zif_assert.
  private section.
    aliases assert for zif_assert~assert.
    methods some_method.
endclass.
class zcl_your_class implementation.
  method zif_assert~assert.
    result = new zcl_assert_local( actual = actual ).
  endmethod.
  method some_method.
    assert( some_value )->eq( another_value ).
  endmethod.
endclass.
```

> PLease notice in this case if zcl_assert_local interface will be extended ( with methods/parameters ) you will have to support this change too in your class.
>

### Exception handling in local mode
One more feature which local asserts bring is a resumable exception. For example you can assert and catch assertion exception (which native asserts do not support BTW).
```abap
try.
  assert( ref )->is_bound( ).
catch zcx_assert.
  " some exception handling  
endtry.
```

Since ZCX_ASSERT is a no-check exception you can bring it higher and do even more advanced logic
```abap
method main.
  try.
    do_something( ref ).
  catch before unwind zcx_assert.
    " fix the problem here
    ref = new #( ).
    resume.
  endtry.
endmethod.

method do_something.
  assert( ref )->is_bound( ).
endmethod.
```
