!!
!! VALID CODE REJECTED
!!
!! $ ifx --version
!! ifx (IFX) 2025.1.0 20250317
!!
!! $ ifx -c intel-20250428.f90
!! intel-20250428.f90(39): error #6582: A dummy argument which has the OPTIONAL or the INTENT(OUT) attribute is not allowed in this specification expression.   [THIS]
!!       real :: array2(this%n)
!! ---------------------^
!! intel-20250428.f90(34): error #6582: A dummy argument which has the OPTIONAL or the INTENT(OUT) attribute is not allowed in this specification expression.   [THIS]
!!       real :: array1(this%n)
!! ---------------------^
!! compilation aborted for intel-20250428.f90 (code 1)
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
