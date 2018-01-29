!! PR 84093
!!
!! A compiler should return an error for this invalid code,
!! However gfortran does not.
!!

type parent
  integer :: a, b
end type

type, extends(parent) :: child
  real :: x
end type

type(child) :: foo

foo = child(parent(1,2),3.0)  ! INVALID -- SEE NOTE 4.59 (F08 or F15)
foo = child(parent=parent(1,2), x=3.0)  ! THIS IS CORRECT

end
