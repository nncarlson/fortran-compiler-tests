!! https://github.com/flang-compiler/flang/issues/240
!! This adds a PREV component to flang-20170923c.f90
!!
!! This is with the 3/19/2018 flang version.
!!
!! $ flang -c flang-20180319a.f90
!! F90-S-0000-Internal compiler error. emit_init:bad dt      54  (flang-20180319a.f90: 20)
!! F90-S-0000-Internal compiler error. assem.c-put_skip old,new not in sync      16  (flang-20180319a.f90: 20)
!!   0 inform,   0 warnings,   2 severes, 0 fatal for map_type

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
