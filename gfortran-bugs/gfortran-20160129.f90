!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69563
!!
!! In the following example the call to X%SUB should resolve to SUB_ARRAY, but
!! instead the compiler incorrectly resolves it to the elemental SUB_ELEM, but
!! then emits an error (as it must) because the the THIS argument is not also
!! an array.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
!! 
!! $ gfortran gfortran-bug-20160129.f90 
!! gfortran-bug-20160129.f90:49:8:
!! 
!!    call x%sub ([1,2])
!!         1
!! Error: Actual argument at (1) for INTENT(INOUT) dummy 'this' of ELEMENTAL subroutine 'sub_elem' is a scalar, but another actual argument is an array

module a_type

  type :: a
    integer :: n
  contains
    procedure :: sub_elem
    procedure :: sub_array
    generic :: sub => sub_elem, sub_array
  end type

contains

  elemental subroutine sub_elem (this, arg)
    class(a), intent(inout) :: this
    integer, intent(in) :: arg
    this%n = arg
  end subroutine

  subroutine sub_array (this, arg)
    class(a), intent(inout) :: this
    integer, intent(in) :: arg(:)
    this%n = sum(arg)
  end subroutine

end module

program main

  use a_type
  type(a) :: x, y(2)

  call x%sub ([1,2])
  call y%sub ([1,2])

  print '(a,i2,a)', 'x%n=', x%n, ' (expect 3)'
  print '(a,2i2,a)', 'y%n=', y%n, ' (expect 1 2)'

end program
