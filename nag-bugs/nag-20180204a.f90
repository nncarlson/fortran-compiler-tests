!!
!! PASS NOT WORKING FOR PROCEDURE POINTER COMPONENTS
!!
!! The matching of actual arguments to dummy arguments is not working
!! correctly when the passed-object is preceded by optional arguments
!! that are omitted.  12.5.2.1 says that the actual arguments should
!! be matched to the reduced dummy argument list, and "The reduced dummy
!! argument list is either the full dummy argument list or, if there is
!! a passed-object dummy argument, the dummy argument list with the
!! passed-object dummy argument omitted.
!!
!! $ nagfor nag-20180204a.f90 
!! NAG Fortran Compiler Release 6.1(Tozai) Build 6144
!! Warning: nag-20180204a.f90, line 26: Unused dummy variable B
!! Error: nag-20180204a.f90, line 32: Incorrect data type FOO (expected
!! INTEGER) for argument A (no. 1) of X%BAR

module mod
  type foo
    procedure(bar), pointer, pass(b) :: bar
  end type
contains
  subroutine bar(a, b)
    integer, intent(in), optional :: a
    class(foo), intent(in) :: b
    print *, present(a)
  end subroutine
end module

use mod
type(foo) :: x
x%bar => bar
call x%bar()
end
