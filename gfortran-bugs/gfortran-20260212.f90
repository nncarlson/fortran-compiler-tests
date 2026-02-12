!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=123899
!!
!! WRONG RESULT FROM SELECT-RANK ON ASSUMED-RANK DUMMY AND 0-SIZED ACTUAL
!!
!! Note that declaring a rank-1, 0-sized array and passing that will
!! give the correct result. So there is something lacking in the
!! construction of the [integer::] temporary that is passed.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 15.2.0
!! $ gfortran gfortran-20260212.f90 
!! $ ./a.out
!! STOP 2

call sub([integer::])
contains
  subroutine sub(x)
    integer x(..)
    if (rank(x) /= 1) stop 1
    select rank (x)
    rank (1)
      ! should select here
    rank default
      stop 2
    end select
  end subroutine
end 
