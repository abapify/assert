# Assert library

> In the beginning this project contained class ZCL_ASSERT. We had to rename it becase the class was already [reserved](https://github.com/abapify/assert/issues/6) in dotabap registry.

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
To use this library you need to use `ZCL_ASSERTABLE_UNIT` class as a base class for your test class.
```abap
CLASS ltcl_main DEFINITION INHERITING FROM zcl_assertable_unit
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

## Working with references

You might have a reference pointing to the value and you would like to compare not the reference but the value it refers to. Instead of dereferencing in your using test you can write something like:
```
assert( data_reference )->ref( )->equals( 'Some value' ).
```
Please notice that it expects that actual value is a data refence and will throw an error if it's not. 
## Local asserts

It might be helpful to use assert interface in a normal runtime, not only in unit tests.
```abap
data(assert) = new zcl_assertable( ).
assert->assert( 1 )->not_initial( ).
```
or if your class is inherited from `ZCL_ASSERTABLE` then simply like this
```abap
assert( 1 )->not_initial( ).
```
alternatively you can implement zif_assert interface right in your class:
```abap
class zcl_your_class definition.
  public section.
    interfaces zif_assertable.
  private section.
    aliases assert for zif_assertable~assert.
    methods some_method.
endclass.
class zcl_your_class implementation.
  method zif_assertable~assert.
    result = new zcl_assertable( actual = actual ).
  endmethod.
  method some_method.
    assert( some_value )->eq( another_value ).
  endmethod.
endclass.
```

> PLease notice in this case if `zif_assertable` interface will be extended ( with methods/parameters ) you will have to support this change too in your class.
>

### Exception handling in local mode
One more feature which local asserts bring is a resumable exception. For example you can assert and catch assertion exception (which native asserts do not support BTW).
```abap
try.
  assert( ref )->is_bound( ).
catch zcx_assertable.
  " some exception handling
endtry.
```

Since `ZCX_ASSERTABLE` is a no-check exception you can bring it higher and do even more advanced logic
```abap
method main.
  try.
    do_something( ref ).
  catch before unwind zcx_assertable.
    " fix the problem here
    ref = new #( ).
    resume.
  endtry.
endmethod.

method do_something.
  assert( ref )->is_bound( ).
endmethod.
```
