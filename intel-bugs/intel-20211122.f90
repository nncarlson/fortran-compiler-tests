!! REJECTS VALID STRUCTURE CONSTRUCTOR
!!
!! This bug effects Intel Fortran 19.1 and earlier, but has already
!! been fixed in the oneAPI 2021.1 compiler and later.
!!
!! The compiler rejects the valid path_event(tp) structure constructor
!! expression. Essential aspects required to trigger the bug are that
!! path_event be an extended type and that the toolpath type have 2 or
!! more components. A workaround is to define an explicit constructor
!! function that does what the implicit constructor should do.
!!
!! $ ifort --version
!! ifort (IFORT) 19.1.0.166 20191121
!!
!! $ ifort -c intel-20211122.f90 
!! intel-20211122.f90(43): error #6593: The number of expressions in a structure constructor differs from the number of components of the derived type.   [PATH_EVENT]
!!     call add_event(path_event(tp))
!! -------------------^
!! compilation aborted for intel-20211122.f90 (code 1)
!!

module toolpath_table


  type, abstract :: event_action
  end type

  type, extends(event_action) :: path_event
    type(toolpath), pointer :: tp
  end type

  type :: toolpath
    real :: a, b
  end type

contains

  subroutine add_toolpath_events

    class(*), pointer :: uptr
    type(toolpath), target :: tp

    call add_event(path_event(tp))

  end subroutine

  subroutine add_event(action)
    class(event_action), intent(in) :: action
  end subroutine

end module
