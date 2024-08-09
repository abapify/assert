class zcl_assertable definition
  public
  create public .

  public section.
  interfaces zif_assertable.
  aliases assert for zif_assertable~assert.
  protected section.
  methods is_unit_test returning value(result) type abap_bool.
  private section.
endclass.



class zcl_assertable implementation.
  method zif_assertable~assert.
    result = new zcl_assertable_checks( actual = actual unit_test = is_unit_test( ) ).
  endmethod.
  method is_unit_test.
    " by default is local
    result = abap_false.
  endmethod.

endclass.
