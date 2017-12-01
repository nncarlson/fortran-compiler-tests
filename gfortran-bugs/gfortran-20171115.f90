!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83012
!! fixed in 254914 (2017-11-18)
!!
!! In this example the pointer assignment p => x%dataptr() is rejected
!! because the compiler does not recognize the function result x%dataptr()
!! as contiguous when in fact it is simply contiguous by definition.
!! Note that there is no error if the dummy variable x is declared as
!! type(foo) instead of class(foo).
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 8.0.0 20171115 (experimental)
!! 
!! $ gfortran -c bug.f90 
!! bug.f90:19:7:
!! 
!!    p => x%dataptr()
!!        1
!! Error: Assignment to contiguous pointer from non-contiguous target at (1)

module mod
  type :: foo
    integer, pointer, contiguous :: p(:)
  contains
    procedure :: dataptr
  end type
contains
  function dataptr(this) result(dp)
    class(foo), intent(in) :: this
    integer, pointer, contiguous :: dp(:)
    dp => this%p
  end function
end module

subroutine bar(x)
  use mod
  class(foo) :: x
  integer, pointer, contiguous :: p(:)
  p => x%dataptr()
end subroutine
