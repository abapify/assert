INTERFACE zif_assert_checks
  PUBLIC .
  METHODS:
    bound,
    not_bound,
    initial,
    not_initial,
    eq IMPORTING expected TYPE any.

ENDINTERFACE.
