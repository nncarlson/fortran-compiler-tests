!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84120
!!
!! INVALID SYNTAX FOR PDT CONSTRUCTOR
!!
!! GFortran uses an invalid syntax for PDT constructors in which the type
!! parameters are regarded as a component of the derived type.  See R455 for
!! the constructor syntax (F08 standard), and R453 for the derived-type-spec.
!! Note that 1.3.33 defines what a "component" is, and it does not include
!! type parameters. The following example is invalid and should be rejected
!! by the compiler; gfortran accepts it, and runs without error.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 8.0.0 20171227 (experimental)
!! $ gfortran gfortran-20180130b.f90 
!! $ ./a.out && echo OKAY
!! OKAY

type foo(dim)
  integer,len :: dim
  integer :: array(dim)
end type
type(foo(:)), allocatable :: x
x = foo(2,[1,2])  ! INVALID SYNTAX THAT GFORTRAN USES
if (size(x%array) /= 2) stop 1
if (any(x%array /= [1,2])) stop 2
end
