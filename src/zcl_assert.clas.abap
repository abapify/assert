CLASS zcl_assert DEFINITION
  PUBLIC
  CREATE public .

  PUBLIC SECTION.
  INTERFACES zif_assert.
  ALIASES assert for zif_assert~assert.
  PROTECTED SECTION.
  data local type abap_bool.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_assert IMPLEMENTATION.
METHOD zif_assert~assert.
result = NEW lcl_assert_checks( actual = actual local = me->local ).
ENDMETHOD.
ENDCLASS.


