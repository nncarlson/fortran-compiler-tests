!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89174
!!
!! REGRESSION -- ALLOCATION SEGFAULT WITH CLASS(*) MOLD
!!
!! Used to work with earlier 8.2.1 snapshots and probably 9.0 as well,
!! but fails now with both 8.2.1 and 9.0. Works fine with 7.3.1.
!!

module mod
  type :: array_data
    class(*), allocatable :: mold
  contains
    procedure :: push
  end type
contains
  subroutine push(this, value)
    class(array_data), intent(inout) :: this
    class(*), intent(in) :: value
    allocate(this%mold, mold=value) ! <== SEGFAULTS HERE
  end subroutine
end module

use mod
type(array_data) :: foo
call foo%push(42)
end
