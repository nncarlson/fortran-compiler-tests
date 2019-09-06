!! SR104042: Fixed for 6.2 in build 6238. Still present in 6.1
!!
!! INTERNAL COMPILER ERROR
!!
!! $ nagfor -c nag-20190826a.f90 
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6228
!! Panic: nag-20190826a.f90: allocate_atmp cannot handle arbitrary non-constant shapes
!! Internal Error -- please report this bug
!!

module example

  type :: foo(n)
    integer,len :: n
    integer :: array(0:n)
  end type
  type(foo(10)) :: x

contains

  subroutine sub(x)
    type(foo(*)), intent(in) :: x
    real, allocatable :: array(:)
    array = pack(x%array, mask=(x%array/=0))
  end subroutine

end module
