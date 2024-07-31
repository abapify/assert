class zcl_assertable_checks definition
  public
   .

   public section.
    interfaces zif_assertable_checks.
    methods constructor
      importing
        actual    type any
        unit_test type abap_bool optional.

  private section.
    data assertion_class type string value 'LCL_LOCAL_CHECKS'.
    data actual type ref to data.

    methods params
      importing expected      type ref to data optional
      returning value(result) type ref to abap_parmbind_tab.

endclass.



class zcl_assertable_checks implementation.
 method constructor.
    me->actual = ref #( actual ).
    if unit_test eq abap_true.
      me->assertion_class = 'CL_ABAP_UNIT_ASSERT'.
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
  method zif_assertable_checks~bound.
    data(params) = params( ).
    call method (assertion_class)=>assert_bound
      parameter-table params->*.
  endmethod.
  method zif_assertable_checks~not_bound.
    data(params) = params( ).
    call method (assertion_class)=>assert_not_bound
      parameter-table params->*.
  endmethod.
  method zif_assertable_checks~initial.
    data(params) = params( ).
    call method (assertion_class)=>assert_initial
      parameter-table params->*.
  endmethod.
  method zif_assertable_checks~not_initial.
    data(params) = params( ).
    call method (assertion_class)=>assert_not_initial
      parameter-table params->*.
  endmethod.
  method zif_assertable_checks~equals.
    data(params) = params( ref #( expected ) ).
    call method (assertion_class)=>assert_equals
      parameter-table params->*.
  endmethod.
  method zif_assertable_checks~differs.
    data(params) = params( ref #( expected ) ).
    call method (assertion_class)=>assert_differs
      parameter-table params->*.
  endmethod.

  method zif_assertable_checks_int~false.
    data(params) = params(  ).
    call method (assertion_class)=>assert_false
      parameter-table params->*.
  endmethod.

  method zif_assertable_checks_int~true.
    data(params) = params(  ).
    call method (assertion_class)=>assert_true
      parameter-table params->*.
  endmethod.

endclass.
