*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_assert_checks DEFINITION.
  PUBLIC SECTION.
    INTERFACES zif_assert_checks.
    METHODS constructor
      IMPORTING actual TYPE any.
  PRIVATE SECTION.
    DATA actual TYPE REF TO data.
ENDCLASS.

CLASS lcl_assert_checks IMPLEMENTATION.
  METHOD constructor.
    me->actual = REF #( actual ).
  ENDMETHOD.
  METHOD zif_assert_checks~eq.
    ASSERT actual IS BOUND.
    ASSIGN actual->* TO FIELD-SYMBOL(<actual>).
    cl_abap_unit_assert=>assert_equals( exp = expected act = <actual> ).
  ENDMETHOD.
  METHOD zif_assert_checks~bound.
    ASSERT actual IS BOUND.
    ASSIGN actual->* TO FIELD-SYMBOL(<actual>).
    cl_abap_unit_assert=>assert_bound( <actual> ).
  ENDMETHOD.
  METHOD zif_assert_checks~not_bound.
    ASSERT actual IS BOUND.
    ASSIGN actual->* TO FIELD-SYMBOL(<actual>).
    cl_abap_unit_assert=>assert_not_bound( <actual> ).
  ENDMETHOD.
  METHOD zif_assert_checks~initial.
    ASSERT actual IS BOUND.
    ASSIGN actual->* TO FIELD-SYMBOL(<actual>).
    cl_abap_unit_assert=>assert_initial( <actual> ).
  ENDMETHOD.
  METHOD zif_assert_checks~not_initial.
    ASSERT actual IS BOUND.
    ASSIGN actual->* TO FIELD-SYMBOL(<actual>).
    cl_abap_unit_assert=>assert_not_initial( <actual> ).
  ENDMETHOD.
ENDCLASS.
