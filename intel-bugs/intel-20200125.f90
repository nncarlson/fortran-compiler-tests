!! SRN 04502674
!!
!! WRONG RESULT FROM POLYMORPHIC POINTER ASSIGNMENT
!!
!! This example shows that the polymorphic pointer assignment
!! is being done incorrectly, giving either wrong results or
!! a segfault. This occurs for version 19.1 and is a regression
!! from 18 and 19.0.
!!
!! $ ifort --version
!! ifort (IFORT) 19.1.0.166 20191121
!! $ ifort -g -traceback intel-20200125.f90 
!! $ ./a.out
!!  loop
!! forrtl: severe (174): SIGSEGV, segmentation fault occurred
!! Image              PC                Routine            Line        Source             
!! a.out              0000000000404BFA  Unknown               Unknown  Unknown
!! libpthread-2.28.s  00007FA0760F3E70  Unknown               Unknown  Unknown
!! a.out              0000000000403A01  mod_mp_next_               27  intel-20200125.f90
!! a.out              0000000000403D5D  MAIN__                     44  intel-20200125.f90
!! a.out              00000000004037E2  Unknown               Unknown  Unknown
!! libc-2.28.so       00007FA075F39413  __libc_start_main     Unknown  Unknown
!! a.out              00000000004036EE  Unknown               Unknown  Unknown

module mod

  type :: list_item
    type(list_item), pointer :: next => null()
  end type

  type :: iterator
    class(list_item), pointer :: item => null()
  contains
    procedure :: next
  end type

contains

  subroutine next(this)
    class(iterator), intent(inout) :: this
    logical :: flag
    if(associated(this%item)) flag = associated(this%item%next)
    if(associated(this%item)) this%item => this%item%next ! SEGFAULT HERE OR WRONG RESULT
    if (associated(this%item) .neqv. flag) stop 1  ! THESE SHOULD BE THE SAME
  end subroutine

end module

use mod
type(iterator) :: iter
type(list_item), pointer :: head

! One item in the list ==> segfault
! Two items in the list ==> premature exit from loop
allocate(head)
!allocate(head%next) ! add a second item
iter%item => head
do while (associated(iter%item))
  print *, 'loop'
  call iter%next
end do
end

