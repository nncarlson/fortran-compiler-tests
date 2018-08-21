!! SR101836 -- Fixed in build 6218
!!
!! SEGFAULT EXECUTING RETURN FROM PROCEDURE
!!
!! The following example gives a segfault while executing the return from
!! store_value. The procedure moves an allocation from one variable to
!! another and seemingly executes as expected. There is no reason why a
!! segfault should occur during the return. Note that there is some
!! extraneous unexecuted code, but the segfault disappears if it is
!! eliminated, or if the example is otherwise simplified.
!!
!! The error occurs with 6.2 build 6212 and 6216, but not 6210; nor does it
!! occur with 6.1. The system is running Fedora 25 on x86_64 with gcc 6.4.1
!!
!! $ nagfor bug.f90
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6216
!! Questionable: bug.f90, line 60: Variable STAT set but never referenced
!! [NAG Fortran Compiler normal termination, 1 warning]
!!
!! $ ./a.out
!!  at call to move_alloc: T F
!!  at end of store_value: F T
!! Segmentation fault (core dumped)

module json

  type, abstract :: json_value
  end type
  type, extends(json_value) :: json_integer
    integer :: value
  end type

  type, abstract :: json_struct
  end type
  type, extends(json_struct) :: json_object
  end type

  type :: json_builder
    class(json_value), allocatable :: result
  end type

contains

  integer function store_value(this, jval) result(status)
    class(json_builder), intent(inout) :: this
    class(json_value), allocatable, intent(inout) :: jval
    class(json_struct), allocatable :: struct
    if (allocated(struct)) then ! THIS STANZA NOT EXECUTED
      select type (struct)
      type is (json_object)
      end select
    else
      print *, 'at call to move_alloc:', allocated(jval), allocated(this%result)
      call move_alloc(jval, this%result)
    end if
    status = 0
    print *, 'at end of store_value:', allocated(jval), allocated(this%result)
  end function

end module json

program example
  use json
  implicit none

  type(json_builder) :: builder
  class(json_value), allocatable :: jval
  integer :: stat

  jval = json_integer(42)
  stat = store_value(builder, jval)
  print *, 'after return from store_value'
end program
