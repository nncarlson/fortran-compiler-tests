!!
!! WRONG RESULT FROM SHAPE ON ASSUMED-RANK DUMMY AND 0-SIZED ACTUAL
!!
!! Note that declaring a rank-1, 0-sized array and passing that will
!! give the correct result. So there is something lacking in the
!! construction of the [integer::] temporary that is passed.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 15.2.0
!! $ gfortran gfortran-20260130.f90 
!! $ ./a.out
!! STOP 1
 
integer y(0)
if (foo(y) /= 0) stop 1
if (foo([integer::]) /= 0) stop 2
if (foo(y-1) /= 0) stop 3
contains
  integer function foo(x) result(n)
    integer x(..)
    integer dims(rank(x))
    dims = shape(x)
    n = dims(1)
  end function
end
