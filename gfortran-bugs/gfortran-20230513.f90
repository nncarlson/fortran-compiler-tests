!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=109846
!!
!! REJECTS VALID CODE
!!
!! The following example is rejected by gfortran (13.1 and 12.2, and likely
!! earlier).
!!
!! $ gfortran gfortran-20230513.f90
!! gfortran-20230513.f90:17:11:

!!    17 |   call sub(plist%sublist())
!!       |           1
!! Error: 'sublist' in variable definition context (actual argument to
!! INTENT = OUT/INOUT) at (1) is not a variable
!!
!! The source of the error appears to be sublist returning a polymorphic
!! pointer. If it is modified to return a non-polymorphic pointer it
!! compiles without error. Alternatively, if the dummy argument is changed
!! to intent(in), it also compiles without error.
!!
!! See Sec 9.2, C902 (2018) and 6.2 C602 (2008)
!!

module foo
  type :: parameter_list
  contains
    procedure :: sublist
  end type
contains
  function sublist(this) result(slist)
    class(parameter_list), intent(inout) :: this
    class(parameter_list), pointer :: slist
    allocate(slist)
  end function
end module

program example
  use foo
  type(parameter_list) :: plist
  call sub(plist%sublist())
contains
  subroutine sub(plist)
    type(parameter_list), intent(inout) :: plist
  end subroutine
end program
