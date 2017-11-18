!! https://github.com/flang-compiler/flang/issues/255
!!
!! Execution segfaults at the indicated line.
!! If no final procedure for ITEM, there is no segfault.

module item_type

  type :: item
    class(*), allocatable :: value
  contains
    final :: item_delete  ! NO SEGFAULT IF COMMENTED OUT
  end type

contains

  function new_item(value)
    class(*), intent(in) :: value
    type(item), pointer :: new_item
    allocate(new_item)
    print *, 'before segfault'
    allocate(new_item%value, source=value)  ! SEGFAULT HERE
    print *, 'after segfault'
  end function
  
  subroutine item_delete(this)
    type(item), intent(inout) :: this
    print *, 'in final'
  end subroutine

end module

program main
  use item_type
  type(item), pointer :: foo
  foo => new_item(1)
end program
