!! fixed in 6.0 (1052)
!!
!! IMPOSSIBLE NEGATIVE ALLOCATION
!!
!! This code example produces the following internal runtime error:
!!
!!   % nagfor -C -PIC file1.f90 file2.f90
!!   NAG Fortran Compiler Release 6.0(Hibiya) Build 1049
!!
!!   % ./a.out
!!    ABOUT TO DO SOURCED ALLOCATION OF F
!!   Runtime Error: Impossible negative allocation (please report this bug).
!!   Program terminated by fatal error
!!   Aborted (core dumped)
!!
!! The error is produced by the marked sourced allocation statement near the
!! bottom of file1.f90
!!
!! The error disappears if the code is compiled with different options,
!! though I do not believe the bug is associated with either -C or -PIC,
!! or if even the slightest change is made to the code, such as changing
!! the name of a module or subroutine.
!!
!! With some alterations, a different runtime error is produced at the same
!! sourced allocation statement:
!!
!!   Runtime Error: file1.f90, line 147: ALLOCATE failed: Out of memory
!!
!! The error occurs on both Fedora 20 (gcc 4.8.3) and Fedora 21 (gcc 4.9.2).
!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!! We define an empty abstract base SCALAR_FUNC class and then several concrete
!! extensions of it.  All this is just type declaration; any procedures are not
!! referenced, nor are they exported (but deleting them causes the error to
!! disappear.

module scalar_func_class
  type, abstract :: scalar_func
  end type scalar_func
end module


module const_scalar_func_type
  use scalar_func_class
  type, extends(scalar_func) :: const_scalar_func
    real :: const = 0.0
  end type const_scalar_func
end module


module poly_scalar_func_type
  use scalar_func_class
  type, extends(scalar_func) :: poly_scalar_func
    integer :: emin = 0
    integer :: emax = 0
    real, allocatable :: c(:)
  end type
  private :: poly_scalar_func_value
contains
  !! PROCEDURE IS NOT REFERENCED
  function poly_scalar_func_value () result (f)
    type(poly_scalar_func) :: f
  end function
end module

!! Here is another extension of the SCALAR_FUNC base class.  This one has an
!! allocatable polymorphic SCALAR_FUNC component.  The public procedure
!! allocates a polymorphic variable of this specific type and completely
!! defines its components (and subcomponents) with some arbitrary data.

module my_func_type

  use scalar_func_class

  type, extends(scalar_func) :: my_func
    class(scalar_func), allocatable :: cte
  end type

contains

  subroutine alloc_my_func (rho, stat, errmsg)

    use poly_scalar_func_type

    class(scalar_func), allocatable, intent(out) :: rho
    integer :: stat
    character(*) :: errmsg  ! UNUSED

    type(my_func), allocatable :: this

    allocate(this)
    allocate(poly_scalar_func :: this%cte)
    select type (x => this%cte)
    type is (poly_scalar_func)
      allocate(x%c(2))
      x%c(2) = 0.0
    end select
    call move_alloc (this, rho)
    stat = 0

  end subroutine

end module

!! This module exports absolutely nothing, but is USEd
!! Deleting it causes the error to disappear.

module scalar_func_factories_EXPORTS_NOTHING
  use scalar_func_class
  private
contains
  !! PROCEDURE IS NOT REFERENCED
  subroutine alloc_const_scalar_func (f, const)
    use const_scalar_func_type
    class(scalar_func), allocatable, intent(out) :: f
    real, intent(in) :: const
    allocate(f, source=const_scalar_func(const))
  end subroutine
  !! PROCEDURE IS NOT REFERENCED
  subroutine alloc_poly_scalar_func (f, c, e, x0)
    class(scalar_func), allocatable, intent(out) :: f
    real, intent(in) :: c(:)
    integer, intent(in) :: e(:)
    real, intent(in), optional :: x0
  end subroutine
end module

!! This module holds a derived type pointer whose sole component is an
!! allocatable polymorphic SCALAR_FUNC variable.  One routine allocates
!! the pointer and moves the allocation of a passed polymorphic variable
!! to the component.  The other routine makes a copy of the component
!! using sourced allocation -- this is where the error occurs

module module_with_ptr_object

  use scalar_func_class

  type, private :: node
    class(scalar_func), allocatable :: f
  end type
  type(node), pointer, save :: ptr => null()

contains

  subroutine move_func_to_ptr_component (f)
    class(scalar_func), allocatable, intent(inout) :: f
    allocate(ptr)
    call move_alloc (f, ptr%f)
  end subroutine

  subroutine get_copy_of_ptr_func_component (f)
    class(scalar_func), allocatable, intent(out) :: f
    print *, 'ABOUT TO DO SOURCED ALLOCATION OF F'
    allocate(f, source=ptr%f)  ! <========================= ERROR OCCURS HERE
    print *, 'DONE!'
  end subroutine

end module
