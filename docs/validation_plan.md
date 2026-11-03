# Validation plan

## Initial multiplier milestone

- Positive and negative signed products
- Zero operand
- Minimum and maximum signed input boundaries
- Self-checking testbench with an explicit expected result per case
- Icarus Verilog simulation and Verilator lint

## Planned accelerator regression

- Directed arithmetic and register-map cases
- Seeded-random vectors compared with a Python golden model
- Timeout, invalid-access, reset, and repeated-start behavior
- At least three deterministic fault modes with diagnostics and recovery checks
- Long-run back-to-back operations with error and recovery statistics
- JSON/CSV results that record test seed and reproduction details

No results are claimed until the tests are implemented and run. Every failure should be replayable from its saved seed and configuration.
