!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=119986
!! Fixed in gfortran 15.1.1 (20250605)
!!
!! INCORRECT RESULTS
!!
!! The correct real and imaginary part references of a complex array
!! are not being passed to the subroutine.
!!

program main
  type :: my_type
    complex, allocatable :: phi(:)
  end type
  integer :: j
  type(my_type) :: x
  x%phi = [(cmplx(j,-j),j=1,4)]
  call fubar(x%phi%re, x%phi%im)
contains
  subroutine fubar(u, v)
    real, intent(in) :: u(:), v(:)
    if (any(u /= [1,2,3,4])) stop 1
    if (any(v /= -[1,2,3,4])) stop 2
    !print *, 'phi%re:', u
    !print *, 'phi%im:', v
  end subroutine
end program
