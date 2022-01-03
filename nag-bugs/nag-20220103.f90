!! COMPILER REJECTS VALID CODE
!!
!! In the following example the derived type FOO is imported into the parent
!! scope of the BLOCK construct, and is accessible from within the BLOCK
!! construct as it should be. However its defined constructor seems to not
!! be visible within the BLOCK construct because the compiler appears to be
!! falling back to the intrinsic constructor.
!!
!! This error occurs with version 7.1, but compiles fine with 7.0.
!!
!! nagfor -w=all nag-20220103.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7101
!! Error: nag-20220103.f90, line 46: Constructor for type FOO has value for PRIVATE component PRIVATE_VAR
!! [NAG Fortran Compiler error termination, 1 error]
!!

module foo_type

  implicit none
  private

  type, public :: foo
    private
    integer :: private_var
  end type
  
  ! Defined constructor
  interface foo
    procedure my_foo_constructor
  end interface

contains

  function my_foo_constructor(m) result(f)
    integer, intent(in) :: m
    type(foo) :: f
    f%private_var = m
  end function

end module

program example
  use foo_type
  block ! foo's defined constructor not visible in this block
    type(foo) :: f
    f = foo(42)
  end block
end

