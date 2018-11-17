!! DEFAULT INITIALIZATION WITH VALID EMPTY CONSTRUCTOR REJECTED
!!
!! Fixed in 18.10
!!
!! This adds a final procedure for ITEM to pgi-dflt-init-1.f90
!!
!! $ pgfortran --version
!! pgfortran 18.4-0 64-bit target on x86-64 Linux -tp nehalem 
!! $ pgfortran pgi-dflt-init-2.f90 
!! PGF90-F-0155-Empty structure constructor() - type map (pgi-dflt-init-2.f90: 21)
!! PGF90/x86-64 Linux 18.4-0: compilation aborted

module map_type
  type :: item
    type(item), pointer :: next => null(), prev => null()
  contains
    final :: item_delete
  end type
  type :: map
    type(item), pointer :: first => null()
  end type
  type :: parameter_list
    type(map) :: params = map() ! VALID EMPTY CONSTRUCTOR REJECTED BY PGFORTRAN
  end type
contains
  subroutine item_delete(this)
    type(item), intent(inout) :: this
  end subroutine
end module
