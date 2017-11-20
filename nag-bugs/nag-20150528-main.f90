
module sm_module

  use module_with_ptr_object
  use const_scalar_func_type
  use scalar_func_factories_EXPORTS_NOTHING
  use my_func_type

contains

  subroutine solid_mech_init
    call define_ptr_object_and_contents
    call get_ptr_object_func
  end subroutine

  subroutine define_ptr_object_and_contents

    integer :: stat
    class(scalar_func), allocatable :: unused1, unused2, dummy, rho
    character(80) :: errmsg
    character(:), allocatable :: unused3

    allocate(const_scalar_func :: dummy)

    call alloc_my_func (rho, stat, errmsg)
    if (stat /= 0) errmsg = 'x' // trim(errmsg) ! NOT EXECUTED
    call move_func_to_ptr_component (rho)

  end subroutine

  subroutine get_ptr_object_func 
    class(scalar_func), allocatable :: f
    call get_copy_of_ptr_func_component (f)
  end subroutine

end module sm_module

program main
  use sm_module
  call solid_mech_init
end program
