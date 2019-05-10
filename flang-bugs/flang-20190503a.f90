!! https://github.com/flang-compiler/flang/issues/244
!!
!! This is a vector-valued version of flang-20170924c.f90
!!
!! The following example should terminate normally, but instead
!! exits at the STOP 3 statement.
!!
!! $ flang flang-bug-20190503a.f90
!! $ ./a.out
!!   3

module any_vector_type

  type :: any_vector
    class(*), allocatable :: value(:)
  end type

  interface any_vector
    procedure any_vector_value
  end interface

contains

  function any_vector_value(value) result(obj)
    class(*), intent(in) :: value(:)
    type(any_vector) :: obj
    allocate(obj%value, source=value)
  end function

end module

program main
  use any_vector_type
  type(any_vector) :: x
  x = any_vector([1,2])
  if (.not.allocated(x%value)) stop 1
  select type (v => x%value)
  type is (integer)
    if (any(v /= [1,2])) stop 2
  class default
    stop 3
  end select
end program
