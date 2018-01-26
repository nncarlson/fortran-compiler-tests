! https://github.com/flang-compiler/flang/issues/96
! Fixed as of 9/22/2017

subroutine get_buffer(cptr, buflen, buffer)
  use,intrinsic :: iso_c_binding, only: c_char, c_size_t, c_ptr, c_f_pointer
  type(c_ptr), intent(in) :: cptr
  integer(c_size_t), intent(in) :: buflen
  character(:,kind=c_char), pointer, intent(out) :: buffer
  buffer => f_string_pointer(cptr, buflen)
contains
  function f_string_pointer(cptr, len) result(fptr)
    type(c_ptr), intent(in) :: cptr
    integer(c_size_t), intent(in) :: len
    character(len,kind=c_char), pointer :: fptr
    call c_f_pointer(cptr, fptr)
  end function
end subroutine get_buffer


