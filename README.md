# Assert library  

Following official [documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/index.htm?file=abapmethods_testing.htm) we're supposed to write unit tests using following template
```
cl_abap_unit_assert=>assert_equals( act = myclass=>text
                                        exp = 'X' ).
```

The only function this library delivers - it allows us to use shorter construction like this:
```
assert( myclass=>text )->equals( 'X' ).
```

# Usage
To use this library you need to use `ZCL_ASSERT` class as a base class for your test class. 
```
CLASS ltcl_main DEFINITION INHERITING FROM zcl_assert
    FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
...
endclass.
```
