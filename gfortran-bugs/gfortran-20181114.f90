! It is necessary that these modules be in a separate file from the test program.

module foo_class

  ! Remove this unnecessary line to change where the error occurs.
  use,intrinsic :: iso_fortran_env, only: real32
  implicit none
  private

  type, abstract, public :: foo
  contains
    ! Remove the non_overridable attribute to change where the error occurs.
    procedure, non_overridable :: call_me

    ! Swap these two lines to change where the error occurs.
    procedure :: never_call1
    procedure(func), deferred  :: f
  end type foo

  abstract interface
    integer function func(this)
      import foo
      class(foo), intent(in) :: this
    end function
  end interface

contains

  subroutine call_me(this)
    class(foo), intent(in) :: this
    integer :: x
    ! This call to f gets interpreted as a call to never_call1,
    ! despite the fact they don't even have the same interface.
    x = this%f()
  end subroutine call_me

  ! There are no calls to this procedure, but a runtime
  ! error complains about recursive calls to never_call1.
  subroutine never_call1(this, x)
    class(foo), intent(in) :: this
    integer, intent(out) :: x
    x = this%f()
  end subroutine never_call1

end module foo_class


module bar_class

  use foo_class
  implicit none
  private

  type, extends(foo), public :: bar
  contains
    ! Remove the non_overridable attribute to remove the error entirely.
    procedure, non_overridable :: f ! deferred procedure from foo
    procedure :: never_call2
  end type bar

contains

  integer function f(this)
    class(bar), intent(in) :: this
    f = 0
  end function f

  ! If the "use,intrinsic..." line is removed, and this function is removed
  ! along with the procedure line in the bar type, the error goes away.
  subroutine never_call2(this, x1, x2, x3)
    class(bar), intent(in) :: this
    integer, intent(in)  :: x1, x2
    integer, intent(out) :: x3
    ! Remove this line and "use,intrinsic..." line to get a segfault.
    call this%call_me()
    x3 = 0
  end subroutine never_call2

end module bar_class
