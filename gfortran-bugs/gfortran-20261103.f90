!! Fixed in gfortran 16.1.1 (verified with 20260517).
!!
!! INCORRECT RESULTS
!!
!! A noncontiguous section passed through SELECT RANK to an assumed-size
!! dummy is not packed. X(2) is 2 instead of 3.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 15.2.0
!! $ gfortran gfortran-20261103.f90
!! $ ./a.out
!! STOP 1
!!

integer :: a(3) = [1,2,3]
call sub(a(::2))
contains
  subroutine sub(x)
    integer, intent(in) :: x(..)
    select rank (x)
    rank (1)
      call check(x)
    end select
  end subroutine
  subroutine check(x)
    integer, intent(in) :: x(*)
    if (x(2) /= 3) stop 1
  end subroutine
end
