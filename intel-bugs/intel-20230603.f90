!!
!! INTERNAL COMPILER ERROR
!!
!! The following coarray example triggers an ICE with ifort 2021.9.0 and
!! ifx 2023.1.0. Use of the CONTIGUOUS attribute triggers the ICE. 
!!
!! $ ifort --version
!! ifort (IFORT) 2021.9.0 20230302
!!
!! $ ifort -coarray -coarray-num-images=2 bug.f90 
!! bug.f90(14): catastrophic error: **Internal compiler error: internal abort** Please report this error along with the circumstances in which it occurred in a Software Problem Report.  Note: File and line given may not be explicit cause of this error.
!! compilation aborted for bug.f90 (code 1)
!! 
!! $ ifx --version
!! ifx (IFX) 2023.1.0 20230320
!! 
!! $ ifx -coarray -coarray-num-images=2 bug.f90 
!!           #0 0x0000000001f63112
!!           #1 0x0000000001fc5727
!!              ...
!!          #24 0x00007fe764a29510
!!          #25 0x00007fe764a295c9 __libc_start_main + 137
!!          #26 0x0000000001cf1729
!! 
!! bug.f90(21): error #5623: **Internal compiler error: internal abort** Please report this error along with the circumstances in which it occurred in a Software Problem Report.  Note: File and line given may not be explicit cause of this error.
!!     if (this_image() < num_images()) call sub2(a, a(:)[this_image()+1])
!! -----------------------------------------------^
!! compilation aborted for bug.f90 (code 3)

module mod
  implicit none
contains
  subroutine sub0(a)
    real, intent(inout) :: a(:)[*]
    call sub1(a)
  end subroutine
  subroutine sub1(a)
    real, intent(inout) :: a(:)[*]
    if (this_image() < num_images()) call sub2(a, a(:)[this_image()+1])
  end subroutine
  subroutine sub2(x, y)
    real, contiguous, intent(inout) :: x(:), y(:) ! CONTIGUOUS TRIGGERS ICE
    if (any(x /= y)) error stop
  end subroutine
end module
use mod
real, allocatable :: a(:)[:]
allocate(a(2)[*])
a = [1, 2]
sync all
call sub1(a)
end
