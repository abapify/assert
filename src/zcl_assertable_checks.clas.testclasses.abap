*"* use this source file for your ABAP unit test classes
class ltcl_main definition final for testing inheriting from zcl_assertable_unit
  duration short
  risk level harmless.

  public section.

    methods unit for testing  raising cx_static_check.
    methods test_local for testing  raising cx_static_check.

  private section.
    methods positive importing that type ref to zif_assertable raising cx_static_check.
    methods negative importing that type ref to zif_assertable raising cx_static_check .

endclass.

class ltcl_main implementation.

  method positive.

    data not_bound type ref to ltcl_main.
    data(sample_text) = 'Sample text'.

    that->assert( 1 )->not_initial( ).
    that->assert( 1 )->eq( 1 ).
    that->assert( 1 )->ne( 2 ).
    that->assert( new ltcl_main( ) )->bound( ).
    that->assert( not_bound )->not_bound( ).
    that->assert( abap_true )->true( ).
    that->assert( abap_false )->false( ).
    that->assert( ref #( sample_text ) )->ref( )->eq( sample_text ).

    try.
        that->assert( sample_text )->ref( )->eq( sample_text ).
      catch cx_static_check into data(lo_cx_not_a_ref).
    endtry.
    that->assert( lo_cx_not_a_ref )->bound( ).


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
      data(assert) = new zcl_assertable( ).
      " positive test - no exceptions expected
      positive( assert ).
      " negative test
      " each check should raise the exception
      data errors_caught type i.
      try.
          negative( assert ).
        catch before unwind zcx_assertable.
          errors_caught = errors_caught + 1.
          resume.
      endtry.

      assert( errors_caught )->eq( 8 ).

    endmethod.

    method unit.
      positive( new zcl_assertable_unit( ) ).
    endmethod.

endclass.
