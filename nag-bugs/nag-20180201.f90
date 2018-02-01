!!
!! INVALID INTERMEDIATE C CODE (FINALIZATION)
!!
!! The NAG 6.1 compiler generates invalid intermediate C code for the
!! following example.
!!
!! Same for the 6.2 (6105) compiler.
!!
!! $ nagfor nag-20180201.f90 
!! NAG Fortran Compiler Release 6.1(Tozai) Build 6144
!! Warning: nag-20180201.f90, line 24: Unused dummy variable THIS
!! [NAG Fortran Compiler normal termination, 1 warning]
!! nag-20180201.f90: In function 'main':
!! nag-20180201.f90:30:11: error: 'x_' is a pointer; did you mean to use '->'?
!!  deallocate(x)
!!            ^
!!            ->

module outer_type
  type :: inner
    !integer, pointer :: foo => null()
  contains
    final :: delete
  end type
  type :: middle
    type(inner) :: scalar
  end type
  type :: outer
    type(middle) :: array(3)
  end type
contains
  subroutine delete(this)
    type(inner), intent(inout) :: this
    !if (associated(this%foo)) deallocate(this%foo)
  end subroutine
end module

use outer_type
type(outer), allocatable :: x
allocate(x)
deallocate(x)
end
