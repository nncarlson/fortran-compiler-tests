!Issue number DPD200237121
!!
!! INTERNAL COMPILER ERROR -- INTEL 13.0.0
!!
!! % ifort --version
!! ifort (IFORT) 13.0.0 20120731
!! 
!! % ifort -c intel-bug-20121006b-1.f90 intel-bug-20121006b-2.f90 
!! 04010002_1529
!! 
!! intel-bug-20121006b-2.f90(4): catastrophic error: **Internal compiler error: internal abort** Please report this error along with the circumstances in which it occurred in a Software Problem Report.  Note: File and line given may not be explicit cause of this error.
!! compilation aborted for intel-bug-20121006b-2.f90 (code 1)
!!

module mod
contains
  subroutine sub (value)
    class(*), intent(in) :: value
  end subroutine
end module

! PUT THIS IN A SEPARATE SOURCE FILE
!program main
!  use mod
!  use,intrinsic :: iso_c_binding, only: c_long_long
!  call sub (int(1_c_long_long))
!end program
