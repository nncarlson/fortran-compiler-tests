!!
!! The following program, as a single file, compiles without error and
!! prints the expected result.  But when the main program is moved to a
!! separate file (main.f90) the compiler reports an error:
!!
!! % nagfor nag-bug-20160129.f90 main.f90
!! NAG Fortran Compiler Release 6.0(Hibiya) Build 1067
!! nag-bug-20160129.f90:
!! [NAG Fortran Compiler normal termination]
!! main.f90:
!! Error: main.f90, line 6: Scalar actual for INTENT(INOUT) dummy THIS of elemental SUB_ELEM, but another argument is an array
!! [NAG Fortran Compiler error termination, 1 error]
!!

module a_type

  type :: a
    integer :: n
  contains
    procedure :: sub_elem
    procedure :: sub_array
    generic :: sub => sub_elem, sub_array
  end type

contains

  elemental subroutine sub_elem (this, arg)
    class(a), intent(inout) :: this
    integer, intent(in) :: arg
    this%n = arg
  end subroutine

  subroutine sub_array (this, arg)
    class(a), intent(inout) :: this
    integer, intent(in) :: arg(:)
    this%n = sum(arg)
  end subroutine

end module

!program main
!
!  use a_type
!  type(a) :: x, y(2)
!
!  call x%sub ([1,2])
!  call y%sub ([1,2])
!
!  print *, x%n, '(expect 3)'
!  print *, y%n, '(expect 1 2)'
!
!end program

