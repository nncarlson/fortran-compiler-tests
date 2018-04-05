!! SR99982. Fixed in 6.2 build 6208; 6.1 build 6148.
!!
!! FINALIZATION SEGMENTATION FAULT
!!
!! The following example should run to completion, but a segmentation
!! fault occurs during the automatic finalization of a LIST_ITEM pointer
!! target prior to the deallocation of the pointer.  I'm getting the
!! error with 6.2, 6.1, and 6.0.
!!
!! Expected output (from Intel 17):
!!  calling finalize_arg_on_entry ...
!!  entered action_list_delete
!!  is %first associated? T
!!  is this%first%action allocated? T
!!  deallocating this%first (finalization happens) ...
!!    done
!!  in finalize_arg_on_entry
!!
!! Output from NAG:
!!  calling finalize_arg_on_entry ...
!!  entered action_list_delete
!!  is %first associated? T
!!  is this%first%action allocated? T
!!  deallocating this%first (finalization happens) ...
!! Segmentation fault (core dumped)

module example

  type, abstract :: base
  end type
  
  type, extends(base) :: extended
  end type

  type :: list
    type(list_item), pointer :: first => null()
  contains
    final :: list_delete
  end type

  type :: list_item
    class(base), allocatable :: action
  end type
  
contains

  subroutine list_delete(this)
    type(list), intent(inout) :: this
    print *, 'entered action_list_delete'
    print *, 'is %first associated?', associated(this%first)
    if (associated(this%first)) then
      print *, 'is this%first%action allocated?', allocated(this%first%action)
      print *, 'deallocating this%first (finalization happens) ...'
      deallocate(this%first)  ! <== SEGFAULT HERE
      print *, '  done' ! NEVER MAKES IT HERE
    end if
  end subroutine

  subroutine finalize_arg_on_entry(arg)
    type(list), allocatable, intent(out) :: arg
    print *, 'in finalize_arg_on_entry' ! NEVER MAKES IT HERE
  end subroutine

end module

program main

  use example
  type(list), allocatable :: arg
  
  allocate(arg)
  allocate(arg%first)
  allocate(extended :: arg%first%action)
  
  print *, 'calling finalize_arg_on_entry ...'
  call finalize_arg_on_entry(arg)

end program
  
