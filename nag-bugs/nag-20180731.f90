!! WRONG CODE WITH -nan
!!
!! With the -nan option the 6.2 compiler generates incorrect code for the
!! following example. The print statement shows that the assignment of 0
!! to the automatic array A is incomplete; only the (:,1) section is defined.
!!
!! The error is dependent on assigning an integer value rather than real,
!! requiring type conversion, and on one of the array sizes being a parameter.
!!
!! $ nagfor -nan nag-20180731.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6210
!! [NAG Fortran Compiler normal termination]
!! [nnc@arriba nag-bugs]$ ./a.out
!!    0.0000000   0.0000000 NaN NaN NaN NaN

integer, parameter :: n = 2
integer :: m = 3
call foo
contains
  subroutine foo
    real :: a(n,m)
    a = 0
    print *, a
  end subroutine
end
