!! INCORRECT RESULTS
!!
!! A zero-based actual array is indexed incorrectly through an assumed-shape
!! polymorphic dummy. X(1)%VALUE should be A(0)%VALUE (42), but gfortran
!! instead returns A(1)%VALUE (99).
!!
!! Fails with gfortran 15.2.0 and 16.1.1 (20260517) at -O0 and -O2,
!! including with -fcheck=all. Passes with NAG 7.2 (build 7245),
!! Intel ifx 2026.0.0, and LLVM Flang 22.1.5.
!! Making A one-based or replacing CLASS(T) with TYPE(T) avoids the bug.
!!

program main
  implicit none
  type :: t
    integer :: value
  end type
  type(t) :: a(0:1) = [t(42), t(99)]
  call check(a)
contains
  subroutine check(x)
    class(t), intent(in) :: x(:)
    if (x(1)%value /= 42) stop 1
  end subroutine
end program
