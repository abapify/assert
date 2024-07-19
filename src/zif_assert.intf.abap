INTERFACE zif_assert
  PUBLIC .
  METHODS assert
    IMPORTING actual TYPE any
    RETURNING VALUE(result) TYPE REF TO zif_assert_checks.
ENDINTERFACE.
