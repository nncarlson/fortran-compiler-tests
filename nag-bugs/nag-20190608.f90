!! SR103620: Fixed in 6233
!!
!! INTERNAL COMPILER ERROR
!!
!! This is a regression somewhere between 6228 (okay) to 6232 (ICE)
!!
!! $ nagfor -c nag-20190608.f90
!! NAG Fortran Compiler Release 6.2(Chiyoda) Build 6232
!! Panic: nag-20190608.f90: Unexpected expr node type 432
!! Internal Error -- please report this bug
!! Abort
!!

module foo

  type :: ptr_box
    real, pointer :: ptr(:) => null()
  end type

  type :: struct
    type(ptr_box), allocatable :: array(:)
  end type

contains

  subroutine bar(x, y)
    type(struct) :: x, y
    x%array(1)%ptr = y%array(1)%ptr
  end subroutine

end module
