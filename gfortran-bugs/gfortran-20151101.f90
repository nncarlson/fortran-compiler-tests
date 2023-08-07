!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68174
!! marked as duplicate of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68108 (fixed)
!! Fixed in 12.2.0 and probably much earlier.
!!
!! % gfortran --version
!! GNU Fortran (GCC) 6.0.0 20151025 (experimental)
!! 
!! % gfortran -c gfortran-bug-20151101A.f90 
!! gfortran-bug-20151101A.f90:15:25:
!! 
!!        allocate(character(this%maxlen) :: this%mold)
!!                          1
!! Error: Scalar INTEGER expression expected at (1)

module example

  type :: foo
    class(*), allocatable :: mold
    integer :: maxlen
  end type

contains

  subroutine pop (this)
    class(foo), intent(inout) :: this
    select type (uptr => this%mold)
    type is (character(*))
      deallocate(this%mold)
      allocate(character(this%maxlen) :: this%mold)
    end select
  end subroutine

end module
