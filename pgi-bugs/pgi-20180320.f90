!!
!! MOVE_ALLOC WITH POLYMORPHIC ARGUMENTS LOSES DYNAMIC TYPE
!!
!! Incorrect results with 15.10, 16.10, 17.10, and 18.1
!! Fixed in 18.10
!!
!! Originates from https://github.com/nncarlson/yajl-fort/blob/master/src/json.F90
!! 
!! $ pgfortran --version
!! pgfortran 18.1-1 64-bit target on x86-64 Linux -tp haswell
!!
!! $ pgfortran pgi-20180320.f90
!! sn-fey1.lanl.gov> ./a.out
!!  wrong type after move_alloc
!!     2
!!

type, abstract :: json_value
end type

type, extends(json_value) :: json_integer
  integer :: value
end type

type :: json_builder
  class(json_value), allocatable :: result
end type

class(json_value), allocatable :: val

call sub(val)

contains

  subroutine sub(value)

    class(json_value), allocatable, intent(out) :: value
    type(json_builder) :: builder

    allocate(builder%result, source=json_integer(42))
    select type (result => builder%result)
    type is (json_integer)
    class default
      stop 1
    end select

    call move_alloc(builder%result, value)

    select type (value)
    type is (json_integer)
    class default
      print *, 'wrong type after move_alloc'
      stop 2
    end select

  end subroutine

end
