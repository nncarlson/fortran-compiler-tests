!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94909
!!
!! REJECTS VALID CODE
!!
!! There is no recursion here.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 9.3.0
!! 
!! $ gfortran -c gfortran-20200501.f90 
!! gfortran-20200501.f90:13:10:
!! 
!!    13 |     dot = a%dot_(b)
!!       |          1
!! Error: Function 'dot' at (1) cannot be called recursively, as it is not RECURSIVE
!!

module example

  type, abstract :: foo
  contains
    procedure :: dot
    procedure(dot), deferred :: dot_
  end type

contains

  function dot(a, b)
    class(foo) :: a, b
    dot = a%dot_(b)
  end function

end module
