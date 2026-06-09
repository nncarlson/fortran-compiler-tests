!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125578
!!
!! FAILURE TO DEFAULT INITIALIZE INTENT(OUT) POLYMORPHIC PDT DUMMY
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 16.1.1 20260517
!! 
!! $ gfortran gfortran-20260602a.f90 
!! $ ./a.out
!!  initial x%n     =           42
!!  after reset x%n =            0
!! ERROR STOP PDT polymorphic intent(out) reset lost scalar default initialization
!! 
!! Error termination. Backtrace:
!! #0  0x400603 in ???
!! #1  0x4006ef in ???
!! #2  0x7efe9c8105b4 in ???
!! #3  0x7efe9c810667 in ???
!! #4  0x4003b4 in ???
!! #5  0xffffffffffffffff in ???

program gcc_default_initialization

  type :: owner(k)
    integer, kind :: k = kind(0)
    integer :: n = 42
  end type

  type(owner(kind(0))) :: x

  print *, 'initial x%n     = ', x%n
  call reset(x)
  print *, 'after reset x%n = ', x%n

  if (x%n /= 42) error stop 'PDT polymorphic intent(out) reset lost scalar default initialization'

contains

  subroutine reset(this)
    type(owner(kind(0))), intent(out) :: this
  end subroutine

end program
