!!
!! % ifort --version
!! ifort (IFORT) 13.0.0 20120731
!! Copyright (C) 1985-2012 Intel Corporation.  All rights reserved.
!! 
!! % ifort intel-bug-20121001.f90 
!! % ./a.out
!!  WRONG: foo and object_mesh(obj) are not associated
!!  CORRECT: foo and bar are associated
!!

module types
  type :: object
    private
    type(mesh), pointer :: m => null()
  end type
  type :: mesh
    integer :: some_data
  end type
contains
  subroutine object_init (this, m)
    type(object), intent(out) :: this
    type(mesh), pointer :: m
    this%m => m
  end subroutine
  function object_mesh (this) result (m)
    type(object), intent(in) :: this
    type(mesh), pointer :: m
    m => this%m
  end function
end module types

program main

  use types
  
  type(object) :: obj
  type(mesh), pointer :: foo, bar
  
  allocate(foo)
  call object_init (obj, foo)
  
  !! THIS GIVES THE WRONG RESULT
  if (associated(foo, object_mesh(obj))) then
    print *, 'CORRECT: foo and object_mesh(obj) are associated'
  else
    print *, 'WRONG: foo and object_mesh(obj) are not associated'
    stop 1
  end if
  
  !! BUT THIS GIVES THE CORRECT RESULT
  bar => object_mesh(obj)
  if (associated(foo, bar)) then
    print *, 'CORRECT: foo and bar are associated'
  else
    print *, 'WRONG: foo and bar are not associated'
    stop 2
  end if

  !! NOTE THAT IF THE TYPE(MESH) POINTER COMPONENT IS REPLACED WITH
  !! A POINTER TO AN INTRISIC TYPE (LIKE INTEGER) THE CORRECT
  !! ANSWER IS OBTAINED IN BOTH CASES.
  
end program
