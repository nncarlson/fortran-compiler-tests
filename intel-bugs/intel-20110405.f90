!!
!! SYNOPSIS: Specific procedure for generic lost through nested modules
!!
!! The 2011.0.3 compiler (EM64T) incorrectly complains that there is no
!! specific subroutine for the generic subroutine call when in fact it
!! is has been exported from MOD1 and through MOD2 into the program.
!! Although the code looks odd (it is distilled from real code) it is
!! standard conforming.
!!
!! The code compiles without error if any *one* of the following changes are made:
!! (1) the private statement is removed from MOD1;
!! (2) no rename of generic_foo is made in MOD2, and generic_foo used throughout;
!! (3) the generic is not extended in MOD2;
!! (4) the use statement in MOD2 is replaced with
!!     use mod1, only: new_name => generic_foo
!!
!! % ifort --version
!! ifort (IFORT) 12.1.2 20111128
!! 
!! % ifort intel-bug-20110405.f90 
!! intel-bug-20110405.f90(54): error #6285: There is no matching specific subroutine for this generic subroutine call.   [NEW_NAME]
!!   call new_name (1)
!! -------^
!! compilation aborted for intel-bug-20110405.f90 (code 1)
!!

module mod1
  private
  public :: generic_foo
  interface generic_foo
     module procedure one_arg_foo
  end interface
contains
  subroutine one_arg_foo (a)
    integer:: a
  end subroutine
end module

module mod2
  use mod1, new_name => generic_foo
  private
  public :: new_name
  interface new_name
    module procedure two_arg_foo
  end interface
contains
  subroutine two_arg_foo (a, b)
    integer :: a, b
  end subroutine
end module

program main
  use mod2
  call new_name (1)
end program

