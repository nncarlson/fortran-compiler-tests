!! The following example gives a spurious run time error at the sourced
!! allocation statement when compiled with 17.0.6 (18.0.1 is okay):
!!
!! forrtl: severe (190): for allocate(source=), source needs to be allocated
!! Image              PC                Routine            Line     Source             
!! a.out              000000000040464E  Unknown            Unknown  Unknown
!! a.out              0000000000402B91  MAIN__                  12  bug.f90
!!
!! The dummy argument X is associated with the value of the constructor
!! expression EXTENDED().  There is no question here of X being allocated
!! or not -- it is not allocatable.
!!
!! The error is specific to the case of polymorphic variables when the
!! types contain no components.  The error goes away if a dummy component
!! is added to either the base class or the extended type.

type, abstract :: base
end type

type, extends(base) :: extended
  !integer :: dummy = 1
end type

call foo(extended())

contains
  subroutine foo(x)
    class(base), intent(in) :: x
    class(base), allocatable :: y
    allocate(y, source=x)   ! RUN TIME ERROR HERE
  end subroutine
end
