!!
!! SYNOPSIS: compiler mishandles use-only clause
!!
!! The 9.0 (EM64T) compiler incorrectly complains that there is no specific
!! procedure available for init with argument of typeA, when typeAB_mod
!! does export it.  The use-only and public lines in typeAB_mod (which are
!! actually unnecessary in this specific situation, but legal nevertheless)
!! appear to be confusing the compiler.
!!
!! % ifort --version
!! ifort (IFORT) 9.0 20060120
!!
!! % ifort intel-bug-20060301.f90
!! fortcom: Error: intel-bug-20060301.f90, line 56: There is no matching specific subroutine for this generic subroutine call.   [INIT]
!!   call init (a)
!! -------^
!! compilation aborted for intel-bug-20060301.f90 (code 1)
!!

module typeA_mod
  private
  public :: typeA, init
  type :: typeA
    integer :: n
  end type typeA
  interface init
    module procedure init_typeA
  end interface
contains
  subroutine init_typeA (a)
    type(typeA), intent(inout) :: a
    a%n = 0
  end subroutine init_typeA
end module typeA_mod

module typeAB_mod
  use typeA_mod, only : typeA, init   ! THESE TWO LINES (UNNECESSARY IN THIS
  public :: init                      ! SPECIFIC CONTEXT) ARE CONFUSING THE COMPILER.
  type :: typeB
    integer :: n
  end type typeB
  interface init
    module procedure init_typeB
  end interface
contains
  subroutine init_typeB (b)
    type(typeB), intent(out) :: b
    b%n = 0
  end subroutine init_typeB
end module typeAB_mod

subroutine use_init_typeA (a, b)
  use typeAB_mod  !! This provides init specifics for both typeA and typeB !!
  type(typeA), intent(inout) :: a
  type(typeB), intent(inout) :: b
  call init (a)
  call init (b)
end subroutine use_init_typeA
