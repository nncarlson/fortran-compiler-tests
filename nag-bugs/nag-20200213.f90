!! SR104916
!!
!! FINALIZATION OCCURS IN THE WRONG ORDER
!!
!! Section 7.5.6.2 (2018) indicates that finalization of an object occurs
!! in the following order. First, user-defined final subroutines are invoked
!! with the object. Second, finalizable non-inherited components are
!! finalized. Third, the object parent type, if any, is finalized.
!!
!! In the following example the NAG compiler (6.0, 6.1, 6.2, 7.0) finalizes
!! the parent before finalizing the component defined in the child. A key
!! ingredient in the error appears to be that the component be an allocatable
!! polymorphic. Here's the output of the example:
!!
!! $ nagfor nag-20200213.f90
!! NAG Fortran Compiler Release 7.0(Yurakucho) Build 7008
!! $ ./a.out
!!  IN FINALIZE_CHILD
!!  IN FINALIZE_PARENT
!!  IN FINALIZE_OBJECTA

module objects

  implicit none
  private

  type, abstract, public :: object
  end type

  type, extends(object), public :: objectA
    real, pointer :: data(:) => null()
  contains
    procedure :: init
    final :: finalize_objectA
  end type

contains

  subroutine finalize_objectA(this)
    type(objectA), intent(inout) :: this
    !print *, 'IN FINALIZE_OBJECTA'
    write(*,'("O")',advance='no')
  end subroutine

  subroutine init(this)
    class(objectA), intent(inout) :: this
    allocate(this%data(10))
  end subroutine

end module

module child_type

  use objects
  implicit none
  private

  type :: parent
  contains
    final :: finalize_parent
  end type

  type, extends(parent), public :: child
    class(object), allocatable :: child_component
  contains
    procedure :: init
    final :: finalize_child
  end type

contains

  subroutine finalize_parent(this)
    type(parent), intent(inout) :: this
    !print *, 'IN FINALIZE_PARENT'
    write(*,'("P")',advance='no')
  end subroutine

  subroutine finalize_child(this)
    type(child), intent(inout) :: this
    !print *, 'IN FINALIZE_CHILD'
    write(*,'("C")',advance='no')
  end subroutine

  subroutine init(this)
    class(child), intent(inout) :: this
    allocate(objectA :: this%child_component)
    select type (cc => this%child_component)
    type is (objectA)
      allocate(cc%data(10))
    end select
  end subroutine

end module

program main
  use child_type
  call run
contains
  subroutine run
    type(child) :: c
    call c%init
  end subroutine
end program

