!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94463
!!
!! LINK FAILURE
!!
!! In this example the compiler generates a reference to the undefined
!! symbol __vtab_scalar_func_class_Scalar_func.3804. The example is split
!! across two source files (see gfortran-20200402-file1.f90). Note that
!! the symbol __scalar_func_class_MOD___vtab_scalar_func_class_Scalar_func
!! is defined in gfortran-20200402-file1.o.
!!
!! This failure appears to occur for all versions of gfortran.
!!
!! $ gfortran gfortran-20200402-file1.f90 -c
!! $ gfortran gfortran-20200402-file2.f90 gfortran-20200402-file1.o
!! /usr/bin/ld: /tmp/ccNS7CfH.o: in function `__fubar_MOD_edit_short':
!! gfortran-20200402-file2.f90:(.text+0x1f): undefined reference to `__vtab_scalar_func_class_Scalar_func.3905'
!! /usr/bin/ld: gfortran-20200402-file2.f90:(.text+0x8f): undefined reference to `__vtab_scalar_func_class_Scalar_func.3905'
!! collect2: error: ld returned 1 exit status
!!

module material_model_type
contains
  subroutine alloc_phase_prop(func)
    use scalar_func_class, only: scalar_func
    class(scalar_func), allocatable, intent(out) :: func
  end subroutine
end module

module fubar
contains
  subroutine edit_short
    use material_model_type, only: alloc_phase_prop
    use scalar_func_class, only: scalar_func
    class(scalar_func), allocatable :: f
    call alloc_phase_prop(f)
  end subroutine
end module

end
