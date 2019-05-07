!!
!! WRONG RESULT FROM SOURCED ALLOCATION
!!
!! The following example yields the incorrect result and exits abnormally
!! at the 'STOP 2' statement. This is with NAG 6.2 (6228) and 6.1 (6149)
!!

module foo_mod

  type, public :: any_scalar
    class(*), allocatable :: value
  end type

  interface any_scalar
    procedure any_scalar_value
  end interface

  type, public :: foo
    class(*), allocatable :: x
  contains
    procedure :: set
  end type

contains

  !! User-defined constructor.
  function any_scalar_value(value) result(obj)
    class(*), intent(in) :: value
    type(any_scalar) :: obj
    allocate(obj%value, source=value)
  end function any_scalar_value

  subroutine set(this, value)
    class(foo), intent(inout) :: this
    class(*), intent(in) :: value
    allocate(this%x, source=any_scalar(value)) ! <== VALUES NOT BEING ASSIGNED CORRECTLY
    select type (x => this%x)
    type is (any_scalar)
      call check(x)
    class default
      stop 1
    end select
  end subroutine
  
  subroutine check(x)
    type(any_scalar), intent(in) :: x
    select type (v => x%value)
    type is (character(*))
      if (v /= 'bizbat') stop 2 ! <== EXISTS HERE WITH INCORRECT VALUE
    class default
      stop 3
    end select
  end subroutine

end module


use foo_mod
type(foo) :: p
call p%set('bizbat')
end
