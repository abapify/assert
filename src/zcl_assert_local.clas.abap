class zcl_assert_local definition inheriting from zcl_assert
  public
  final
  create public .

  public section.
  "! <p class="shorttext synchronized" lang="en"></p>
  "!
  methods constructor.
  protected section.
  private section.
endclass.



class zcl_assert_local implementation.
  method constructor.
    super->constructor( ).
    me->local = abap_true.
  endmethod.

endclass.
