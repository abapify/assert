INTERFACE zif_assertable_checks
  PUBLIC .
  INTERFACES zif_assertable_checks_int.

  ALIASES:
      bound FOR zif_assertable_checks_int~bound,
    not_bound FOR zif_assertable_checks_int~not_bound,
    initial FOR zif_assertable_checks_int~initial,
    not_initial FOR zif_assertable_checks_int~not_initial,
    equals FOR zif_assertable_checks_int~equals,
    differs FOR zif_assertable_checks_int~differs,
    true for zif_assertable_checks_int~true,
    false for zif_assertable_checks_int~false,

    " extra aliases
    eq FOR zif_assertable_checks_int~equals,
    ne FOR zif_assertable_checks_int~differs.

    methods ref returning value(result) type ref to zif_assertable_checks raising cx_static_check.

ENDINTERFACE.
