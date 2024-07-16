*"* use this source file for your ABAP unit test classes
class ltcl_main definition INHERITING FROM zcl_assert final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      main for testing raising cx_static_check.
endclass.


class ltcl_main implementation.

  method main.

    data not_bound TYPE REF TO ltcl_main.

    assert( 1 )->not_initial( ).
    assert( 1 )->eq( 1 ).
    assert( 1 )->ne( 2 ).
    assert( new ltcl_main( ) )->bound( ).
    assert( not_bound )->not_bound( ).
    assert( abap_true )->true(  ).
    assert( abap_false )->false(  ).

  endmethod.

endclass.
