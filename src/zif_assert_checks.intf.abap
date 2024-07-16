INTERFACE zif_assert_checks
  PUBLIC .
  INTERFACES zif_assert_checks_int.

  ALIASES:
      bound FOR zif_assert_checks_int~bound,
    not_bound FOR zif_assert_checks_int~not_bound,
    initial FOR zif_assert_checks_int~initial,
    not_initial FOR zif_assert_checks_int~not_initial,
    equals FOR zif_assert_checks_int~equals,
    differs FOR zif_assert_checks_int~differs,
    true for zif_assert_checks_int~true,
    false for zif_assert_checks_int~false,

    " extra aliases
    eq FOR zif_assert_checks_int~equals,
    ne FOR zif_assert_checks_int~differs.

ENDINTERFACE.
