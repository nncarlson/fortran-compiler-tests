!!
!! INCORRECT RESULT
!!
!! This is a regression in 2025.2:
!!
!! $ ifx intel-20250709.f90 
!! $ ./a.out
!!  passing string "foo" to set
!!  set received string ""
!! ERROR!
!!
!! A workaround in the main program is to first assign S to a local
!! allocatable character variable and pass it to SET instead.

module m1
  character(:), pointer, private :: string => null()
contains
  function get()
    class(*), pointer :: get
    if (.not.associated(string)) allocate(string, source='foo')
    get => string
  end function
  subroutine set(arg)
    class(*), intent(in) :: arg
    select type (arg)
    type is (character(*))
      print *, 'set received string "', arg, '"'
      if (arg /= 'foo') stop 1
    end select
  end subroutine
end module

use m1
character(:), allocatable :: ss
select type (s => get())
type is (character(*))
  print *, 'passing string "', s, '" to set'
  call set(s)
end select
end
