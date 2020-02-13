!! Service Request Number: 04520865
!!
!! MISSING FINALIZATION OF POLYMORPHIC COMPONENT
!!
!! Section 7.5.6.2 (2018) indicates that finalization of an object occurs
!! in the following order. First, user-defined final subroutines are invoked
!! with the object. Second, finalizable non-inherited components are
!! finalized. Third, the object parent type, if any, is finalized.
!!
!! In the following example the Intel compiler (17.0, 18.0, 19.1) fails to
!! finalize the finalizable child component, resulting in a memory leak.
!! A key ingredient in the error appears to be that the component is an
!! allocatable polymorphic.
!!
!! $ ifort --version
!! ifort (IFORT) 19.1.0.166 20191121
!! $ ifort intel-20200213.f90
!! $ ./a.out
!!  IN FINALIZE_CHILD: CHILD_COMPONENT ALLOCATED? T
!!                        <=== SHOULD HAVE "IN FINALIZE_OBJECTA" HERE
!!  IN FINALIZE_PARENT

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
    write(*,'(a)',advance='no') 'O'
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
    write(*,'(a)',advance='no') 'P'
  end subroutine

  subroutine finalize_child(this)
    type(child), intent(inout) :: this
    !print *, 'IN FINALIZE_CHILD: CHILD_COMPONENT ALLOCATED?', allocated(this%child_component)
    write(*,'(a)',advance='no') 'C'
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

