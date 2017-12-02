!! The following example returns the INCORRECT results with version
!! 18.0.0 20170811 of the Intel compiler:
!!
!! $ ifort intel-bug-20171023.f90 
!! $ ./a.out
!!   1065353216 (expect 1)
!!
!! CORRECT results are obtained with versions 17.0.1 and 16.0.3, as well
!! as the gfortran and NAG compilers.

module any_scalar_type

  type any_scalar
    class(*), allocatable :: value
  end type

contains

  function value_ptr(this) result(uptr)
    class(any_scalar), target, intent(in) :: this
    class(*), pointer :: uptr
    uptr => this%value
  end function

end module


program main

  use any_scalar_type

  type(any_scalar), target :: foo
  class(*), allocatable :: scalar
  class(*), pointer :: uptr

  type point; real x, y; end type
  allocate(scalar, source=point(1.0,2.0))

  allocate(foo%value, source=1)
  uptr => value_ptr(foo)
  deallocate(scalar)
  allocate(scalar, source=uptr) ! should hold the value 1

  select type (scalar)
  type is (integer)
    if (scalar == 1) then
      print *, 'pass:', scalar, '(expect 1)'
    else
      print *, 'fail:', scalar, '(expect 1)'
    end if
  end select

end program
