!! Bug report: CMPLRIL0-34602
!!
!! SPURIOUS BOUNDS ERROR FOR MISSING OPTIONAL ARGUMENT
!!
!! The bounds checking runtime should not be doing anything with a missing
!! optional argument. Curiously there is no error if the array A is of integer type.
!!
!! $ ifort --version
!! ifort (IFORT) 2021.5.0 20211109
!! 
!! $ ifort -O0 -check shape -traceback intel-20220211.f90 
!! $ ./a.out
!! forrtl: severe (408): fort: (33): Shape mismatch: The extent of dimension 1 of array X is 2 and the corresponding extent of array M is 0
!! 
!! Image              PC                Routine            Line        Source             
!! a.out              00000000004065DF  Unknown               Unknown  Unknown
!! a.out              00000000004039F6  MAIN__                     29  intel-20220211.f90
!! a.out              0000000000403862  Unknown               Unknown  Unknown
!! libc-2.32.so       00007F1E9B4961E2  __libc_start_main     Unknown  Unknown
!! a.out              000000000040376E  Unknown               Unknown  Unknown

program main

  real :: a(2)
  logical :: mask(2)

  a = [1,2]
  mask = [.true.,.false.]
  
  if (foo(a,mask) /= 1) stop 1
  if (foo(a) /= 2) stop 2

contains

  real function foo(x, m)
    real, intent(in) :: x(:)
    logical, intent(in), optional :: m(:)
    foo = maxval(x, m)
  end function

end program
    
