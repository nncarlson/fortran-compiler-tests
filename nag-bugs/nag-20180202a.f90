!! SR99908
!!
!! INTERNAL COMPILER ERROR
!!
!! The NAG 6.2 compiler, but not 6.1, gives an internal error
!! for the following example.
!!
!! The ICE goes away if CLASS is replaced by TYPE.
!!
!! $ nagfor nag-20180202a.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6205
!! Panic: nag-20180202a.f90: Unexpected DEREF in expr
!! Internal Error -- please report this bug
!! Abort

program main
  type foo
    integer :: n = 1
  end type
  type(foo), allocatable :: array(:)
  allocate(array, source=foo_array())
  if (size(array) /= 2) stop 1
  if (any(array%n /= [1,1])) stop 2
contains
  function foo_array()
    class(foo), allocatable :: foo_array(:)
    allocate(foo_array(2))
  end function
end
