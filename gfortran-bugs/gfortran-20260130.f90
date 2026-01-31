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
 
call sub([integer::]) ! passing a 0-sized integer array
contains
  subroutine sub(x)
    integer x(..)
    integer dims(rank(x))
    dims = shape(x)
    if (dims(1) /= 0) stop 1
  end subroutine
end
