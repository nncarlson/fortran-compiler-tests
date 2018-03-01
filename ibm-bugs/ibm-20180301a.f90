!!
!! FUNCTION RESULT NOT RECOGNIZED TO HAVE BEEN SET
!!
!! The call to the intrinsic function C_F_POINTER sets the value of the
!! function result but the xlf compiler fails to recognize this and gives
!! a spurious compilation error
!!
!! This is from https://github.com/nncarlson/petaca/blob/master/src/yajl_fort.F90
!!
!! $ xlf -qversion
!! IBM XL Fortran for Linux, V15.1.6 (Community Edition)
!! Version: 15.01.0006.0001
!! 
!! $ xlf2008 -c bug.f90
!! "bug.f90", 1513-006 (E) FUNCTION or ENTRY result is not set in the program unit.
!! ** f_string_pointer_aux   === End of Compilation 1 ===
!! 1501-510  Compilation successful for file bug.f90.

function f_string_pointer_aux(cptr, len) result(fptr)
  use,intrinsic :: iso_c_binding
  type(c_ptr), intent(in) :: cptr
  integer(c_size_t), intent(in) :: len
  character(len,kind=c_char), pointer :: fptr
  call c_f_pointer(cptr, fptr)
end function
