!!
!! The following example passes a non-contiguous character substring
!! array to an assumed-size CHARACTER(LEN=1) array dummy. This should
!! result in a contiguous copy of the actual argument being passed to
!! the subroutine.  The xlf 15.1.6 compiler is not doing this.  The
!! Intel, NAG, and GFortran compilers all do the correct thing here.
!!
!! This is from https://github.com/nncarlson/petaca/blob/master/src/secure_hash/secure_hash_class.F90
!!
!! Expected result: foba
!! IBM result: foob
!!

program main
  implicit none
  character(3) :: string_array(2) = ['foo', 'bar']
  call sub1(string_array(:)(1:2))
contains
  subroutine sub1(data)
    character(*), intent(in) :: data(:)
    call sub2(data, len(data)*size(data))
  end subroutine
  subroutine sub2(data, len)
    character, intent(in) :: data(*) ! FORCES A
    integer, intent(in) :: len
    integer :: i
    print *, (data(i), i=1,len)
    if (any(data(:len) /= ['f','o','b','a'])) stop 1
  end subroutine
end 
