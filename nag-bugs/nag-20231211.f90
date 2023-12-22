!! SR110461. Fixed in 7142.
!!
!! INTERNAL COMPILER ERROR
!!
!! $ nagfor nag-20231211.f90 
!! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7141
!! Panic: nag-20231211.f90: Not a Uindex
!! Internal Error -- please report this bug

module mod
  type :: any_vector
    class(*), allocatable :: value(:)
  contains
    procedure :: value_ptr
  end type
contains
  function value_ptr(this)
    class(any_vector), intent(in), target :: this
    class(*), pointer :: value_ptr(:)
    value_ptr => this%value
  end function
end module

use mod
type(any_vector), pointer :: a
class(*), allocatable :: y(:)
allocate(a)
allocate(a%value, source=[1,2])
y = a%value_ptr()
end
