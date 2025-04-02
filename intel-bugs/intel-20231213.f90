!! Fixed in 2025.1
!! POOR OUTPUT WITH G0 REAL FORMATTING
!!
!! This may not be a bug at all, but rather merely what I consider to be a
!! poor quality implementation choice permitted by the standard.
!!
!! With "-assume old_e0g0_format" ifx 2024.0 writes .5670000000000000E-13
!! With "-assume noold_e0g0_format" (implied by -standard-semantics) it
!! writes .6E-13
!!

use iso_fortran_env
write(*,'(g0)') 5.67e-14_real64
end
