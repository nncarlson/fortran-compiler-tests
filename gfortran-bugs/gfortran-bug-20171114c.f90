!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82996
!!
!! Okay, so maybe the elemental final procedure is causing the problem.
!! Let's drop the elemental attribute, and change BAR_DESTROY to loop
!! over the individual elements of the B array, calling the now scalar
!! final procedure for each element.  Note that the final procedure
!! should not be implicitly called now because it doesn't match the
!! B array component.  Here's what happens now
!!
!! $ gfortran -g gfortran-bug-20171114c.f90 
!! f951: internal compiler error: in generate_finalization_wrapper, at fortran/class.c:1975
!! Please submit a full bug report,
!! with preprocessed source if appropriate.
!! See <http://bugzilla.redhat.com/bugzilla> for instructions.

module mod

  type foo
    integer, pointer :: f(:) => null()
  contains
    final :: foo_destroy
  end type
  
  type bar
    type(foo) :: b(2)
  contains
    final :: bar_destroy
  end type

contains

  subroutine foo_destroy(this)
    type(foo), intent(inout) :: this
    if (associated(this%f)) deallocate(this%f)
  end subroutine
  
  subroutine bar_destroy(this)
    type(bar), intent(inout) :: this
    integer :: j
    do j = 1, size(this%b)
      call foo_destroy(this%b(j))
    end do
  end subroutine

end module

program main

  use mod
  type(bar) :: x
  call sub(x)
  
contains

  subroutine sub(x)
    type(bar), intent(out) :: x
  end subroutine

end program
