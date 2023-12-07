!! SR110428
!!
!! INTERNAL COMPILER ERROR
!!
!! $ nagfor -c nag-20231204.f90
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7141
!! Panic: nag-20231204.f90: not pp?
!! Internal Error -- please report this bug
!! Abort

module parameter_entry_class

  type, abstract :: parameter_entry
  contains
    procedure :: copy
    generic :: assignment(=) => copy
    procedure(copy), deferred :: copy_
  end type

  type, extends(parameter_entry) :: any_scalar
    class(*), allocatable :: value
  contains
    procedure :: copy_ => any_scalar_copy
  end type

contains

  subroutine copy(lhs, rhs)
    class(parameter_entry), intent(inout) :: lhs
    class(parameter_entry), intent(in) :: rhs
    if (same_type_as(lhs, rhs)) then
      call lhs%copy_(rhs)
    else
      error stop
    end if
  end subroutine

  subroutine any_scalar_copy(lhs, rhs)
    class(any_scalar), intent(inout) :: lhs
    class(parameter_entry), intent(in) :: rhs
    select type (rhs)
    type is (any_scalar)
      lhs%value = rhs%value
    end select
  end subroutine

end module
