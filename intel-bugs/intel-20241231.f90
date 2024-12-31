!!
!! INCORRECT RESULT FROM MOVE_ALLOC
!!
!! $ ifx --version
!! ifx (IFX) 2025.0.0 20241008
!!
!! $ ifx intel-20241231.f90
!! $ ./a.out
!! 1 (should produce no output -- return status 0)
!!

type,abstract :: foo
end type
type, extends(foo) :: bar
end type
type(bar), allocatable :: x
class(foo), allocatable :: y
call move_alloc(x, y)
if (allocated(y)) stop 1 ! ERROR: Y SHOULD BE UNALLOCATED
end
