!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52864
!!
!! SYNOPSIS: Application of argument intent to the target of a pointer component
!!
!! The 4.7 gfortran compiler incorrectly interprets argument intent as
!! applying to the target of a argument pointer component, when it only
!! applies to the pointer itself; that is, its association status.
!!
!! % gfortran --version
!! GNU Fortran (GCC) 4.7.0
!!
!! % gfortran gfortran-bug-20120411.f90 
!! gfortran-bug-20120411.f90:26.14:
!! 
!!     call bar (a%ptr)
!!               1
!! Error: Procedure argument at (1) is INTENT(IN) while interface specifies INTENT(INOUT)
!!

module modA
  type :: typeA
    integer, pointer :: ptr
  end type
contains
  subroutine foo (a)
    type(typeA), intent(in) :: a
    call bar (a%ptr)
  end subroutine
  subroutine bar (n)
    integer, intent(inout) :: n
  end subroutine
end module
