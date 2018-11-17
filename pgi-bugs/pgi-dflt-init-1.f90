!! ICE WITH DEFAULT INITIALIZATION OF DT COMPONENT
!!
!! Fixed in 18.10
!!
!! $ pgfortran --version
!! pgfortran 18.4-0 64-bit target on x86-64 Linux -tp nehalem 
!! $ pgfortran pgi-dflt-init-1.f90 
!! PGF90-S-0000-Internal compiler error. dinits:bad dt      54  (pgi-dflt-init-1.f90: 19)
!! PGF90-S-0000-Internal compiler error. assem.c-put_skip old,new not in sync      16  (pgi-dflt-init-1.f90: 19)
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
