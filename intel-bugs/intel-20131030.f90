!Issue number DPD200249493
!!
!! COMPILER GENERATES INCORRECT CODE
!!
!! In the following example, a derived-type scalar pointer P is allocated and
!! then deallocated.  At that point, ASSOCIATED(P) should return FALSE but it
!! returns TRUE.  Key to the error seems to be that the pointer is a dummy
!! argument and that the derived type contains an allocatable CLASS(*) component.
!!
!! $ ifort --version
!! ifort (IFORT) 14.0.0 20130728
!!
!! $ ifort intel-bug-20131030.f90 
!! $ ./a.out
!!  associated(p) = T (should be FALSE)
!!

module foo_mod
  type, public :: foo
    class(*), allocatable :: value
  end type
contains
  subroutine sub (p)
    type(foo), pointer :: p
    allocate(p)
    deallocate(p)
    print *, 'associated(p) =', associated(p), '(should be FALSE)'
  end subroutine
end module

program main
  use foo_mod
  type(foo), pointer :: p
  call sub (p)
end program

