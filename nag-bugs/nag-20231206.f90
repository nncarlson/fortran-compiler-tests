!!
!! FINAL SUBROUTINE INVOKED INAPPROPRIATELY
!!
!! This example defines a base class and extension with a defined assignment
!! operator (using the non-virtual interface (NVI) idiom), and the extension
!! has a final subroutine. The main program defines a base class variables
!! rhs and lhs of the extended type and does the assignment "lhs = rhs".
!! For some reason the NAG compiler invokes the final subroutine on the rhs
!! variable which is incorrect.
!!
!! $ nagfor nag-20231206.f90
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7141
!!
!! $ ./a.out
!!  in foo_copy
!!  in foo_bar_copy
!! ERROR STOP: in final subroutine for object named rhs
!!
!! Then expected output is
!!
!!  in foo_copy
!!  in foo_bar_copy
!!  assignment complete

module foo_class

  implicit none
  private

  type, abstract, public :: foo
  contains
    procedure, private :: foo_copy
    generic :: assignment(=) => foo_copy
    procedure(foo_copy), deferred :: copy_impl
  end type

  type, extends(foo), public :: foo_bar
    character(:), allocatable :: name
    !type(list_item), pointer :: first => null()
  contains
    procedure :: copy_impl => foo_bar_copy
    final :: foo_bar_final
  end type

contains

  recursive subroutine foo_copy(lhs, rhs)
    class(foo), intent(inout) :: lhs
    class(foo), intent(in) :: rhs
    print *, 'in foo_copy'
    if (same_type_as(lhs, rhs)) then
      call lhs%copy_impl(rhs)
    else
      error stop
    end if
  end subroutine

  subroutine foo_bar_copy(lhs, rhs)
    class(foo_bar), intent(inout) :: lhs
    class(foo), intent(in) :: rhs
    print *, 'in foo_bar_copy'
    select type (rhs)
    type is (foo_bar)
      lhs%name = rhs%name
      !lhs%first => ...
    end select
  end subroutine

  subroutine foo_bar_final(this)
    type(foo_bar), intent(inout) :: this
    error stop 'in final subroutine for object named ' // this%name
  end subroutine

end module

use foo_class
class(foo), allocatable :: rhs, lhs
allocate(rhs, source=foo_bar('rhs'))
allocate(lhs, mold=rhs)
lhs = rhs ! DEFINED ASSIGNMENT INVOKED HERE
print *, 'assignment complete'
end
