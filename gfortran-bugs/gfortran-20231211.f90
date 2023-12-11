!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=112964
!!
!! INTERNAL COMPILER ERROR
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 13.2.0
!!
!! $ gfortran gfortran-20231211.f90 
!! gfortran-20231211.f90:10:20:
!! 
!!    24 |       call foo(x(n))
!!       |                    1
!! internal compiler error: Segmentation fault

call foo([1,2])
contains
recursive subroutine foo(x)
  class(*), intent(in) :: x(..)
  integer :: n
  select rank (x)
  rank (0)
  rank (1)
    do n = 1, size(x,1)
      call foo(x(n))
    end do
  end select
end subroutine
end
