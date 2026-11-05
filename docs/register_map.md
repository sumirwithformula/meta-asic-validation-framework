# Provisional register map

All offsets are byte offsets on a planned 32-bit memory-mapped interface. This table is a proposed contract for the four-lane MAC and must be reviewed and frozen before RTL implementation.

| Offset | Name | Access | Definition |
|---:|---|:---:|---|
| `0x00` | `CONTROL` | R/W | Bit 0: start (write-one pulse); bit 1: soft reset (write-one pulse). |
| `0x04` | `STATUS` | R | Bit 0: busy; bit 1: done; bit 2: error. Clear behavior to be specified. |
| `0x08` | `VECTOR_A` | R/W | Four signed 8-bit lanes, lane 0 in bits `[7:0]`. |
| `0x0C` | `VECTOR_B` | R/W | Four signed 8-bit lanes, lane 0 in bits `[7:0]`. |
| `0x10` | `ACCUMULATOR` | R/W | Signed 32-bit initial accumulator value. |
| `0x14` | `RESULT` | R | Signed 32-bit result. |
| `0x18` | `CYCLE_COUNT` | R | Number of device clock cycles for the last completed operation. |
| `0x1C` | `ERROR_COUNT` | R | Number of detected protocol/device errors. |
| `0x20` | `DEVICE_ID` | R | Fixed identifier used by bring-up software. |
| `0x24` | `VERSION` | R | Register-interface/RTL version. |
| `0x28` | `FAULT_CTRL` | R/W | Test-only fault selector; zero disables injection. |

Frozen arithmetic contract v1: `VECTOR_A` and `VECTOR_B` each pack four signed 8-bit lanes, with lane 0 in bits `[7:0]` and lane 3 in bits `[31:24]`. `RESULT = ACCUMULATOR + sum(A[i] * B[i])` for lanes 0 through 3. Each product is sign-extended before addition. The signed 32-bit result wraps on overflow using two's-complement arithmetic.
