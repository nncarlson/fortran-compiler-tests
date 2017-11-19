!!
!! SYNOPSIS: Specific procedure for generic lost through nested modules
!!
!! The 10.0.017 beta compiler (EM64T) incorrectly complains that there is no
!! specific procedure available for init with argument of typeA, when typeAB_mod
!! does export it.  The use-only line in typeAB_mod (which is unnecessary in
!! this specific situation, but legal nevertheless) appears to be confusing the
!! compiler.
!!
!! Note that this example code is just a slight various of the code submitted
!! with issue number 356310 against the 9.0 compiler (since fixed); the only
!! difference is the intermediate collection_mod module.
!!
!! % ifort --version
!! ifort (IFORT) 10.0 20070307
!!
!! % ifort -c intel-10.0-beta-bug01.f90
!! fortcom: Error: intel-10.0-beta-bug01.f90, line 63: There is no matching specific subroutine for this generic subroutine call.   [INIT]
!!   call init (a)
!! -------^
!! compilation aborted for intel-10.0-beta-bug01.f90 (code 1)
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

module collection_mod
  use typeA_mod
end module collection_mod

module typeAB_mod
  use collection_mod, only : typeA, init ! THIS LINE (UNNECESSARY IN THIS CONTEXT) CONFUSES THE COMPILER
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
