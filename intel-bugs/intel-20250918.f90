! ifx -c intel-20250918.f90 -o intel-20250918.o
! tested triggering ICE with ifx 2023.2 through 2025.2.

module bar_type

  implicit none
  private

  public :: bar_destroy ! removing this line sidesteps the ICE

  type, public :: bar
  contains
    final :: bar_destroy
  end type bar

  ! removing this block sidesteps the ICE
  interface bar_destroy
    module procedure bar_destroy
  end interface bar_destroy

contains

  subroutine bar_destroy(this)
    type(bar), intent(inout) :: this
  end subroutine

end module bar_type


module foo_type

  implicit none

  type :: foo
  contains
    procedure :: f
  end type

contains

  subroutine f(this, x)
    ! using the entire bar_type module (no "only") sidesteps the ICE
    use bar_type, only: bar
    class(foo), intent(in) :: this
    type(bar), intent(in) :: x
  end subroutine

end module foo_type
