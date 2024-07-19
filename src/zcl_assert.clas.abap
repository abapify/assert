CLASS zcl_assert DEFINITION
  PUBLIC
  CREATE public .

  PUBLIC SECTION.
  INTERFACES zif_assert.
  ALIASES assert for zif_assert~assert.
  class-methods: get_local returning value(result) type ref to zif_assert.
  PROTECTED SECTION.
  data is_local type abap_bool.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_assert IMPLEMENTATION.
method get_local.
    result = new lcl_assert_local( ).
endmethod.
METHOD zif_assert~assert.
result = NEW lcl_assert_checks( actual = actual local = me->is_local ).
ENDMETHOD.
ENDCLASS.


