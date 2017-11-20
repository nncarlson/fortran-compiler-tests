!! fixed in 5.3.2 (983)
!!
!! COMPILER PANIC
!!
!! The NAG compiler version 5.3.2(981) panics on the following code.
!!
!! % nagfor -c HTSD_model_type.f90 
!! NAG Fortran Compiler Release 5.3.2(981)
!! Panic: HTSD_model_type.f90: mkarraydesc unexpected node type 467
!! Internal Error -- please report this bug
!!

module T1_mod
  type :: T1
    integer, pointer :: foo => null()
  contains
    final :: T1_delete
  end type
contains
  subroutine T1_delete (this)
    type(T1) :: this
    print *, 'T1_delete'
  end subroutine
end module

module T2_mod
  use T1_mod
  type :: T2
    type(T1) :: x
  end type
end module

module T3_mod
  use T2_mod
  type :: T3
    type(T2), pointer :: array(:) => null()
  end type
contains
  subroutine delete (this)
    type(T3) :: this
    deallocate(this%array)
  end subroutine
end module

program main
  use T3_mod
  use T2_mod
  type(T3) :: x
  type(T3), allocatable :: y
  type(T2), pointer :: a(:)
  ! Try 1
  allocate(x%array(5))
  call delete (x)
  ! Try 2
  allocate(y)
  allocate(y%array(5))
  call delete (y)
  ! Try 3
  allocate(a(5))
  x%array => a
  call delete (x)
end program
