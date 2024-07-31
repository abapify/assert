class zcl_assertable_unit definition
  public
  inheriting from zcl_assertable.

  public section.
  protected section.
  methods is_unit_test redefinition.
  private section.
endclass.

class zcl_assertable_unit implementation.
  method is_unit_test.
    result = abap_true.
  endmethod.
endclass.
