!!
!! INTERNAL COMPILER ERROR
!!
!! Update: Now working in 16.1.1.2
!!
!! This is a unit test from https://github.com/nncarlson/petaca stripped
!! down to the bare minimum.  The ICE goes away if anything else is removed.
!!
!! $ xlf2008 ibm-20180301b.f90 
!! /projects/opt/ppc64le/ibm/xlf-15.1.6/xlf/15.1.6/bin/.orig/xlf2008: 1501-230 (S) Internal compiler error; please contact your Service Representative. For more information visit:
!! http://www.ibm.com/support/docview.wss?uid=swg21110810
!! 1501-511  Compilation failed for file ibm-20180301b.f90.
!!

program test_any_scalar_type

  !call test_derived_type_value
  !call test_assignment
  !call test_shallow_assignment

contains

  subroutine test_derived_type_value
    class(*), allocatable :: val
    type point
      !real x, y
    end type
    select type (val)
    type is (point)
    end select
  end subroutine

  subroutine test_assignment
    class(*), allocatable :: val
    type point
      !real x, y
    end type
    select type (val)
    type is (point)
    end select
  end subroutine

  subroutine test_shallow_assignment
    type box
      !integer, pointer :: n => null()
    end type
    !type(box) :: b
  end subroutine

end program
