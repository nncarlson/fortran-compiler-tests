!!
!! INCORRECT ASSIGNMENT TO ALLOCATABLE CHARACTER VARIABLE
!!
!! Update: Now working in 16.1.1.2
!!
!! The following example assigns to a an allocatable character variable.
!! The variable is allocated but its length parameter is set to 0 which
!! is incorrect.  A key to the error seems to be that the allocation
!! occur within a TYPE IS clause with RHS an unlimited polymorphic.
!!
!! This is from https://github.com/nncarlson/petaca/blob/master/src/parameter_entry_class.F90
!!
!! Expected result is "foo"; xlf gives "":
!!
!! $ xlf2008 -qversion
!! IBM XL Fortran for Linux, V15.1.6 (Community Edition)
!! Version: 15.01.0006.0001
!!
!! $ xlf2008 ibm-20180306b.f90 
!! ** main   === End of Compilation 1 ===
!! 1501-510  Compilation successful for file ibm-20180306b.f90.
!!
!! $ ./a.out
!!  ""
!! STOP 2

program main
  implicit none
  type any_scalar
    class(*), allocatable :: val
  end type
  type(any_scalar) :: x
  character(:), allocatable :: a
  allocate(x%val, source='foo')
  call sub(x, a)
  if (.not.allocated(a)) stop 1
  print *, '"', a, '"'
  if (len(a) /= 3) stop 2
  if (a /= 'foo') stop 3
contains
  subroutine sub(y, s)
    type(any_scalar), intent(in) :: y
    character(:), allocatable, intent(out) :: s
    select type (val => y%val)
    type is (character(*))
      s = val	! LEN PARAMETER NOT BEING SET CORRECTLY FOR S
    end select
  end subroutine
end
