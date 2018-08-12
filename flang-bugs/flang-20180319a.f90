!! https://github.com/flang-compiler/flang/issues/240
!! This adds a PREV component to flang-20170923c.f90
!! Fixed as of 8/12/2018.
!!
!! This is with the 3/19/2018 flang version.
!!
!! $ flang -c flang-20180319a.f90
!! F90-S-0000-Internal compiler error. emit_init:bad dt      54  (flang-20180319a.f90: 20)
!! F90-S-0000-Internal compiler error. assem.c-put_skip old,new not in sync      16  (flang-20180319a.f90: 20)
!!   0 inform,   0 warnings,   2 severes, 0 fatal for map_type
!!
!! New error with 543785e7 (20180615):
!! $ flang -c flang-20180319a.f90
!! /tmp/flang-20180319a-ce0d9c.ll:9:73: error: constant expression type mismatch
!!   ...= global %struct_map_type_10_ < { i8*  null,  [16 x i8]  [ i8 0,i8 0,i8 ...
!!                                                               ^
!! 1 error generated.

module map_type
  type :: item
    type(item), pointer :: next => null(), prev => null()
  end type
  type :: map
    type(item), pointer :: first => null()
  end type
  type :: parameter_list
    type(map) :: params = map() ! this default initializaton causes the ICE
  end type
end module
