INTERFACE zif_assert_checks_int
  PUBLIC .
  METHODS:
    bound,
    not_bound,
    initial,
    not_initial,
    equals IMPORTING expected TYPE any,
    differs IMPORTING expected TYPE any,
    true,
    false.

ENDINTERFACE.
