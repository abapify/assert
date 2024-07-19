*"* use this source file for your ABAP unit test classes
class ltcl_main definition final for testing inheriting from zcl_assert
  duration short
  risk level harmless.

  public section.

  private section.
    methods positive importing that type ref to zif_assert raising zcx_assert.
    methods negative importing that type ref to zif_assert raising zcx_assert..
    methods unit for testing
      raising
        zcx_assert.
    methods test_local for testing
      raising
        zcx_assert.

endclass.

class ltcl_main implementation.

  method positive.

    data not_bound type ref to ltcl_main.

    that->assert( 1 )->not_initial( ).
    that->assert( 1 )->eq( 1 ).
    that->assert( 1 )->ne( 2 ).
    that->assert( new ltcl_main( ) )->bound( ).
    that->assert( not_bound )->not_bound( ).
    that->assert( abap_true )->true( ).
    that->assert( abap_false )->false( ).

  endmethod.

  method negative.

    data not_bound type ref to ltcl_main.

    that->assert( 1 )->initial( ).
    that->assert( 0 )->not_initial( ).
    that->assert( 1 )->ne( 1 ).
    that->assert( 1 )->eq( 2 ).
    that->assert( new ltcl_main( ) )->not_bound( ).
    that->assert( not_bound )->bound( ).
    that->assert( abap_true )->false( ).
    that->assert( abap_false )->true( ).

  endmethod.

  method test_local.
    data(assert) = new zcl_assert_local( ).
    " positive test - no exceptions expected
    positive( assert ).
    " negative test
    " each check should raise the exception
    data errors_caught type i.
    try.
        negative( assert ).
      catch before unwind lcx_assert.
        errors_caught = errors_caught + 1.
        resume.
    endtry.

    assert( errors_caught )->eq( 8 ).

  endmethod.

  method unit.
    positive( new zcl_assert( ) ).
  endmethod.

endclass.
