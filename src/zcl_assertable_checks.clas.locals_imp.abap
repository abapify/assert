*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
" please note that all conditions inside methods are inverted
" because only if it's not met we raise the exception

" local assetions ( outside of unit tests )
" must be CL_ABAP_UNIT_ASSERT compatible (only method/parameters used in lcl_assert_checks class)
class lcl_local_checks definition.
  public section.
    class-methods:
         assert_false
            importing act type any,
         assert_true
            importing act type any ,
        assert_bound
            importing act type any ,
        assert_not_bound
            importing act type any ,
        assert_initial
            importing act type any ,
        assert_not_initial
            importing act type any ,
        assert_equals
            importing
            act type any
            exp type any,
       assert_differs
            importing
            act type any
            exp type any.
  private section.
    class-methods assert.
endclass.

class lcl_local_checks implementation.
  method assert.
    raise resumable exception type zcx_assertable.
  endmethod.
  method assert_bound.
    check act is not bound.
    assert(  ).
  endmethod.

  method assert_differs.
    check act eq exp.
    assert(  ).
  endmethod.

  method assert_equals.
    check act ne exp.
    assert(  ).
  endmethod.

  method assert_initial.
    check act is not initial.
    assert(  ).
  endmethod.

  method assert_not_bound.
    check act is bound.
    assert(  ).
  endmethod.

  method assert_not_initial.
    check act is initial.
    assert(  ).
  endmethod.

  method assert_false.
    check act ne abap_false.
    assert(  ).
  endmethod.

  method assert_true.
    check act ne abap_true.
    assert(  ).
  endmethod.

endclass.
