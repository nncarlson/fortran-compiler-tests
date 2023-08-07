!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70312
!! Fixed in 12.2.0 and probably much earlier.
!!
!! duplicate of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58175
!!
!! -Wsurprising issues spurious warnings about final procedures.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
!! 
!! $ gfortran -Wsurprising gfortran-bug-20160319.f90 
!! gfortran-bug-20160319.f90:32:6:
!! 
!!    use foo_type
!!       1
!! Warning: Only array FINAL procedures declared for derived type 'foo' defined at (1), suggest also scalar one [-Wsurprising]

module foo_type
  type foo
  contains
    final :: foo_delete, foo_delete_2
  end type
contains
  subroutine foo_delete (this)
    type(foo), intent(inout) :: this
  end subroutine
  subroutine foo_delete_2 (this)
    type(foo), intent(inout) :: this(:)
  end subroutine
end module

program main
  use foo_type
end program
