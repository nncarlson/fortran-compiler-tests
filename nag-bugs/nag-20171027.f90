!! $ nagfor -c nag-bug-20171027.f90 
!! NAG Fortran Compiler Release 6.1(Tozai) Build 6140
!! Panic: nag-bug-20171027.f90: isobject called with the wrong subtree
!! Internal Error -- please report this bug
!! Abort

module example

  type, abstract :: foo
    integer, allocatable :: array(:)
  end type

  type :: bar
    class(foo), allocatable :: x
  end type

contains

  subroutine sub (mask, a)
    type(bar), intent(inout) :: a
    logical :: mask(:)
    print *, any(mask(a%x%array))
    ! workaround that avoids the ICE
    !associate (array => a%x%array)
    !  print *, any(mask(array))
    !end associate
  end subroutine

end module
