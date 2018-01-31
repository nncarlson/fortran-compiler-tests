!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84120
!!
!! GFORTRAN REJECTS VALID SYNTAX FOR PDT CONSTRUCTOR
!!
!! The is the "correct syntax" version of gfortran-20180130b.f90.
!! GFortran 8.0 rejects it.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 8.0.0 20171227 (experimental)
!! $ gfortran gfortran-20180130c.f90 
!! gfortran-20180130c.f90:22:9:
!! 
!!  x = foo(2)([1,2])
!!          1
!! Error: Invalid character in name at (1)

type foo(dim)
  integer,len :: dim
  integer :: array(dim)
end type
type(foo(:)), allocatable :: x
x = foo(2)([1,2])
if (size(x%array) /= 2) stop 1
if (any(x%array /= [1,2])) stop 2
end
