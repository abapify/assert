class ZCL_ASSERTABLE_CHECKS definition
  public
  create public .

public section.

  interfaces ZIF_ASSERTABLE_CHECKS_INT .
  interfaces ZIF_ASSERTABLE_CHECKS .

  methods CONSTRUCTOR
    importing
      !ACTUAL type ANY
      !UNIT_TEST type ABAP_BOOL optional .
protected section.
  private section.
    data assertion_class type string value 'LCL_LOCAL_CHECKS'.
    data actual type ref to data.
    data unit_test type abap_bool.

    methods params
      importing expected      type ref to data optional
      returning value(result) type ref to abap_parmbind_tab.

    methods throw importing object type any raising cx_static_check.

ENDCLASS.



CLASS ZCL_ASSERTABLE_CHECKS IMPLEMENTATION.


  method constructor.

    create data me->actual like actual.
    assign me->actual->* to field-symbol(<actual>).
    <actual> = actual.

    me->unit_test = unit_test.
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


  METHOD throw.

    zcl_throw=>from( object ).

  ENDMETHOD.


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


  method zif_assertable_checks~bound.
    data(params) = params( ).
    call method (assertion_class)=>assert_bound
      parameter-table params->*.
  endmethod.


  method zif_assertable_checks~differs.
    data(params) = params( ref #( expected ) ).
    call method (assertion_class)=>assert_differs
      parameter-table params->*.
  endmethod.


  method zif_assertable_checks~equals.
    data(params) = params( ref #( expected ) ).
    call method (assertion_class)=>assert_equals
      parameter-table params->*.
  endmethod.


  method zif_assertable_checks~initial.
    data(params) = params( ).
    call method (assertion_class)=>assert_initial
      parameter-table params->*.
  endmethod.


  method zif_assertable_checks~not_bound.
    data(params) = params( ).
    call method (assertion_class)=>assert_not_bound
      parameter-table params->*.
  endmethod.


  method zif_assertable_checks~not_initial.
    data(params) = params( ).
    call method (assertion_class)=>assert_not_initial
      parameter-table params->*.
  endmethod.


  method zif_assertable_checks~ref.

    " returns assert interface for the reference value
    try.

        data actual type ref to data.
        actual = cast #( me->actual ).
        assign actual->* to field-symbol(<actual>).

        "in this case we expect that actual value is also ref to data
        data actual_ref type ref to data.
        actual_ref = cast #( <actual> ).
        assign actual_ref->* to field-symbol(<actual_ref>).

        result = new zcl_assertable_checks( actual = <actual_ref> unit_test = me->unit_test ).

      catch cx_sy_move_cast_error.

        throw( 'Asserted value is not a data reference' ).

    endtry.

  endmethod.
ENDCLASS.
