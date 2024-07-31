INTERFACE zif_assertable
  PUBLIC .
  METHODS assert
    IMPORTING actual TYPE any
    RETURNING VALUE(result) TYPE REF TO zif_assertable_checks.
ENDINTERFACE.
