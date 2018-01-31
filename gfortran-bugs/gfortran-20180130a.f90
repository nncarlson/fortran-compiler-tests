!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84119
!!
!! TYPE PARAMETER INQUIRY SHOULD ALWAYS RETURN A SCALAR
!!
!! See Note 6.7 (F08).  GFortran 8.0 returns an array when the designator
!! is an array, essentially treating type inquiry as a reference to a
!! component of the type; same syntax, but not the same thing.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 8.0.0 20171227 (experimental)
!! $ gfortran gfortran-20180130a.f90 
!! $ ./a.out
!! STOP 1

type :: vector(dim,kind)
  integer, len :: dim
  integer, kind :: kind
end type
type(vector(3,1)) :: a(10)
if (size(shape(a%dim)) /= 0) stop 1
if (size(shape(a%kind)) /= 0) stop 2
end
