!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=119994
!!
!! VALID CODE REJECTED
!!
!! $ gfortran -c gfortran-20250401.f90
!! gfortran-20250401.f90:35:21:
!! 
!!    35 |       real :: array2(this%n)
!!       |                     1
!! Error: Dummy argument ‘this’ at (1) cannot be INTENT(OUT)
!! gfortran-20250401.f90:30:21:
!! 
!!    30 |       real :: array1(this%n)
!!       |                     1
!! Error: Dummy argument ‘this’ at (1) cannot be INTENT(OUT)
!!
!! In both cases, THIS%N is an object designator with a base object (THIS)
!! that is made accessible by host association (2018: 10.1.11 par 2, item 4)
!! and is thus a restricted expression and a valid specification expression.
!! 

module foo

  type :: bar
    integer :: n
  end type

contains

  subroutine init(this, n)
    type(bar), intent(out) :: this
    integer, intent(in) :: n
    this%n = n
    block
      real :: array1(this%n)
    end block
    call sub
  contains
    subroutine sub
      real :: array2(this%n)
    end subroutine
  end subroutine

end module
