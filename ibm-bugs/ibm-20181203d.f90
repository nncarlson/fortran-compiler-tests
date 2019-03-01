!! INTERNAL COMPILER ERROR
!!
!! Update: Now working in 16.1.1.2
!!
!! Using xlf 16.1.1-rc3 on power9
!!
!! $ xlf2008 ibm-20181203d.f90
!! ** map_any_type   === End of Compilation 1 ===
!! ** parameter_list_type   === End of Compilation 2 ===
!! ** scalar_func_factories   === End of Compilation 3 ===
!! ** phase_property_table_factory   === End of Compilation 4 ===
!! xlf2008: 1501-230 (S) Internal compiler error; please contact your Service Representative. For more information visit:
!!

module map_any_type
  private
  type :: list_item
    class(*), allocatable :: value
  end type
  type, public :: map_any
    type(list_item), pointer :: first => null()
  end type
end module

module parameter_list_type
  use map_any_type
  type :: parameter_list
    type(map_any) :: params = map_any()
  end type
end module

module scalar_func_factories
contains
  subroutine alloc_scalar_func(params)
    use parameter_list_type
    type(parameter_list) :: params
  end subroutine
end module

module phase_property_table_factory
  use scalar_func_factories
  use parameter_list_type
contains
  subroutine init(params)
    type(parameter_list) :: params
  end subroutine
end module

! INTERNAL COMPILER ERROR ON THIS PROGRAM UNIT
program test_init_phase_property_table
  use phase_property_table_factory, only: init
end program
