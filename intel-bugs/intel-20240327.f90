!! CMPLRLLVM-57245
!!
!! INTERNAL COMPILER ERROR
!!
!! Example involves F2018 assumed-type and assumed-rank character dummy argument.
!!
!! $ ifx --version
!! ifx (IFX) 2024.0.2 20231213
!! $ ifx -c intel-20240327.f90 
!!          [...]
!! intel-20240327.f90(31): error #5623: **Internal compiler error: internal abort** Please report this error along with the circumstances in which it occurred in a Software Problem Report.  Note: File and line given may not be explicit cause of this error.
!!       call c_void_func([a])
!! ------------------------^
!! compilation aborted for intel-20240327.f90 (code 3)
!!
!! Also fails with ifort from 2024.0.2 with this error message which doesn't
!! seem to be a normal error from invalid code:
!!
!! intel-20240327.f90(31): error #5529: CHARACTER variable 'A' has no length argument in routines with C or STDCALL attribute
!!      call c_void_func([a])

module foo
  interface
    subroutine c_void_func(b) bind(c)
      type(*), intent(in) :: b(*)
    end subroutine
  end interface
contains
  subroutine bar(a)
    character(*), intent(in) :: a(..)
    select rank (a)
    rank (0)
      call c_void_func([a])
    end select
  end subroutine
end module
