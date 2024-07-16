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

# Usage
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
```
