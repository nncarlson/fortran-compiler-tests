!! RUNTIME ERROR WITH CALL TO DEFERRED MEMBER FUNCTION
!!
!! Failing with gfortran 8.2.1 20180831.
!! Succeeding with NAG 6.2 and Intel 17.0.6.
!!
!! The issue is that the call to foo%f is interpreted as a call to
!! foo%never_call1. And, foo%never_call1 calls foo%f, so that we end
!! up recursively calling foo%never_call1 despite there being no real
!! calls to that procedure. Essential modules are in the file
!! gfortran-20181114.f90, and must be in a separate file for the bug
!! to appear.
!!
!! WARNING: If compiled without the -fcheck=all flag, and run with
!!          unlimited stack size, it will consume all memory and lock
!!          up your machine in a few seconds.
!!
!! $ gfortran -g -fcheck=all gfortran-20181114.f90 gfortran-20181114-main.f90
!! $ ./a.out
!! At line 39 of file gfortran-20181114.f90
!! Fortran runtime error: Recursive call to nonrecursive procedure 'never_call1'
!!
!! Error termination. Backtrace:
!! #0  0x55b1599cd19d in __foo_class_MOD_never_call1
!! 	at .../gfortran-20181114.f90:39
!! #1  0x55b1599cd1bc in __foo_class_MOD_never_call1
!! 	at .../gfortran-20181114.f90:42
!! #2  0x55b1599cd220 in __foo_class_MOD_call_me
!! 	at .../gfortran-20181114.f90:34
!! #3  0x55b1599cd449 in test
!! 	at .../gfortran-20181114-main.f90:42
!! #4  0x55b1599cd49f in main
!! 	at .../gfortran-20181114-main.f90:32

program test

  use bar_class
  implicit none

  ! Some extension here is necessary for the bug
  ! to appear. It doesn't have to be empty.
  type, extends(bar) :: baz
  end type baz

  type(baz) :: a

  call a%call_me()

end program test
