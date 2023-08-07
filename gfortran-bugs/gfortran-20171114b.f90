!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82996
!! Fixed in 12.2.0 and possibly earlier
!!
!! The original example gave an error when automatically applying the
!! elemental final procedure to the B array component of the BAR object.
!! So let's add a final procedure to the BAR type (not necessary) that
!! explicitly calls FOO_DESTROY on the B array component.  Here's what
!! happens:
!!
!! $ gfortran -g gfortran-bug-20171114b.f90 
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

  elemental subroutine foo_destroy(this)
    type(foo), intent(inout) :: this
    if (associated(this%f)) deallocate(this%f)
  end subroutine
  
  subroutine bar_destroy(this)
    type(bar), intent(inout) :: this
    call foo_destroy(this%b)
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
