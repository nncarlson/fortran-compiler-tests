!!
!! REJECTS VALID CODE
!!
!! The Intel 18 compiler rejects the following code with this error:
!!
!! $ ifort -c intel-20190901.f90 
!! intel-20190901.f90(14): error #6437: A subroutine or function is calling itself recursively.   [UPDATE_]
!!     if (same_type_as(this, other)) call this%update_(other)
!! ---------------------------------------------^
!!
!! However there are no recursive calls here whatsoever. The fact that
!! update and update_ have the same interface is irrelevant.
!!

module example

  type, abstract :: base_class
  contains
    procedure, non_overridable :: update
    procedure(update), deferred :: update_
  end type

contains

  subroutine update(this, other)
    class(base_class), intent(inout) :: this
    class(base_class), intent(in) :: other
    if (same_type_as(this, other)) call this%update_(other)
  end subroutine

end module
