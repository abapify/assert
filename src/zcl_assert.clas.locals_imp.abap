*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

class lcl_assert_checks definition.
  public section.
    interfaces zif_assert_checks.
    methods constructor
      importing
        actual type any
        local  type abap_bool.

  private section.
    data assertion_class type string value 'CL_ABAP_UNIT_ASSERT'.
    data actual type ref to data.
    data local type abap_bool.

    methods params
      importing expected      type ref to data optional
      returning value(result) type ref to abap_parmbind_tab.
endclass.

class lcl_assert_checks implementation.
  method constructor.
    me->actual = ref #( actual ).
    if local eq abap_true.
      me->assertion_class = 'LCL_LOCAL_CHECKS'.
    endif.
  endmethod.
  method params.
    result = new #(  ).
    if actual is bound.
      insert value #( name = 'ACT' kind = cl_abap_objectdescr=>exporting value = actual  ) into table result->*.
    endif.
    if expected is bound.
      insert value #( name = 'EXP' kind = cl_abap_objectdescr=>exporting value = expected  ) into table result->*.
    endif.
  endmethod.
  method zif_assert_checks~bound.
    data(params) = params( ).
    call method (assertion_class)=>assert_bound
      parameter-table params->*.
  endmethod.
  method zif_assert_checks~not_bound.
    data(params) = params( ).
    call method (assertion_class)=>assert_not_bound
      parameter-table params->*.
  endmethod.
  method zif_assert_checks~initial.
    data(params) = params( ).
    call method (assertion_class)=>assert_initial
      parameter-table params->*.
  endmethod.
  method zif_assert_checks~not_initial.
    data(params) = params( ).
    call method (assertion_class)=>assert_not_initial
      parameter-table params->*.
  endmethod.
  method zif_assert_checks~equals.
    data(params) = params( ref #( expected ) ).
    call method (assertion_class)=>assert_equals
      parameter-table params->*.
  endmethod.
  method zif_assert_checks~differs.
    data(params) = params( ref #( expected ) ).
    call method (assertion_class)=>assert_differs
      parameter-table params->*.
  endmethod.

  method zif_assert_checks_int~false.
    data(params) = params(  ).
    call method (assertion_class)=>assert_false
      parameter-table params->*.
  endmethod.

  method zif_assert_checks_int~true.
    data(params) = params(  ).
    call method (assertion_class)=>assert_true
      parameter-table params->*.
  endmethod.

endclass.

class lcx_assert definition inheriting from zcx_assert.
endclass.

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
" please note that all conditions inside methods are inverted
" because only if it's not met we raise the exception
class lcl_local_checks implementation.
  method assert.
    raise resumable exception type lcx_assert.
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

class lcl_assert_local definition inheriting from zcl_assert.
  public section.
  methods constructor.
endclass.
class lcl_assert_local implementation.
  method constructor.
    super->constructor( ).
    me->is_local = abap_true.
  endmethod.
endclass.
