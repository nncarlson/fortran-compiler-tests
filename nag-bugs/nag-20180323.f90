!! SR100272. Fixed in 6.2 build 6210; 6.1 build 6149.
!!
!! INVALID INTERMEDIATE C CODE (FINALIZATION)
!!
!! The NAG 6.1 and 6.2 compilers generate invalid intermediate C code for the
!! following example.
!!
!! This is the same example and error as nag-20180201.f90 (SR99906, fixed in 6.1
!! and 6.2) except that the ultimate variable X is a pointer, not allocatable.
!!
!! $ nagfor nag-20180323.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6208
!! Warning: nag-20180323.f90, line 36: Unused dummy variable THIS
!! [NAG Fortran Compiler normal termination, 1 warning]
!! nag-20180323.f90: In function 'main':
!! nag-20180323.f90:41:11: error: 'x_' is a pointer; did you mean to use '->'?
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
type(outer), pointer :: x
type(outer), allocatable :: y
allocate(x)
allocate(y)
deallocate(x)
deallocate(y) ! the nag-20180201.f90 bug
end
