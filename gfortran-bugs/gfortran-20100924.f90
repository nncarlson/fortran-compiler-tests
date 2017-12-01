!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=45786
!!
!! Compiler (version ?) incorrectly complains (essentially) that it has
!! no == operator for the operands when in fact it should -- it appears
!! that the defined .EQ. operator is not being treated as the same
!! as == in the module.  Error occurs for other equivalent pairs of
!! operators.  Here's the compiler error:
!!
!!  print *, a == b
!!           1
!! Error: Operands of comparison operator '==' at (1) are TYPE(foo)/TYPE(foo)

module foo_type
  private
  public :: foo, operator(==)
  type :: foo
    integer :: bar
  end type
  interface operator(.eq.)
    module procedure eq_foo
  end interface
contains
  logical function eq_foo (a, b)
    type(foo), intent(in) :: a, b
    eq_foo = (a%bar == b%bar)
  end function
end module

subroutine use_it (a, b)
  use foo_type
  type(foo) :: a, b
  print *, a == b
end subroutine

