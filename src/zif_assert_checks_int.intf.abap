interface zif_assert_checks_int
  public .
  methods:
    bound,
    not_bound,
    initial,
    not_initial,
    equals
      importing expected type any,
    differs
      importing expected type any,
    true,
    false.

endinterface.
