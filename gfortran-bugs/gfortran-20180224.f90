!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84546
!! Fixed in 8.0 r258438 (3/11/2018)
!!
!! BAD SOURCED ALLOCATION -- 7/8 REGRESSION
!!
!! This example has a similar theme to several past bugs: character arrays,
!! CLASS(*) allocatable variables, character length parameters not being
!! propagated correctly.  The correct output is "foobar", but the current
!! 7/8 trunks produce "foob".  Version 6.4.1 works properly.
!!

module any_vector_type

  type :: any_vector
    class(*), allocatable :: vec(:)
  end type

  interface any_vector
    procedure any_vector1
  end interface

contains

  function any_vector1(vec) result(this)
    class(*), intent(in) :: vec(:)
    type(any_vector) :: this
    allocate(this%vec, source=vec)
  end function

end module

program main

  use any_vector_type
  implicit none

  class(*), allocatable :: x
  character(*), parameter :: vec(*) = ['foo','bar']

  allocate(x, source=any_vector(vec))

  select type (x)
  type is (any_vector)
    select type (xvec => x%vec)
    type is (character(*))
      print *, xvec ! EXPECT "foobar"
      if (any(xvec /= vec)) stop 1
    end select
  end select

end program
